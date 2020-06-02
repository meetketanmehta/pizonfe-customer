import 'package:flutter/material.dart';
import 'package:pizon_customer/screens/ProductListScreen.dart';

class CategoryWidget extends StatelessWidget {
  final String _id;
  final String category;
  final String catImageUri;

  CategoryWidget(this._id, this.category, this.catImageUri);

  factory CategoryWidget.fromJSON(Map<String, dynamic> json) =>
      CategoryWidget(json['_id'], json['category'], json['catImageUri']);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => ProductList()));
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.network(
            this.catImageUri,
            height: 80,
            width: 80,
          ),
          Container(
            height: 32,
            child: Text(
              this.category,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              softWrap: true,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
