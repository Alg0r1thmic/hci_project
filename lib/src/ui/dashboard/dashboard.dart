
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:health_body_checking/src/models/challenge_model.dart';
import 'package:health_body_checking/src/models/sensor_model.dart';
import 'package:health_body_checking/src/services/hearth_service.dart';
import 'package:health_body_checking/src/services/imc_service.dart';
import 'package:health_body_checking/src/services/oxygen_saturation_service.dart';
import 'package:health_body_checking/src/services/temperature_service.dart';
import 'package:graphic/graphic.dart' as graphic;
import '../../core/routes/routes.dart';


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
    thereAreChallenges = (currentChallenge != null);
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
                  thereAreChallenges ? _makeChallengeFood() : _makeNoChallenge()
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 25),
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Actividad fisica", textAlign: TextAlign.start, style: TextStyle(fontSize: 16),),
                  thereAreChallenges ? _makeChallenge(50.0, 'Caminar 15 min', '1 semana') : _makeNoChallenge()
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
        Navigator.popAndPushNamed(context, Routes.exercises_challenges);
      },
      child: Container(
        child: Card(
          color: AppColors.PRIMARY,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            leading: Text(percent.toString() + "%", style: TextStyle(color: Colors.white, fontSize: 20),),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(cantidad, style: TextStyle(color: Colors.white),),
                Text(duracion, style: TextStyle(color: Colors.white),)
              ],
            ),
            trailing: Icon(Icons.navigate_next, color: Colors.white,)
          ),
        ),
      )
    );
  }
  Widget _makeChallengeFood() {
    return InkWell(
      onTap: (){
        Navigator.popAndPushNamed(context, Routes.feeding_challenges);
      },
      child: Card(
        color: AppColors.PRIMARY,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          leading: Text((currentChallenge.percent() * 100).toStringAsFixed(1) + "%", style: TextStyle(fontSize: 20, color: Colors.white)),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(currentChallenge.amount, style: TextStyle(color: Colors.white)),
              Text(currentChallenge.duration, style: TextStyle(color: Colors.white))
            ],
          ),
          trailing: Icon(Icons.navigate_next, color: Colors.white,)
        ),
      )
    );
  }

  Widget _makeNoChallenge() {
    return InkWell(
      onTap: (){
        Navigator.popAndPushNamed(context, Routes.food_challenges);
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
