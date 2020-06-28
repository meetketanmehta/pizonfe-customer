import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_user_auth/flutter_user_auth.dart';
import 'package:http/http.dart' as http;
import 'package:pizon_customer/models/Address.dart';
import 'package:pizon_customer/res/values/EndPoints.dart';
import 'package:pizon_customer/screens/HomeScreen.dart';
import 'package:pizon_customer/screens/MapScreen.dart';
import 'package:pizon_customer/states/AddressState.dart';
import 'package:shimmer/shimmer.dart';

class UpdateLocationScreen extends StatefulWidget {
  @override
  _UpdateLocationScreenState createState() => _UpdateLocationScreenState();
}

class _UpdateLocationScreenState extends State<UpdateLocationScreen> {
  List<Address> savedAddresses = List<Address>();
  bool loading = true;
  final String endPoint = EndPoints.addresses;

  void fetchData() async {
    var token = await UserAuth.getAuthToken();
    print(token);
    var responseData =
        await http.get(endPoint, headers: {"authorizationToken": token});

    var responseBody = jsonDecode(responseData.body);

    if (responseData.statusCode == 200) {
      setState(() {
        print(responseData.statusCode);
        for (Map category in responseBody) {
          savedAddresses.add(Address.fromJson(category));
//          print(savedAddresses.last.addName);
        }
        loading = false;
      });
      return;
    }

    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (loading == true) {
      print("\n\n" + "HELLO");
    }
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xfff79c4f)),
          onPressed: Navigator.of(context).pop,
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: width * .05, right: width * .05),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: Text("Search for your location",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  padding: EdgeInsets.only(left: width * .025),
                  width: width * .85,
                  height: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: Color.fromRGBO(204, 204, 204, 1)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * .70,
                        child: TextField(
                          cursorColor: Color(0xfff79c4f),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Address search e.g. Aravali Villa's",
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: Row(children: <Widget>[
                    Expanded(child: Divider()),
                    Text(
                      "OR",
                      style: TextStyle(color: Color.fromRGBO(204, 204, 204, 1)),
                    ),
                    Expanded(child: Divider()),
                  ]),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (_) => MapScreen()));
                    },
                    child: Row(
                      children: <Widget>[
                        Container(
                            margin: EdgeInsets.only(right: 5),
                            child: Icon(Icons.location_on,
                                color: Color(0xfff79c4f))),
                        Container(child: Text("Select location from map"))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10),
            child:
                Divider(thickness: 5, color: Color.fromRGBO(204, 204, 204, 1)),
          ),
          Container(
              padding: EdgeInsets.only(left: width * .05, right: width * .05),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: loading
                          ? Text("")
                          : Text(
                              "Saved Addresses",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            )),
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: new ListView.builder(
                        shrinkWrap: true,
                        itemCount: loading ? 2 : savedAddresses.length,
                        itemBuilder: (BuildContext context, int idx) {
                          if (loading == false) {
                            Address curr = savedAddresses[idx];
                            return GestureDetector(
                              onTap: () {
                                AddressState.selectedAddress = curr;
                                print("\n\n: " +
                                    AddressState.selectedAddress.completeAdd);
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => HomeScreen()),
                                    (route) => false);
                              },
                              child: Container(
                                margin: EdgeInsets.only(bottom: 10),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                        margin: EdgeInsets.only(right: 5),
                                        child: myIcon(curr.addType)),
                                    Container(
                                      width: width * .80,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                            padding: EdgeInsets.only(
                                                top: 4, bottom: 4),
                                            child: Text(
                                              curr.addType,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Text(
                                            curr.completeAdd,
                                            softWrap: true,
                                            maxLines: 3,
                                            overflow: TextOverflow.clip,
                                            textAlign: TextAlign.left,
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          } else {
                            return _shimmerEffect(0);
                          }
                        }),
                  )
                ],
              ))
        ],
      ),
    );
  }

  Widget myIcon(String type) {
    if (type == "Office") {
      return Icon(Icons.work, color: Color(0xfff79c4f));
    } else if (type == "Home") {
      return Icon(Icons.home, color: Color(0xfff79c4f));
    }
    return Icon(Icons.location_on, color: Color(0xfff79c4f));
  }

  Widget _shimmerEffect(int count) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * .85,
      height: 100.0,
      child: Shimmer.fromColors(
          baseColor: Colors.grey[300],
          highlightColor: Colors.grey[100],
          child: Container(
            margin: EdgeInsets.all(22.0),
            color: Colors.white,
          )),
    );
  }
}
