import 'package:geolocator/geolocator.dart';

class Address {
  String addName;
  String completeAdd;
  String addType;
  String landmark;
  var coordinates = [];

  Address({
    this.addName,
    this.completeAdd,
    this.addType,
    this.landmark,
    this.coordinates
  });

  Address.fromJson(Map<String, dynamic> json){
    addName = json['addName'];
    completeAdd = json['completeAdd'];
    addType = json['addType'];
    landmark = json['landmark'];
    coordinates = json['coordinates'];
  }

  Address.fromPlacemark(Placemark placemark){
    addName= placemark.name;
    completeAdd = placemark.name + placemark.locality +placemark.administrativeArea + placemark.country +"," +placemark.postalCode;
  }
}



