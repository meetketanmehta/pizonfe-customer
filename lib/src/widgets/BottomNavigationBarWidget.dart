import 'package:flutter/material.dart';
import 'package:pizon_customer/screens/AccountScreen.dart';
import 'package:pizon_customer/screens/HomeScreen.dart';

//class BottomNavigationBarWidget extends StatefulWidget {
//  final int currentIndex;
//  BottomNavigationBarWidget({this.currentIndex});
//  @override
//  _BottomNavigationBarWidgetState createState() =>
//      _BottomNavigationBarWidgetState(currentIndex);
//}
//
//class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
//  int _currentIndex;
//
//  _BottomNavigationBarWidgetState(this._currentIndex);
//
//  void _onSelection(int index) {
//    if(_currentIndex != index) {
//      setState(() {
//        _currentIndex = index;
//      });
//      Navigator.push(context, MaterialPageRoute(builder: (context) => AccountScreen()));
//    }
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return BottomNavigationBar(
//      type: BottomNavigationBarType.fixed,
//      items: const <BottomNavigationBarItem>[
//        BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home')),
//        BottomNavigationBarItem(
//            icon: Icon(Icons.shopping_cart), title: Text('Cart')),
//        BottomNavigationBarItem(
//            icon: Icon(Icons.list), title: Text('Orders')),
//        BottomNavigationBarItem(
//            icon: Icon(Icons.account_circle), title: Text('Account'))
//      ],
//      selectedItemColor: Color(0xfff79c4f),
//      onTap: _onSelection,
//      currentIndex: _currentIndex,
//    );
//  }
//}

class BottomNavigationBarWidget extends StatelessWidget {
  final int currentIndex;

  BottomNavigationBarWidget({this.currentIndex});

  void _onSelection(int index, BuildContext context) {
    if (index == currentIndex) return;
    switch (index) {
      case 0:
        {
          Navigator.pop(context);
          //Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
        }
        break;
      case 3:
        {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AccountScreen()));
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home')),
        BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart), title: Text('Cart')),
        BottomNavigationBarItem(icon: Icon(Icons.list), title: Text('Orders')),
        BottomNavigationBarItem(
            icon: Icon(Icons.account_circle), title: Text('Account'))
      ],
      selectedItemColor: Color(0xfff79c4f),
      onTap: (index) => _onSelection(index, context),
      currentIndex: currentIndex,
    );
  }
}
