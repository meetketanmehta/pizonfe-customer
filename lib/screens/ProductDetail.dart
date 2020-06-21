import 'package:flutter/material.dart';
import 'package:pizon_customer/models/Product.dart';

class ProductDetail extends StatelessWidget {
  final Hero _hero;
  // final Hero _hero;
  ProductDetail(this._hero);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flippers Page'),
      ),
      body: Container(
        padding: const EdgeInsets.all(8.0),
        alignment: Alignment.topLeft,
        // Use background color to emphasize that it's a new route.
        color: Colors.lightBlueAccent,
        child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          this._hero,
          RaisedButton(
            onPressed: () {print(this._hero.tag);},
            child: Text('Disabled Button', style: TextStyle(fontSize: 20)),
          ), ])
      ),
    );
  }

  void _back(BuildContext context) {
    Navigator.pop(context);
  }
}
