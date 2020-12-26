import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:health_body_checking/src/services/base.service.dart';
import 'package:health_body_checking/src/services/hearth_service.dart';
import 'package:health_body_checking/src/services/imc_service.dart';
import 'package:health_body_checking/src/services/oxygen_saturation_service.dart';
import 'package:health_body_checking/src/services/temperature_service.dart';

import '../../constants/custom_icons..dart';
import '../../models/sensor_model.dart';
import '../../models/user_model.dart';
import 'widgets/sensor_card.dart';

class MonitorScreen extends StatefulWidget {
  MonitorScreen({Key key}) : super(key: key);

  @override
  _MonitorScreenState createState() => _MonitorScreenState();
}

class _MonitorScreenState extends State<MonitorScreen> {
  @override
  void initState() {
    super.initState();
  }
  List<SensorModel> items = [SensorModel(value: 35.6, time: Timestamp(10, 5)), SensorModel(value: 35.6, time: Timestamp(10, 5)), SensorModel(value: 35.6, time: Timestamp(10, 5)), SensorModel(value: 35.6, time: Timestamp(10, 5))];
  List<IconData> icons = [
    CustomIcons.icons["ppm"],
    CustomIcons.icons["weight_scale"],
    CustomIcons.icons["temperature"],
    CustomIcons.icons["hearth"],
  ];
  Map<String,BaseService> _services={
    "Temperatura":new TemperatureService(),
    "Oximetro":new OxygenSaturationService(),
    "HearthRate":new HearthRateService(),
    "Imc":new ImcService()
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _monitor(),
    );
  }


  Widget _monitor() {
    return  ListView.builder(
        itemCount: CurrentUserModel.instance.sensors.length,
        itemBuilder: (context, index) {
          return(CurrentUserModel.instance.sensors[index].enabled)? SensorCard(
            icon: CustomIcons.icons[CurrentUserModel.instance.sensors[index].icon],
            name:CurrentUserModel.instance.sensors[index].displayName,
            sensor:CurrentUserModel.instance.sensors[index],
            service: this._services[CurrentUserModel.instance.sensors[index].sensorName],
            minValue: CurrentUserModel.instance.sensors[index].minValue,
            maxValue: CurrentUserModel.instance.sensors[index].maxValue,
            unitOfMeasurement: CurrentUserModel.instance.sensors[index].unitOfMeasurement,
          ):SizedBox();
        },
      );
  }

}
