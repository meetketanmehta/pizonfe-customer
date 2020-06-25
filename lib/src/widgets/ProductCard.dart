import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pizon_customer/models/Pricing.dart';
import 'package:pizon_customer/models/Product.dart';
import 'package:pizon_customer/screens/ProductDetail.dart';

class ProductCard extends StatefulWidget {
  Product product;

  ProductCard({Key key, this.product}) : super(key: key);

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  void _navigate(BuildContext context, Hero hero, Product item) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => ProductDetail(hero, item)));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 1,
        // onTap: () =>
        //     Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        //   return ProductDetail(item: product);
        // })),
        child: InkWell(
            child: Container(
                height: 130,
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Row(children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width * 0.32,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Image.network(
                            widget.product.imageUri,
                            height: 90,
                            width: 90,
                          ),
                        ]),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.60,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                widget.product.title,
                                style: TextStyle(color: Colors.grey),
                                maxLines: 1,
                              ),
                              Text(widget.product.description != null
                                  ? widget.product.description
                                  : widget.product.subCategory +
                                      " (" +
                                      widget.product.selectedPricing.options +
                                      ")"),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 8),
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(width: 1, color: Colors.grey),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4))),
                            child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.50,
                                height: 30,
                                child: InkWell(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text("See more options.."),
                                      Icon(
                                        Icons.arrow_drop_down,
                                        size: 25,
                                        color: Colors.grey,
                                      )
                                    ],
                                  ),
                                  onTap: () => {
                                    _showAlertDialog(context, widget.product)
                                  },
                                )),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                "Rs " +
                                    widget.product.selectedPricing.price
                                        .toString(),
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              GestureDetector(
                                onTap: () => {
                                  this._navigate(
                                      context,
                                      Hero(
                                          tag: widget.product,
                                          child: SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.7,
                                            child: Image.network(
                                              widget.product.imageUri,
                                            ),
                                          )),
                                      widget.product),
                                  print(widget.product.pricing)
                                },
                                child: Hero(
                                    tag: widget.product,
                                    child: Text(
                                      "VIEW",
                                      style:
                                          TextStyle(color: Color(0xfff79c4f)),
                                    )),
                              )
                            ],
                          ),
                        ]),
                  ),
                ]))));
  }

  Future<dynamic> _showAlertDialog(
      BuildContext context, Product product) async {
    // show the dialog
    void function(Pricing pricing) {
      setState(() {
        product.selectedPricing = pricing;
      });
      Navigator.of(context).pop();
    }

    Widget _pricingButton(
        BuildContext context, Pricing pricing, Pricing selectedPricing) {
      return Card(
        elevation: 1,
        child: InkWell(
          highlightColor: Color(0xfff79c4f),
          child: Container(
            height: 40,
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(pricing.storeName),
                Text(pricing.options),
                Text("Rs: " + pricing.price.toString())
              ],
            ),
          ),
          onTap: () => {function(pricing)},
        ),
      );
    }

    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Text("Select Product"),
            children: <Widget>[
              Container(
                height: (25 + 40 * (product.pricing.length).toInt()).toDouble(),
                child: ListView.builder(
                    itemCount: product.pricing.length,
                    itemBuilder: (BuildContext context, int id) {
                      return _pricingButton(context, product.pricing[id],
                          product.selectedPricing);
                    }),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  InkWell(
                    child: Text("Dismiss"),
                    onTap: () => {Navigator.of(context).pop()},
                  ),
                ],
              )
            ],
          );
        });
  }
}
