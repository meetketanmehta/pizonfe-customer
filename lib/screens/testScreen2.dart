import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// import 'package:pizon_customer/bloc/utils.dart';
import 'package:pizon_customer/bloc/data.dart';
import 'package:pizon_customer/src/widgets/BottomNavigationBarWidget.dart';

class TrackingPage extends StatefulWidget {
  @override
  _TrackingPageState createState() => _TrackingPageState();
}

class _TrackingPageState extends State<TrackingPage> {
  final List<Location> locations = [
    Location('Kolkata Facility', DateTime(2019, 6, 5, 5, 23, 4),
        showHour: false, isHere: false, passed: true),
    Location('Hyderabad Facility', DateTime(2019, 6, 6, 5, 23, 4),
        showHour: false, isHere: false, passed: true),
    Location(
      'Chennai Facility',
      DateTime(2019, 6, 9, 5, 23, 4),
      showHour: false,
      isHere: true,
    ),
    Location(
      'Kerala Facility',
      DateTime(2019, 6, 10, 5, 23, 4),
      showHour: true,
      isHere: false,
    ),
  ];

  String selectedProduct = 'Cadbury Silk 50g';

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          // color: Theme.of(context).primaryColorLight,
          image: DecorationImage(
              image: AssetImage('assets/Group 444.png'), fit: BoxFit.contain)),
      child: Container(
        // color:Colors.black54,
        child: Scaffold(
            appBar: AppBar(
              // backgroundColor: Colors.transparent,
              elevation: 0.0,
              brightness: Brightness.light,
              iconTheme: IconThemeData(color: Colors.grey),
              title: Text(
                'Shipped',
                style: TextStyle(
                  // color: darkGrey,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              leading: SizedBox(),
              actions: <Widget>[CloseButton()],
            ),
            bottomNavigationBar: BottomNavigationBarWidget(
        currentIndex: 0,
      ),
            body: SafeArea(
              child: LayoutBuilder(
                builder:(_,constraints)=> Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16.0),
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      decoration: BoxDecoration(
                          // color: Theme.of(context).primaryColorLight,
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          items: <String>[
                            'Cadbury Silk 50g',
                            'Cadbury Silk 100g',
                            'Cadbury Silk 200g',
                            'Cadbury Silk 300g',
                            'Cadbury Silk 400g',
                            'Cadbury Silk 500g',
                          ].map((val) {
                            return DropdownMenuItem<String>(
                              value: val,
                              child: Container(
                                  // color: Theme.of(context).primaryColorDark,
                                  child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(val,maxLines: 2,semanticsLabel: '...',overflow: TextOverflow.ellipsis, ))),
                            );
                          }).toList(),
                          onChanged: (val) {
                            setState(() {
                              selectedProduct = val;
                            });
                          },
                          value: selectedProduct,
                          isExpanded: true,
                          icon: Icon(Icons.keyboard_arrow_down),
                          elevation: 0,
                        ),
                      ),
                    ),SingleChildScrollView(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(maxHeight: constraints.maxHeight-48,),
                          child: Theme(
                            data:
                                ThemeData(primaryColor: yellow, fontFamily: 'Montserrat'),
                            child: Stepper(
                         physics: NeverScrollableScrollPhysics(),
                              steps: [
                                ...locations
                                    .map(
                                      (location) => Step(
                                        isActive: location.isHere || location.passed,
                                        title: Text(location.city),
                                        subtitle: Text(location.getDate()),
                                        content: Align(
                                          child: Image.asset('assets/icons/truck.png'),
                                          alignment: Alignment.centerLeft,
                                        ),
                                        state: location.passed
                                            ? StepState.complete
                                            : location.isHere
                                                ? StepState.editing
                                                : StepState.indexed,
                                      ),
                                    )
                                    .toList()
                              ],
                              currentStep: locations
                                  .indexOf(locations.firstWhere((loc) => loc.isHere)),
                              controlsBuilder: (BuildContext context,
                                  {VoidCallback onStepContinue,
                                  VoidCallback onStepCancel}) {
                                return Container();
                              },
                            ),
                          ),
                        ),
                      ),

                  ],
                ),
              ),
            )),
      ),
    );
  }
}

class Location {
  String city;
  DateTime date;
  bool showHour;
  bool isHere;
  bool passed;

  Location(this.city, this.date,
      {this.showHour = false, this.isHere = false, this.passed = false});

  String getDate() {
    if (showHour) {
      return DateFormat("K:mm aaa, d MMMM y").format(date);
    } else {
      return DateFormat('d MMMM y').format(date);
    }
  }
}