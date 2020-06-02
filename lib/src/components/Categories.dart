import 'package:flutter/material.dart';
import 'package:pizon_customer/src/widgets/CategoryWidget.dart';
import 'package:pizon_customer/res/values/EndPoints.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';
import 'package:toast/toast.dart';

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  List<CategoryWidget> categories = List<CategoryWidget>();
  bool loading = true;
  final String endPoint = EndPoints.categories;

  _CategoriesState() {
    fetchData();
  }

  void fetchData() async {
    var responseData = await http.get(endPoint);
    var responseBody = jsonDecode(responseData.body);
    if(responseData.statusCode == 200) {
      setState(() {
        for (Map category in responseBody) {
          categories.add(CategoryWidget.fromJSON(category));
        }
        loading = false;
      });
    }
    else {
      Toast.show(responseBody.message, context);
    }
  }

  Widget _shimmerEffect(int count) {
    return Shimmer.fromColors(
      child: GridView.builder(
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemBuilder: (context, __) {
          return Container(
            width: 48,
            height: 48,
            margin: EdgeInsets.all(22.0),
            color: Colors.white,
          );
        },
        itemCount: count,
      ),
      baseColor: Colors.grey[300],
      highlightColor: Colors.grey[100],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16.0),
      child: loading
          ? _shimmerEffect(7)
          : GridView.count(
        shrinkWrap: true,
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
              crossAxisCount: 3,
              children: categories,
            ),
    );
  }
}
