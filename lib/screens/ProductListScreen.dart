import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pizon_customer/models/Address.dart';
import 'package:pizon_customer/models/Product.dart';
import 'package:pizon_customer/res/values/EndPoints.dart';
import 'package:pizon_customer/src/widgets/ProductCard.dart';
import 'package:pizon_customer/states/AddressState.dart';
import 'package:shimmer/shimmer.dart';

class ProductList extends StatefulWidget {
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  List<Product> productsList = List<Product>();
  final String endPoint = EndPoints.products;
  bool loading = true;
  int count = 0;

  void fetchData() async {
    // Address address = await AddressState.getCurrentAddress();

    String paramQuery = "?latitude=";
    // paramQuery += address.coordinates[0].toString();
    // paramQuery += "&longitude=";
    // paramQuery += address.coordinates[1].toString();

    // TODO remove this line
    paramQuery = "?latitude=23.024981&longitude=72.5049347";
    print("Reached here");
    var responseData = await http.get(endPoint + paramQuery);
    var responseBody = jsonDecode(responseData.body);
    count = responseBody.length;
    if (responseData.statusCode == 200) {
      setState(() {
        for (Map productItem in responseBody) {
          productsList.add(Product.fromJson(productItem));
//          print("\n\n\n" + productsList.last.title);
        }
        loading = false;
      });
    } else {
      // TODO handle error
      print("\n\nError");
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unrelated_type_equality_checks
    if (loading == 0) {
      return _shimmerEffect(0);
    } else {
      return Scaffold(
        appBar: AppBar(
          leading: InkWell(
            child: Icon(
              Icons.arrow_back,
              color: Color(0xfff79c4f),
            ),
            onTap: Navigator.of(context).pop,
          ),
          title: Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              "Order Groceries",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        body: ListView.builder(
          itemCount: count>0?count:5,
            itemBuilder: (BuildContext context, int id){
              if (productsList.length > 0)
              return ProductCard(product: productsList[id]);
              else return _shimmerEffect(5);
            }
        ),
      );
    }
  }

  Widget _shimmerEffect(int count) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * .85,
      height: 100.0,
      child: Shimmer.fromColors(
          baseColor: Colors.grey[300],
          highlightColor: Colors.grey[100],
          child: Container(
            margin: EdgeInsets.all(22.0),
            color: Colors.white,
          )),
    );
  }
}
