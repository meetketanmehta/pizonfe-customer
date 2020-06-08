import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pizon_customer/screens/UpdateLocationScreen.dart';
import 'package:pizon_customer/src/widgets/AddressWidget.dart';

class ChangeLocationScreen extends StatefulWidget {
  @override
  _ChangeLocationScreenState createState() => _ChangeLocationScreenState();
}

class _ChangeLocationScreenState extends State<ChangeLocationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: AddressWidget(),
        ),
        body: Column(
          children: <Widget>[
            Center(
              child: Text("We don't deliver here yet"),
            ),
            _changeLocationButton(context)
          ],
        ));
  }
}

Widget _changeLocationButton(BuildContext context) {
  return Material(
    type: MaterialType.transparency,
    child: Ink(
      width: MediaQuery.of(context).size.width,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.grey.shade200,
              offset: Offset(2, 4),
              blurRadius: 5,
              spreadRadius: 2)
        ],
      ),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (_) => UpdateLocationScreen()));
        },
        child: Center(
          child: Text(
            "Change Location",
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
      ),
    ),
  );
}
