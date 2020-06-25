import 'dart:async';
import 'package:pizon_customer/models/Cart.dart';
import 'package:pizon_customer/models/CartProduct.dart';
import 'package:pizon_customer/models/Product.dart';

class CartItemsBloc {
  /// The [cartStreamController] is an object of the StreamController class
  /// .broadcast enables the stream to be read in multiple screens of our app
  final cartStreamController = StreamController.broadcast();
  List<CartProduct> listSlide = List<CartProduct>();

  /// The [getStream] getter would be used to expose our stream to other classes
  Stream get getStream => cartStreamController.stream;
  CartManager cart = new CartManager();
  CartProduct cartProduct;
  int quantity;

  /// The [allItems] Map would hold all the data this bloc provides
  // final Map allItems = {'cart items': []};

  void addToCart(cartProduct,quantity) {
    print("Added to cart");
    this.listSlide.add(cartProduct);
    CartManager.addProduct(cartProduct,quantity);
    cartStreamController.sink.add(cart);
  }

  /// [removeFromCart] removes items from the cart, back to the shop
  void removeFromCart(cartProduct) {
    this.listSlide.remove(cartProduct);
    CartManager.removeProduct(cartProduct);
    cartStreamController.sink.add(cart);
  }
  int viewCart(cartProduct) {
    return CartManager.viewCart(cartProduct);
    // cartStreamController.sink.add(cart);
  }
  bool existsInCart(cartProduct) {
    return CartManager.existsInCart(cartProduct);
    // cartStreamController.sink.add(cart);
  }

  /// The [dispose] method is used
  /// to automatically close the stream when the widget is removed from the widget tree
  void dispose() {
    cartStreamController.close(); // close our StreamController
  }
}
final bloc = CartItemsBloc(); 