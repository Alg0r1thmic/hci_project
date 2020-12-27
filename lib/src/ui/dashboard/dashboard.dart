import 'dart:convert';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:health_body_checking/src/models/sensor_model.dart';
import 'package:health_body_checking/src/services/hearth_service.dart';
import 'package:health_body_checking/src/services/imc_service.dart';
import 'package:health_body_checking/src/services/oxygen_saturation_service.dart';
import 'package:health_body_checking/src/services/temperature_service.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:graphic/graphic.dart' as graphic;


import '../../constants/app_colors.dart';
import '../../models/user_model.dart';
import '../../services/base.service.dart';


class DashboardScreen extends StatefulWidget {
  DashboardScreen({Key key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  var list;
  double value;

  bool thereAreChallenges = false;


  var basicData = [
    { 'genre': 'Cardiovascular', 'sold': 275 },
    { 'genre': 'Respiratorias', 'sold': 115 },
    { 'genre': 'Virus y bacterias', 'sold': 120 },
    { 'genre': 'Shooter', 'sold': 350 },
    { 'genre': 'Otro', 'sold': 150 },
  ];

  Map<String,BaseService> _services={
    "Temperatura":new TemperatureService(),
    "Oximetro":new OxygenSaturationService(),
    "HearthRate":new HearthRateService(),
    "Imc":new ImcService()
  };

  Map<String, String> _images = {
    "Healthy": "assets/images/health.png",
    "High IMC": "assets/images/high_imc.png",
    "High OS": "assets/images/high_oxygen_saturation",
    "Fever": "assets/images/warning.png"
  };

  Map<String, double> lastValues = {
    "Temperatura": 0.0,
    "Oximetro": 0.0,
    "HearthRate": 0.0,
    "Imc": 0.0
  };

  @override
  void initState() {
    super.initState();
  }

  getDisease(){

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: ListView(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Alimentacion", textAlign: TextAlign.start, style: TextStyle(fontSize: 16),),
                  thereAreChallenges ? _getChallenges() : _makeNoChallenge()
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Actividad fisica", textAlign: TextAlign.start, style: TextStyle(fontSize: 16),),
                  thereAreChallenges ? _getChallenges() : _makeNoChallenge()
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 25),
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Mapa de riesgo", textAlign: TextAlign.start, style: TextStyle(fontSize: 16),),
                  _riksMap()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _getChallenges() {
    return Row(
      children: [
        Expanded(child: _makeChallenge(10.0, '1 fruta diaria', '1 semana')),
        Expanded(child: _makeChallenge(50.0, 'Caminar 15 min', '1 semana'))
      ],
    );
  }

  Widget _makeChallenge(double percent, String cantidad, String duracion) {
    return InkWell(
      onTap: (){

      },
      child: SfRadialGauge(
        axes: <RadialAxis>[
          RadialAxis(
            minimum: 0,
            maximum: 100,
            showLabels: false,
            showTicks: false,
            startAngle: 270,
            endAngle: 270,
            annotations: <GaugeAnnotation>[
              GaugeAnnotation(
                  positionFactor: 0.1,
                  angle: 90,
                  widget: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                          text: percent.toStringAsFixed(0) + ' / 100\n',
                          style: TextStyle(fontSize: 20, color: Colors.black),
                          children: <TextSpan> [
                            TextSpan(
                                text: duracion.toString() + '\n' + cantidad.toString(),
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black
                                )
                            )
                          ]
                      )
                  )
              )
            ],
            pointers: <GaugePointer>[
              RangePointer(
                value: percent,
                cornerStyle: CornerStyle.bothCurve,
                width: 0.2,
                sizeUnit: GaugeSizeUnit.factor,
              )
            ],
            axisLineStyle: AxisLineStyle(
              thickness: 0.2,
              cornerStyle: CornerStyle.bothCurve,
              color: Color.fromARGB(30, 0, 169, 181),
              thicknessUnit: GaugeSizeUnit.factor,
            ),
          )
        ],
      ),
    );
  }

  Widget _makeNoChallenge() {
    return InkWell(
      onTap: (){

      },
      child: Card(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          child: Column(
            children: [
              Icon(Icons.add, color: AppColors.PRIMARY,),
              Text('Nuevo reto', style: TextStyle(color: AppColors.PRIMARY),)
            ],
          ),
        ),
      ),
    );
  }

  Widget _riksMap() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: _health(),
    );
  }

  String getImage() {
    if (lastValues["Imc"] > 30.0) return _images["High IMC"];
    else if (lastValues["Oximetro"] > 100.0) return _images["High OS"];
    else return _images["Healthy"];
  }

  Widget _health() {
    return Column(
      children: [
        Container(
          height: 90,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: _sensors(),
          ),
        ),
        Container(
          width: 350,
          height: 300,
          child: graphic.Chart(
            data: basicData,
            scales: {
              'genre': graphic.CatScale(
                accessor: (map) => map['genre'] as String,
              ),
              'sold': graphic.LinearScale(
                accessor: (map) => map['sold'] as num,
                nice: true,
              )
            },
            coord: graphic.PolarCoord(),
            geoms: [graphic.IntervalGeom(
              position: graphic.PositionAttr(field: 'genre*sold'),
              adjust: graphic.DodgeAdjust(),
              color: graphic.ColorAttr(field: 'sold', values: [AppColors.PRIMARY,Colors.yellow, Colors.red]),
            )],
            axes: {
              'genre': graphic.Defaults.circularAxis,
              'sold': graphic.Defaults.radialAxis
                ..label = null,
            },
          ),
        ),

      ],
    );
  }



  Widget _lastValue(SensorModel sensor) {
    return StreamBuilder<Object>(
        stream: _services[sensor.sensorName].lastDocumentsStream(1),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<dynamic> list = snapshot.data;
            value = list.last.value;
            lastValues[sensor.sensorName] = value;
            return Card(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: _getIcon(sensor),
                    ),
                    Container(
                      width: 100,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                              text: TextSpan(
                                  text: value.toStringAsFixed(1),
                                  style: TextStyle(fontSize: 16, color: Colors.black),
                                  children: <TextSpan> [
                                    TextSpan(
                                        text: " " + sensor.unitOfMeasurement,
                                        style: TextStyle(fontSize: 12, color: Colors.black87)
                                    ),
                                  ]
                              )
                          ),
                          Text(
                              sensor.displayName,
                              style: TextStyle(fontSize: 12, color: Colors.black87)
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return Center(child: CircularProgressIndicator(),);
        });
  }

  Icon _getIcon(SensorModel sensor) {
    if (lastValues[sensor.sensorName] > sensor.maxValue)
      return Icon(Icons.upload_rounded, color: Colors.red, size: 15);
    else if (lastValues[sensor.sensorName] < sensor.minValue)
      return Icon(Icons.download_rounded, color: Colors.blue, size: 15);
    else return Icon(Icons.check, color: AppColors.PRIMARY, size: 15);
  }

  List<Widget> _sensors() {
    List<Widget> list = List<Widget>();
    for (var sensor in CurrentUserModel.instance.sensors) {
      if(sensor.enabled) {
        list.add(
            _lastValue(sensor)
        );
      }
    }
    return list;
  }

}
