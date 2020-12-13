import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:health_body_checking/src/constants/app_colors.dart';
import 'package:health_body_checking/src/models/sensor_model.dart';

import '../../../core/routes/routes.dart';

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
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(Routes.data_visualization);
        },
        child: Container(
          padding: EdgeInsets.all(10),
          width: double.infinity,
          height: 200,
          decoration: BoxDecoration(
              color: AppColors.PRIMARY,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Colors.black12,
                    offset: Offset(0.0, 15.0),
                    blurRadius: 15.0)
              ]
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  width: 130,
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(widget.icon, color: AppColors.WHITE,),
                      Text(widget.sensor.value.toString(), style: TextStyle(fontSize: 25, color: AppColors.WHITE),),
                      Text(widget.name, textAlign: TextAlign.center, style: TextStyle(color: AppColors.WHITE),),
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
      )
    );
  }
}

