import 'package:flutter/material.dart';
import 'package:flutter_user_auth/flutter_user_auth.dart';
import 'package:pizon_customer/screens/ChangePassword.dart';
import 'package:pizon_customer/src/widgets/LogoWidget.dart';
// import 'package:pizon_customer/screens/ChangePassword.dart';
import 'package:pizon_customer/src/widgets/BottomNavigationBarWidget.dart';
import 'package:pizon_customer/res/values/Strings.dart';
import 'package:toast/toast.dart';

typedef void UpdateState();

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  bool knownUser = UserAuth.isLogged;

  void changeState() {
    if (knownUser == UserAuth.isLogged) return;
    setState(() {
      knownUser = UserAuth.isLogged;
    });
  }

  @override
  Widget build(BuildContext context) {
    return knownUser
        ? _KnownUserAccountScreen()
        : _UnKnownUserAccountScreen(changeState);
  }
}

class _KnownUserAccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget _tile({String title, Widget icon, onTap}) {
      return InkWell(
        onTap: onTap,
        child: ListTile(
          leading: icon,
          title: Text(
            title,
            style: TextStyle(fontSize: 18),
          ),
        ),
      );
    }

    void _logoutHandler() async {
      await UserAuth.logout();
      Navigator.pop(context);
      Toast.show("Logged Out Successfully", context);
    }

    void _myAddressesHandler() {}

    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Account"),
        elevation: 1,
      ),
      bottomNavigationBar: BottomNavigationBarWidget(
        currentIndex: 3,
      ),
      body: ListView(
        children: <Widget>[
          _tile(
            title: "My Orders",
            icon: Icon(Icons.list),
            onTap: () {},
          ),
          _tile(
            title: "My Wallet",
            icon: Icon(Icons.account_balance_wallet),
            onTap: () {},
          ),
          _tile(
            title: "My Payment Methods",
            icon: Icon(Icons.payment),
            onTap: () {},
          ),
          _tile(
            title: "My Addresses",
            icon: Icon(Icons.location_on),
            onTap: _myAddressesHandler,
          ),
          _tile(
            title: "Contact us",
            icon: Icon(Icons.contact_mail),
            onTap: _myAddressesHandler,
          ),
          _tile(
            title: "Change Password",
            icon: Icon(Icons.refresh),
            onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => ChangePasswordPage()));}),
            
          _tile(
            title: "Logout",
            icon: Icon(Icons.exit_to_app),
            onTap: _logoutHandler,
          ),
        ],
      ),
    );
  }
}

class _UnKnownUserAccountScreen extends StatelessWidget {
  final UpdateState changeState;

  _UnKnownUserAccountScreen(this.changeState);

  Widget _loginButton(BuildContext context) {
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
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [Color(0xfffbb448), Color(0xfff7892b)],
          ),
        ),
        child: InkWell(
          onTap: () async {
            await UserAuth.login(context);
            changeState();
          },
          child: Center(
            child: Text(
              Strings.loginTitle,
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  Widget _registerButton(BuildContext context) {
    return InkWell(
      onTap: () async {
        await UserAuth.signUp(context);
        changeState();
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 13),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          border: Border.all(color: Color(0xfff7892b), width: 2),
        ),
        child: Text(
          Strings.registerTitle,
          style: TextStyle(fontSize: 20, color: Color(0xfff7892b)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Theme.of(context).primaryColorLight,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 20, right: 20, top: 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            LogoWidget(),
            SizedBox(
              height: 140,
            ),
            _loginButton(context),
            SizedBox(
              height: 30,
            ),
            _registerButton(context),
          ],
        ),
      ),
    );
  }
}
