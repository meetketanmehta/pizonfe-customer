class Product {
  String id;
  String title;
  String description;
  String brand;
  String category;
  String subCategory;
  String imageUri;
  var pricing = [];

  Product(
      {this.id,
      this.title,
      this.description,
      this.category,
      this.subCategory,
      this.imageUri,
      this.brand,
      this.pricing,});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    category = json['category'];
    subCategory = json['subCategory'];
    imageUri = json['imageUri'];
    brand = json['brand'];
    pricing = json['pricing'];

    //TODO pricing
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

    // return data;
  };
}
