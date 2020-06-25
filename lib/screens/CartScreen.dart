import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pizon_customer/models/Cart.dart';
import 'package:pizon_customer/models/CartProduct.dart';
import 'package:pizon_customer/screens/UpdateLocationScreen.dart';
import 'package:pizon_customer/src/widgets/CartProductCard.dart';
import 'package:pizon_customer/states/AddressState.dart';

import '../res/values/Strings.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreen createState() => _CartScreen();
}

class _CartScreen extends State<CartScreen> {
  var items = Map<String, Map<CartProduct, int>>();

  _CartScreen() {
    //  _initializeCart();
    setValues();
  }

  // void _initializeCart() {
  //   CartManager.setAddress(Address(
  //       completeAdd:
  //           "Plot No 208 - c, Radheshyam Park, Near Jain Derasar, Mahuva"));

  //   var proNames = [
  //     "Dairy Milk Silk HazelNut Chocolate Bar",
  //     "Dairy Milk Silk HazelNut Chocolate Bar",
  //     "Dairy Milk Silk Chocolate Bar",
  //     "Dairy Milk Silk Bubbly Chocolate Bar",
  //     "Oreo Biscuit - Chocolate Creme",
  //     "Potato Chips - Indians Magic Masala",
  //     "Potato Chips - Indians Magic Masala"
  //   ];

  //   var proImageUri = [
  //     "https://pizon-images.s3.amazonaws.com/products/Grocery/Snacks/cadbury-dairy-milk-silk-hazelnut-chocolate-bar.jpg",
  //     "https://pizon-images.s3.amazonaws.com/products/Grocery/Snacks/cadbury-dairy-milk-silk-hazelnut-chocolate-bar.jpg",
  //     "https://pizon-images.s3.amazonaws.com/products/Grocery/Snacks/cadbury-dairy-milk-silk-chocolate-bar.jpg",
  //     "https://pizon-images.s3.amazonaws.com/products/Grocery/Snacks/cadbury-dairy-milk-silk-bubbly-chocolate-bar.jpg",
  //     "https://pizon-images.s3.amazonaws.com/products/Grocery/Snacks/cadbury-oreo-creame-biscuit-chocolate.jpg",
  //     "https://pizon-images.s3.amazonaws.com/products/Grocery/Snacks/lays-potato-chips-indias-magic-masala.jpg",
  //     "https://pizon-images.s3.amazonaws.com/products/Grocery/Snacks/lays-potato-chips-indias-magic-masala.jpg"
  //   ];

  //   var options = ["100 g", "40 g", "50 g", "5 ml", "1 kg", "2 packs", "2 kg"];
  //   var storeName = [
  //     "Pizon Retail",
  //     "ABC Retail",
  //     "Pizon Retail",
  //     "ABC Retail",
  //     "Pizon Retail",
  //     "ABC Retail",
  //     "Pizon Retail"
  //   ];
  //   var prices = [12.0, 15.0, 25.0, 35.0, 45.0, 60.0, 10.0];

  //   for (var i = 0; i < 7; i++) {
  //     CartManager.addProduct(
  //         CartProduct(
  //             Product(title: proNames[i], imageUri: proImageUri[i]),
  //             Pricing(
  //                 options: options[i],
  //                 storeName: storeName[i],
  //                 price: prices[i])),
  //         i + 1);
  //   }
  //   print(CartManager);
  // }

  // void _intialise2 () {
  //   CartManager.cartDetails();
  // }

  void setValues() {
    items.clear();
    CartManager.cartProducts.forEach((cartProduct, quantity) {
      if (items[cartProduct.pricing.storeName] == null) {
        items[cartProduct.pricing.storeName] = Map<CartProduct, int>();
      }
      items[cartProduct.pricing.storeName][cartProduct] = quantity;
    });
    if (AddressState.selectedAddress != null) {
      CartManager.setAddress(AddressState.selectedAddress);
    } else {}
  }

  void increaseQuantity(CartProduct cartProduct) {
    CartManager.increaseQuantity(cartProduct);
    setState(() {
      setValues();
    });
  }

  void decreaseQuantity(CartProduct cartProduct) {
    CartManager.decreaseQuantity(cartProduct);
    setState(() {
      setValues();
    });
  }

  Widget _storeTitle(storeName) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      margin: EdgeInsets.only(bottom: 5),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey)),
      ),
      child: Text(
        storeName,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }

  List<Widget> _cartProductsComponent(storeName) {
    var productsWidgetList = List<Widget>();

    Map<CartProduct, int> products = items[storeName];

    products.forEach((cartProduct, quantity) {
      Widget productWidget = CartProductCard(
        cartProduct: cartProduct,
        quantity: quantity,
        increaseQuantityFunc: increaseQuantity,
        decreaseQuantityFunc: decreaseQuantity,
      );
      productsWidgetList.add(productWidget);
    });

    return productsWidgetList;
  }

  List<Widget> _storesComponent() {
    var stores = List<Widget>();

    items.forEach((storeName, _) {
      Widget storeWidget = Container(
        margin: EdgeInsets.only(bottom: 10),
        padding: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
            // color: Colors.white,
            ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[_storeTitle(storeName)] +
              _cartProductsComponent(storeName),
        ),
      );
      stores.add(storeWidget);
    });

    return stores;
  }

  Widget _finalPriceRow(bool boldTitle, String title, double price) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontWeight: boldTitle ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
        SizedBox(width: 20),
        Text(
          "\u{20B9}" + (price).toString(),
          style: TextStyle(
            fontWeight: boldTitle ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  Widget _finalPrice() {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          // color: Colors.white,
          ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Bill Details", style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(
            height: 10,
          ),
          _finalPriceRow(false, "Items Total", CartManager.getCartTotalPrice()),
          SizedBox(height: 10),
          _finalPriceRow(false, "Delivery Charges", items.length * 20.0),
          Divider(),
          _finalPriceRow(true, "To Pay",
              CartManager.getCartTotalPrice() + items.length * 20.0),
        ],
      ),
    );
  }

  Container _bottomAppBar() {
    return Container(
      decoration: BoxDecoration(
          boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 10)]),
      child: BottomAppBar(
        child: Container(
          height: 60,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Delivery Address",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      CartManager.address != null
                          ? Text(
                              CartManager.address.addType != null
                                  ? CartManager.address.addType
                                  : CartManager.address.completeAdd,
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                            )
                          : Container(
                              padding: EdgeInsets.only(bottom: 2),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (_) => UpdateLocationScreen()));
                                },
                                child: Text(
                                  "Select Address",
                                  style: TextStyle(
                                      color: Color(0xfff7892b),
                                      decoration: TextDecoration.underline,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: RaisedButton(
                  color: Color(0xfff7892b),
                  onPressed: () {
                    //TODO: Place Order Function
                  },
                  child: Center(
                    child: Text(
                      "Place Order",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _emptyCartBody() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.shopping_cart,
            size: 60,
          ),
          SizedBox(height: 20),
          Text("Your cart is empty"),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.cartScreenTitle),
      ),
      bottomNavigationBar: (items.isNotEmpty) ? _bottomAppBar() : null,
      // backgroundColor: Colors.grey[100],
      body: (items.isEmpty)
          ? _emptyCartBody()
          : ListView(
              children: _storesComponent() + <Widget>[_finalPrice()],
            ),
    );
  }
}
