import 'package:flutter/material.dart';
import 'package:pizon_customer/src/widgets/AddressWidget.dart';
import 'package:pizon_customer/src/widgets/BottomNavigationBarWidget.dart';
import 'package:pizon_customer/src/components/Categories.dart';
import 'package:flutter_user_auth/flutter_user_auth.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    debugPrint("User Login Status : " + UserAuth.isLogged.toString());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 1,
        title: AddressWidget(),
      ),
      bottomNavigationBar: BottomNavigationBarWidget(currentIndex: 0,),
      body: Categories(),
    );
  }
}
