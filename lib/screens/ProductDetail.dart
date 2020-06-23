import 'package:flutter/material.dart';
import 'package:pizon_customer/models/Cart.dart';
import 'package:pizon_customer/models/Product.dart';
import 'package:pizon_customer/models/CartProduct.dart';
import 'package:pizon_customer/models/Pricing.dart';
// import 'package:pizon_customer/models/cart.dart';
import 'package:pizon_customer/bloc/bloc_pattern.dart';
import 'package:pizon_customer/src/widgets/BottomNavigationBarWidget.dart';

class ProductDetail extends StatefulWidget {
  final Hero _hero;
  final Product item;

  ProductDetail(this._hero, this.item);
  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  @override
  void initState() {
    super.initState();
    check();
  }

  bool added;
  int index = 0;
  void check() {
    setState(() {
      added = CartManager.existsInCart(CartProduct(
          widget.item, Pricing.fromJson(widget.item.pricing[this.index])));
    });
    print(added);
  }

  void displayPopup() {
    print(widget.item.pricing[this.index]['options']);
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Select Options"),
            content: SizedBox(
              height: MediaQuery.of(context).size.width / 2,
              width: MediaQuery.of(context).size.width - 10,
              child: ListView.separated(
                separatorBuilder: (context, index) => Divider(
                  height: 1,
                  color: Colors.grey,
                ),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: widget.item.pricing.length,
                itemBuilder: (context, id) {
                  print(id);
                  return GestureDetector(
                      onTap: () => {
                            setState(() {
                              this.index = id;
                              print(this.index);
                              check();
                              Navigator.of(context, rootNavigator: true)
                                  .pop('dialog');
                              // Navigator.of(context).pop();
                            })
                          },
                      child: ListTile(
                          title: Text(widget.item.pricing[id]['options'])));
                },
              ),
            ),
            // actions: <Widget>[
            //     FlatButton(
            //         onPressed: () {
            //             Navigator.of(context).pop();
            //     },
            //         child: Container(
            //             color: MobikulTheme.accentColor,
            //             child: Padding(
            //                 padding: EdgeInsets.fromLTRB(
            //                     spacing_normal,
            //                     spacing_generic,
            //                     spacing_normal,
            //                     spacing_generic),
            //                 child: Text(
            //                     ok,
            //                     style: TextStyle(color: Colors.white),
            //                     ),
            //                 ),
            //             ))
            // ],
          );
        });
  }

  // final Hero _hero;
  // final Product item;
  // bool added = false;
  CartManager cartManager = new CartManager();
  // final Hero _hero;
  // ProductDetail(this._hero, this.item);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: new Text(widget.item.title),
          leading: InkWell(
            child: Icon(
              Icons.arrow_back,
              color: Color(0xfff79c4f),
            ),
            onTap: Navigator.of(context).pop,
          ),
        ),
        bottomNavigationBar: BottomNavigationBarWidget(
          currentIndex: 0,
        ),
        body: Container(
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.topLeft,
            // Use background color to emphasize that it's a new route.
            color: Theme.of(context).accentColor,
            child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              widget._hero,
              // RaisedButton(
              //   onPressed: () {
              //     print(this.item.pricing[0]["options"]);
              //   },
              //   child: Text('Disabled Button', style: TextStyle(fontSize: 20)),
              // ),
              SizedBox(
                height: 10,
              ),

              Expanded(
                  flex: 1,
                  child:
                      Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(
                          left: 15, right: 15, top: 20, bottom: 20),
                      color: Theme.of(context).primaryColor,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text("Options".toUpperCase(),
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Theme.of(context).primaryColorDark)),
                          Text(
                              widget.item.pricing[this.index]["options"] != null
                                  ? widget.item.pricing[this.index]["options"]
                                  : 'null',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Theme.of(context).primaryColorLight)),
                          IconButton(
                              onPressed: () => {this.displayPopup()},
                              icon: Icon(
                                Icons.arrow_forward_ios,
                                color: Color(0xFF999999),
                              ))
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          left: 15, right: 15, top: 20, bottom: 20),
                      color: Theme.of(context).primaryColor,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text("Price".toUpperCase(),
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Theme.of(context).primaryColorDark)),
                          Text(
                              widget.item.pricing[this.index]["price"] != 0
                                  ? widget.item.pricing[this.index]["price"]
                                      .toString()
                                  : 'null',
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
                      padding: EdgeInsets.only(
                          left: 15, right: 15, top: 20, bottom: 20),
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
                          Text(
                              widget.item.brand != null
                                  ? widget.item.brand +
                                      ',' +
                                      widget.item.category +
                                      ',' +
                                      widget.item.subCategory
                                  : 'null',
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
                    // cartItemsBloc.listSlide.contains(CartProduct(this.item,Pricing.fromJson(this.item.pricing[0])))?
                    this.added
                        ? RaisedButton(
                            color: Theme.of(context).primaryColorDark,
                            onPressed: () {
                              setState(() => this.added = false);

                              print(this.added);
                              CartManager.removeProduct(CartProduct(
                                  widget.item,
                                  Pricing.fromJson(
                                      widget.item.pricing[this.index])));
                              // bloc.removeFromCart(CartProduct(this.item,Pricing.fromJson(this.item.pricing[0])));
                            },
                            child: Text('Remove from Cart',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Theme.of(context).primaryColor)),
                          )
                        : RaisedButton(
                            color: Theme.of(context).primaryColorDark,
                            onPressed: () {
                              setState(() => this.added = true);

                              // this.item.pricing[0]["price"] = this.item.pricing[0]["price"].toDouble();
                              // bloc.addToCart(CartProduct(this.item,Pricing.fromJson(this.item.pricing[0])),2);
                              CartManager.addProduct(
                                  CartProduct(
                                      widget.item,
                                      Pricing.fromJson(
                                          widget.item.pricing[this.index])),
                                  1);
                              print(widget.item.pricing[this.index]["options"]);
                            },
                            child: Text('Add to Cart',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Theme.of(context).primaryColor)),
                          ),
                    RaisedButton(
                      color: Theme.of(context).primaryColorDark,
                      onPressed: () {
                        print(CartManager.cartDetails());
                      },
                      child: Text('View Cart',
                          style: TextStyle(
                              fontSize: 20,
                              color: Theme.of(context).primaryColor)),
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
                  ]))
            ])));
  }

  void _back(BuildContext context) {
    Navigator.pop(context);
  }
}
