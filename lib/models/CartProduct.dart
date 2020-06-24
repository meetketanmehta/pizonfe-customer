
import 'Product.dart';
import 'Pricing.dart';
import 'package:equatable/equatable.dart';

class CartProduct extends Equatable{
  final Product product;
  final Pricing pricing;

  CartProduct(this.product, this.pricing);

  @override
  List<Object> get props => [product.title, product.id, pricing.storeName, pricing.options];
}