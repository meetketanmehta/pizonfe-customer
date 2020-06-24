import 'package:flutter/material.dart';
import 'package:pizon_customer/models/Product.dart';

class ProductDetail extends StatelessWidget {
  final Hero _hero;
  final Product item;
  // final Hero _hero;
  ProductDetail(this._hero, this.item);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text(this.item.title),
        leading: InkWell(
          child: Icon(
            Icons.arrow_back,
            color: Color(0xfff79c4f),
          ),
          onTap: Navigator.of(context).pop,
        ),
      ),
      body: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.topLeft,
          // Use background color to emphasize that it's a new route.
          color: Theme.of(context).accentColor,
          child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
            this._hero,
             RaisedButton(
               onPressed: () {
                 print(this.item.pricing[0].options);
               },
               child: Text('Disabled Button', style: TextStyle(fontSize: 20)),
             ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding:
                  EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 20),
              color: Theme.of(context).primaryColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Options".toUpperCase(),
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Theme.of(context).primaryColorDark)),
                  Text(this.item.pricing[0].options!=null?this.item.pricing[0].options:'null',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Theme.of(context).primaryColorLight)),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Color(0xFF999999),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding:
                  EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 20),
              color: Theme.of(context).primaryColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Price".toUpperCase(),
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Theme.of(context).primaryColorDark)),
                  Text(this.item.pricing[0].price!=0?this.item.pricing[0].price.toString():'null',
                      style: TextStyle(
                          color: Theme.of(context).primaryColorLight,
                          fontFamily: 'Roboto-Light.ttf',
                          fontSize: 20,
                          fontWeight: FontWeight.w500)),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              alignment: Alignment.topLeft,
              width: double.infinity,
              padding:
                  EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 20),
              color: Theme.of(context).primaryColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Description",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Theme.of(context).primaryColorDark)),
                  SizedBox(
                    height: 15,
                  ),
                  Text(this.item.brand!=null?this.item.brand+','+this.item.category+','+this.item.subCategory:'null',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).primaryColorLight)),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            RaisedButton(
              color: Theme.of(context).primaryColorDark,
              onPressed: () {
                print(this.item.pricing[0].options);
              },
              child: Text('Add to Cart', style: TextStyle(fontSize: 20, color: Theme.of(context).primaryColor)),
            ),
            // Container(
            //   alignment: Alignment.topLeft,
            //   width: double.infinity,
            //   padding: EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 20),
            //   color: Color(0xFFFFFFFF),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: <Widget>[
            //       Text("Specification",
            //           textAlign: TextAlign.left,
            //           style: TextStyle(
            //               fontSize: 16,
            //               fontWeight: FontWeight.w700,
            //               color: Color(0xFF565656))),
            //       SizedBox(
            //         height: 15,
            //       ),
            //       Column(
            //         children: generateProductSpecification(context),
            //       )
            //     ],
            //   ),
            // )
          ])),
    );
  }

  void _back(BuildContext context) {
    Navigator.pop(context);
  }
}
