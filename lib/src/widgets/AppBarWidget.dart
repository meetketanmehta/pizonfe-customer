import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget {
  final Widget child;
  AppBarWidget(this.child);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey))),
      child: child,
    );
  }
}