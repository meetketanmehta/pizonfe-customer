import 'package:geolocator/geolocator.dart';

class Address {
  String addName;
  String completeAdd;
  String addType;
  String landmark;
  var coordinates = [];

  Address(
      {this.addName,
      this.completeAdd,
      this.addType,
      this.landmark,
      this.coordinates});

  Address.fromJson(Map<dynamic, dynamic> json) {
    this.addName = json['addName'];
    this.completeAdd = json['completeAdd'];
    this.addType = json['addType'];
    this.landmark = json['landmark'];
    coordinates = json['coordinates'];
  }

  Address.fromPlacemark(Placemark placemark) {
    this.addName = placemark.name;
    this.coordinates.add(placemark.position.longitude);
    this.coordinates.add(placemark.position.latitude);

    this.completeAdd = placemark.name +
        placemark.locality +
        placemark.administrativeArea +
        placemark.country +
        "," +
        placemark.postalCode;
  }
}
