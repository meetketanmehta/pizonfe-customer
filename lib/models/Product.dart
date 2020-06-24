import 'package:pizon_customer/models/Pricing.dart';

class Product {
  String id;
  String title;
  String description;
  String brand;
  String category;
  String subCategory;
  String imageUri;
  var pricing = [];
  Pricing selectedPricing;

  Product(
      {this.id,
      this.title,
      this.description,
      this.category,
      this.subCategory,
      this.imageUri,
      this.brand,
      this.pricing,
      this.selectedPricing});

  Product.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    category = json['category'];
    subCategory = json['subCategory'];
    imageUri = json['imageUri'];
    brand = json['brand'];
    for(Map price in json['pricing']){
      pricing.add(Pricing.fromJson(price));
      if(selectedPricing ==null){
        selectedPricing = pricing.last;
      }
      else{
        if(selectedPricing.price > pricing.last.price){
          selectedPricing = pricing.last;
        }
      }
    }

  }
  Map<String, dynamic> toJson() => {
    // final Map<String, dynamic> data = new Map<String, dynamic>();

    'id':id,
    'title':title,
    'description':description,
    'category':category,
    'subCategory':subCategory,
    'imageUri':imageUri,
    'brand':brand,
    'pricing':pricing,
    'selectedPricing': selectedPricing,

    // return data;
  };
}
