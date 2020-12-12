import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:health_body_checking/src/constants/app_colors.dart';
import 'package:health_body_checking/src/models/sensor_model.dart';

class SensorCard extends StatefulWidget {

  final SensorModel sensor;
  final String name;
  final IconData icon;
  final VoidCallback inputFunction;
  SensorCard({Key key, this.sensor, this.name, this.icon, this.inputFunction}) : super(key: key);

  @override State createState() => SensorCardState();
}

class SensorCardState extends State<SensorCard> {

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Container(
        padding: EdgeInsets.all(20),
        width: double.infinity,
        height: 200,
        decoration: BoxDecoration(color: AppColors.WHITE, borderRadius: BorderRadius.circular(10),
          boxShadow: [BoxShadow(color: Colors.black12, offset: Offset(0.0, 15.0), blurRadius: 15.0)]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 150,
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(widget.icon),
                  Text(widget.sensor.value.toString(), style: TextStyle(fontSize: 25),),
                  Text(widget.name, textAlign: TextAlign.center,),
                ],
              )
            ),
            Expanded(
              child: Container(

              )
            )
          ],
        ),
      ),
    );
  }
}

