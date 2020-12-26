import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:health_body_checking/src/constants/app_colors.dart';
import 'package:health_body_checking/src/models/sensor_model.dart';
import 'package:health_body_checking/src/ui/monitor/widgets/sensor_card.dart';


class MonitorScreen extends StatefulWidget {
  MonitorScreen({Key key}) : super(key: key);

  @override
  _MonitorScreenState createState() => _MonitorScreenState();
}

class _MonitorScreenState extends State<MonitorScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _monitor(),
    );
  }


  Widget _monitor() {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: ListView.builder(
          itemCount: sensors.length,
          itemBuilder: (context, index) {
            return SensorCard(sensor: sensors[index]);
          },
        ),
    );
  }
}
