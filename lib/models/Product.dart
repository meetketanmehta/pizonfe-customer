class Product {
  String id;
  String title;
  String description;
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
      this.pricing});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    category = json['category'];
    subCategory = json['subCategory'];
    imageUri = json['imageUri'];

    //TODO pricing
  }
}
