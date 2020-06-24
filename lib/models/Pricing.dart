import 'dart:convert';
class Pricing {
  double price;
  String storeId;
  String options;
  String storeName;

  Pricing({this.price, this.storeId, this.options, this.storeName});

  Pricing.fromJson(Map<dynamic, dynamic> json) {
    this.price = json["price"].toDouble();
    this.storeId = json["storeId"];
    this.options = json["options"];
    this.storeName = json["storeName"];
  }
}
