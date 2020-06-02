import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pizon_customer/src/widgets/ProductCard.dart';

class ProductList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            ProductListHeader(),
            ProductCard(),
            ProductCard(),
            ProductCard()
          ],
        ),
      ),
    );
  }
}

class ProductListHeader extends StatelessWidget {
  const ProductListHeader({Key key, this.productCategory = "Groceries"})
      : super(key: key);

  final String productCategory;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 1,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(15),
        child: Row(
          children: <Widget>[
            InkWell(
              child: Icon(
                Icons.arrow_back,
                color: Color(0xfff79c4f),
              ),
              onTap: Navigator.of(context).pop,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                "Order " + this.productCategory,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
