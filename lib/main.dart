import 'package:flutter/material.dart';
import 'package:flutter_user_auth/flutter_user_auth.dart';

import 'res/values/EndPoints.dart';
import 'res/values/Strings.dart';
import 'screens/HomeScreen.dart';
import 'src/widgets/LogoWidget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _loading = true;
  bool _fetchingAddress = true;

  _MyAppState() {
    _initializeUserAuth();
  }

  void _initializeUserAuth() async {
    AuthConfig _authConfig = AuthConfig(
      loginConfig: LoginConfig(endPoint: EndPoints.login),
      registerConfig: RegisterConfig(
          endPoint: EndPoints.register, userType: Strings.userType),
    );
    await UserAuth.initialize(_authConfig);
    setState(() {
      _loading = false;
    });
  }

  Widget _loadingScreen() {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: LogoWidget(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pizon',
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      //debugShowCheckedModeBanner: false,
      home: _loading ? _loadingScreen() : HomeScreen(),
    );
  }
}
