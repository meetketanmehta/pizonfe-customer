import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_user_auth/flutter_user_auth.dart';

import 'res/values/EndPoints.dart';
import 'res/values/Strings.dart';
import 'screens/HomeScreen.dart';
import 'src/widgets/LogoWidget.dart';

void main() {
  runApp(MyApp());
}

const kBlackHalf = const Color(0xFF212121);
const kBlackLight = const Color(0xFF484848);
const kBlack = const Color(0xFF000000);
const kYellow = const Color(0xFFffd600);
const kYellowLight = const Color(0xFFffff52);
const kYellowDark = const Color(0xFFc7a500);
const kWhite = Colors.white;

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
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      title: 'Pizon',
      theme: ThemeData(
          primaryColor: Colors.white,
          backgroundColor: Colors.black,
          accentColor: Colors.white,
          primaryColorLight: Colors.black,
          primaryColorDark: Colors.black54),
      darkTheme: ThemeData(
        // final ThemeData base = ThemeData();
        primaryColor: Colors.black,
        brightness: Brightness.dark,
        primarySwatch: Colors.orange,
        backgroundColor: Colors.white,
        // primaryColor: Color(0xffd4af37),
        accentColor: Colors.black12,
        primaryColorLight: Colors.white,
        primaryColorDark: Colors.white54


        // scaffoldBackgroundColor: Colors.white54,
        // secondaryHeaderColor: Colors.white
        // backgroundColor: Colors.blueGrey
      ),
      //debugShowCheckedModeBanner: false,
      home: _loading ? _loadingScreen() : HomeScreen(),
    );
  }
}
