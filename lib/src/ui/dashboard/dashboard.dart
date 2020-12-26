import 'dart:convert';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:health_body_checking/src/services/hearth_service.dart';
import 'package:health_body_checking/src/services/imc_service.dart';
import 'package:health_body_checking/src/services/oxygen_saturation_service.dart';
import 'package:health_body_checking/src/services/temperature_service.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

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

  Map<String,BaseService> _services={
    "Temperatura":new TemperatureService(),
    "Oximetro":new OxygenSaturationService(),
    "HearthRate":new HearthRateService(),
    "Imc":new ImcService()
  };

  @override
  void initState() {
    super.initState();
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

  Widget _health() {
    return Row(
      children: [
        Image.asset(
            "assets/images/health.png",
            width: MediaQuery.of(context).size.width*.4
        ),
        Expanded(child: Container(
          child: Column(
            children: _sensors(),
          )
        ))
      ],
    );
  }

  Widget _lastValue(BaseService service) {
    return StreamBuilder<Object>(
        stream: service.lastDocumentsStream(1),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<dynamic> list = snapshot.data;
            //list.sort((a, b) => a.time.compareTo(b.time));
            value = list.last.value;
            return Text(value.toStringAsFixed(1));
          }
          return CircularProgressIndicator();
        });
  }

  List<Widget> _sensors() {
    List<Widget> list = List<Widget>();
    for (var sensor in CurrentUserModel.instance.sensors) {
      if(sensor.enabled) {
        list.add(
            ListTile(
              title: _lastValue(this._services[sensor.sensorName]),
              subtitle: Text(sensor.displayName, style: TextStyle(fontSize: 12),),
              trailing: IconButton(
                onPressed: () {},
                icon: Icon(Icons.navigate_next),
              ),
            )
        );
      }
    }
    return list;
  }

}
