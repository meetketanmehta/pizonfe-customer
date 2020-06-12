import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Completer<GoogleMapController> _controller = Completer();

  static LatLng _center;

  @override
  void initState() {
    super.initState();
  }

  Future<Position> _updateLocation() async {
    return Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.lowest
    );
  }

  void _goToCurrentLocation() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: _center, zoom: 15)));
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _updateLocation(),
      builder: (BuildContext context, AsyncSnapshot<Position> snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else {
          _center = LatLng(snap.data.latitude, snap.data.longitude);
          return mapWidget(context, _center);
        }
      },
    );
  }

  Widget mapWidget(BuildContext context, LatLng latLng) {
    return MaterialApp(
        theme: ThemeData(primaryColor: Color(0xfff79c4f)),
        home: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            title: Text('Set delivery location'),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * .78,
                width: MediaQuery.of(context).size.width,
                child: GoogleMap(
                  zoomControlsEnabled: false,
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: latLng,
                    zoom: 15.0,
                  ),
                ),
              ),
              _registerButton(context)
            ],
          ),
          floatingActionButton: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height * .1),
            child: FloatingActionButton(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              child: Icon(Icons.my_location),
              onPressed: _goToCurrentLocation,
              mini: true,
            ),
          ),
        ));
  }
}

Widget _registerButton(BuildContext context) {
  return InkWell(
    child: Container(
      width: MediaQuery.of(context).size.width * .8,
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.symmetric(vertical: 8),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        border: Border.all(color: Color(0xfff7892b), width: 2),
      ),
      child: Text(
        "Out of Coverage",
        style: TextStyle(fontSize: 20, color: Color(0xfff7892b)),
      ),
    ),
  );
}
