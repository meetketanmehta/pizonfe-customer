import 'Address.dart';
import 'CartProduct.dart';

class CartManager {
  static Address address;
  static var cartProducts = Map<CartProduct, int> ();

  static void setAddress(Address add) {
    address = add;
  }

  static Address getAddress() {
    return address;
  }

  static void changeAddress(Address add) {
    cartProducts.clear();
    address = add;
  }

  static void addProduct(CartProduct cartProduct, int quantity) {
    cartProducts[cartProduct] = quantity;
  }

  static void removeProduct(CartProduct cartProduct) {
    cartProducts.remove(cartProduct);
  }

  static void increaseQuantity(CartProduct cartProduct) {
    cartProducts[cartProduct]++;
  }

  static void decreaseQuantity(CartProduct cartProduct) {
    cartProducts[cartProduct]--;
    if(cartProducts[cartProduct] == 0) {
      cartProducts.remove(cartProduct);
    }
  }

  static int getQuantity(CartProduct cartProduct) {
    return cartProducts[cartProduct];
  }

  static double getCartTotalPrice() {
    double totalPrice = 0;
    cartProducts.forEach((cartProduct, quantity) {
      totalPrice += (cartProduct.pricing.price * quantity);
    });
    return totalPrice;
  }
}


