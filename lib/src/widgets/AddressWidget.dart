import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
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
    var position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placemark = await Geolocator()
        .placemarkFromCoordinates(position.latitude, position.longitude);

    // TODO: Redirect to change address page if no service area
    setState(() {
      address = Address.fromPlacemark(placemark[0]);
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _getUsersCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
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
                              address.completeAdd,
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
            ],
          ),
        ));
  }
}
