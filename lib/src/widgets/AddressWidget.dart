import 'package:flutter/material.dart';

class AddressWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {

      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.6,
        child: Row(
          children: <Widget>[
            Icon(Icons.location_on, color: Color(0xfff79c4f),),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Address for delivery', style: TextStyle(color: Colors.grey, fontSize: 13),),
                    Text('Home', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                  ],
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}