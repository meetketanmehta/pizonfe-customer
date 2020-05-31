import 'package:flutter/material.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  final int currentIndex;
  BottomNavigationBarWidget({this.currentIndex});
  @override
  _BottomNavigationBarWidgetState createState() =>
      _BottomNavigationBarWidgetState(currentIndex);
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
  int _currentIndex;

  _BottomNavigationBarWidgetState(this._currentIndex);

  void _onSelection(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home')),
        BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart), title: Text('Cart')),
        BottomNavigationBarItem(
            icon: Icon(Icons.category), title: Text('Orders')),
        BottomNavigationBarItem(
            icon: Icon(Icons.verified_user), title: Text('Profile'))
      ],
      selectedItemColor: Color(0xfff79c4f),
      onTap: _onSelection,
      currentIndex: _currentIndex,
    );
  }
}
