import 'package:flutter/material.dart';
class InputTextHeader extends StatelessWidget {
  final String title;
  const InputTextHeader({Key key,@required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(title,
        style: TextStyle(
          fontFamily: "Poppins-Medium",
          fontSize:14
        ),
      ),
    );
  }
}