import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:pizon_customer/models/Address.dart';
import 'package:pizon_customer/screens/UpdateLocationScreen.dart';
import 'package:pizon_customer/states/AddressState.dart';

class AddressWidget extends StatefulWidget {
  @override
  _AddressWidgetState createState() => _AddressWidgetState();
}

class _AddressWidgetState extends State<AddressWidget> {
  Address address;
  bool isLoading = true;

  void _getUsersCurrentLocation() async {

    //TODO check if location is off

    var position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    List<Placemark> placemark = await Geolocator()
        .placemarkFromCoordinates(position.latitude, position.longitude);

    // TODO: Redirect to change address page if no service area
    setState(() {
      address = Address.fromPlacemark(placemark[0]);
      AddressState.currentAddress = address;
      isLoading = false;
    });
  }

  _AddressWidgetState() {
    _getUsersCurrentLocation();
  }

  @override
  void initState() {
    super.initState();
    if (AddressState.currentAddress != null) {
      print("\n\n\n" + AddressState.currentAddress.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    if(AddressState.selectedAddress!=null)isLoading=false;
    return GestureDetector(
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => UpdateLocationScreen()));
        },
        child: Container(
          width: MediaQuery.of(context).size.width * 0.6,
          child: Row(
            children: <Widget>[
              Icon(
                Icons.location_on,
                color: Color(0xfff79c4f),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Address for delivery',
                        style: TextStyle(color: Colors.grey, fontSize: 13),
                      ),
                      isLoading == false
                          ? Text(
                              AddressState.selectedAddress != null
                                  ? AddressState.selectedAddress.addType
                                  : address.addName + "..",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            )
                          : Text(
                              "Loading...",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                    ],
                  ),
                ),
              ),
              Icon(Icons.keyboard_arrow_down)
            ],
          ),
        ));
  }
}
