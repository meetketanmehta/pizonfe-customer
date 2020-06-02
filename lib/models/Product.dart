class Product {
  String proId;
  String proName;
  String proDesc;
  String proCat;
  String proSub;
  String proImageUri;

  Product({
    this.proId,
    this.proName,
    this.proDesc,
    this.proCat,
    this.proSub,
    this.proImageUri,
  });

  Product.fromJson(Map<String, dynamic> json) {
    proId = json['proId'];
    proName = json['proName'];
    proDesc = json['proDesc'];
    proCat = json['proCat'];
    proSub = json['proSub'];
    proImageUri = json['proImageUri'];
  }
}
