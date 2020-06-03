import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class UpdateLocationScreen extends StatefulWidget {
  @override
  _UpdateLocationScreenState createState() => _UpdateLocationScreenState();
}

class _UpdateLocationScreenState extends State<UpdateLocationScreen> {

  @override
  Widget build(BuildContext context) {
    double width= MediaQuery.of(context).size.width;
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
            padding: EdgeInsets.only(left: width*.05, right: width*.05),
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
                  padding: EdgeInsets.only(left: width*.025),
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
                  child: Row(
                    children: <Widget>[
                      Container(margin: EdgeInsets.only(right: 5),child: Icon(Icons.location_on, color: Color(0xfff79c4f))),
                      Container(child: Text("Select location from map"))
                    ],
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
              padding: EdgeInsets.only(left: width*.05, right: width*.05),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: Text("Saved Addresses",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15))),
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                            margin: EdgeInsets.only(right: 5),
                            child: Icon(Icons.home, color: Color(0xfff79c4f))),
                        Container(
                          width: width*.80,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(top:4, bottom:4),
                                child: Text(
                                  "Home",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Text(
                                "2110 N. King St.Suite 1Honolulu, Hawaii 96819Phone: (808) 832-6468Fax: (808) 832-6465",
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
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                            margin: EdgeInsets.only(right: 5),
                            child: Icon(Icons.home, color: Color(0xfff79c4f))),
                        Container(
                          width: width*.80,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(top:4, bottom:4),
                                child: Text(
                                  "Home",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Text(
                                "2110 N. King St.Suite 1Honolulu, Hawaii 96819Phone: (808) 832-6468Fax: (808) 832-6465",
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
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                            margin: EdgeInsets.only(right: 5),
                            child: Icon(Icons.home, color: Color(0xfff79c4f))),
                        Container(
                          width: width*.80,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(top:4, bottom:4),
                                child: Text(
                                  "Home",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Text(
                                "2110 N. King St.Suite 1Honolulu, Hawaii 96819Phone: (808) 832-6468Fax: (808) 832-6465",
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
                  )
                ],
              ))
        ],
      ),
    );
  }
}
