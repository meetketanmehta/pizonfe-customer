import 'package:flutter/material.dart';
import 'package:pizon_customer/models/CartProduct.dart';

typedef void ChangeQuantity(CartProduct cartProduct);

class CartProductCard extends StatelessWidget {
  final CartProduct cartProduct;
  final int quantity;
  final ChangeQuantity increaseQuantityFunc;
  final ChangeQuantity decreaseQuantityFunc;

  CartProductCard({
    this.cartProduct,
    this.quantity,
    this.increaseQuantityFunc,
    this.decreaseQuantityFunc,
  });

  Widget _quantityRow() {
    return Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          border: Border.all(color: Colors.grey),
        ),
        child: Row(
          children: <Widget>[
            InkWell(
              child: Icon(Icons.remove, size: 16, color: (quantity == 1) ? Colors.grey : Color(0xfff79c4f)),
              onTap: () {
                decreaseQuantityFunc(cartProduct);
              },
            ),
            SizedBox(width: 10),
            Container(
              width: 18,
              child: Center(child: Text(quantity.toString())),
            ),
            SizedBox(width: 10),
            InkWell(
              child: Icon(Icons.add, size: 16, color: Color(0xfff79c4f)),
              onTap: () {
                increaseQuantityFunc(cartProduct);
              },
            ),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: <Widget>[
          Container(
            height: 60,
            width: 60,
            padding: EdgeInsets.symmetric(vertical: 5),
            child: Image.network(
              cartProduct.product.imageUri,
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  cartProduct.product.title,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 2,
                ),
                Text(
                  cartProduct.pricing.options,
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
          SizedBox(width: 10),
          _quantityRow(),
          SizedBox(width: 20),
          Container(
            width: 50,
            child: Center(
              child: Text("\u{20B9} " +
                  (cartProduct.pricing.price * quantity).toString()),
            ),
          ),
        ],
      ),
    );
  }
}
