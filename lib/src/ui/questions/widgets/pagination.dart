import 'package:flutter/material.dart';
import 'package:health_body_checking/src/constants/app_colors.dart';

class PaginationText extends StatelessWidget {
  final int total;
  final int actual;
  const PaginationText({Key key,@required this.total,@required this.actual}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Pregunta",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 12),
        ),
        Text(
          actual.toString() + "/" + total.toString(),
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20)
        ),
      ],
    );
  }
}
