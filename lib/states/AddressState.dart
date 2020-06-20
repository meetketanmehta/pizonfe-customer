import 'package:geolocator/geolocator.dart';
import 'package:pizon_customer/models/Address.dart';

class AddressState {
  static Address currentAddress = new Address();
  static bool loading = true;

  static Future<Address> getCurrentAddress() async {

    var position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    List<Placemark> placemark = await Geolocator()
        .placemarkFromCoordinates(position.latitude, position.longitude);

    loading = false;
//    print("\n\n\n" + placemark[0].position.latitude.toString() + " " + placemark[0].position.longitude.toString());
    return Address.fromPlacemark(placemark[0]);
  }
}

final addressState = AddressState();