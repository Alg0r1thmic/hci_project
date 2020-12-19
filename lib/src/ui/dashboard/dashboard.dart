import 'package:flutter/material.dart';
import 'package:health_body_checking/src/constants/app_colors.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';


class DashboardScreen extends StatefulWidget {
  DashboardScreen({Key key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  bool thereAreChallenges = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Retos actuales", textAlign: TextAlign.start, style: TextStyle(fontSize: 16),),
                  thereAreChallenges ? _getChallenges() : _makeNoChallenge()
                ],
              ),
            ),
            Expanded(
                child: Container(
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

    );
  }
}
