import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pizon_customer/src/widgets/ProductCard.dart';

class ProductList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
      body: Column(
        children: <Widget>[
          ProductCard(),
          ProductCard(),
          ProductCard()
        ],
      ),
    );
  }
}
