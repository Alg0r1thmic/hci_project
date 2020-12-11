import 'package:flutter/material.dart';
class FormCard extends StatelessWidget {
  final List<Widget> cardItems;
  const FormCard({Key key, this.cardItems}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   return Container(
      width: double.infinity,
      padding: EdgeInsets.only(bottom: 1),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 2.0,
            spreadRadius: 0.0,
            offset: Offset(2.0, 2.0), // shadow direction: bottom right
          )
        ]
      ),
      child: Padding(
        padding: EdgeInsets.only(
          left: 16.0,
          right: 16.0,
          top: 16.0
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:this.cardItems
        ),
      )
    );
  }
}