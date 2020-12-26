import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:health_body_checking/src/constants/app_colors.dart';
import 'package:health_body_checking/src/models/sensor_model.dart';

import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter/cupertino.dart';

import '../../../core/routes/routes.dart';

class SensorCard extends StatefulWidget {

  final Sensor sensor;
  SensorCard({Key key, this.sensor}) : super(key: key);

  @override State createState() => SensorCardState();
}

class SensorCardState extends State<SensorCard> {

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(Routes.data_visualization, arguments: widget.sensor.id);
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
                      Icon(widget.sensor.icon, color: AppColors.WHITE,),
                      Text(widget.sensor.values[widget.sensor.values.length-1].value.toStringAsFixed(1), style: TextStyle(fontSize: 25, color: AppColors.WHITE),),
                      Text(widget.sensor.name, textAlign: TextAlign.center, style: TextStyle(color: AppColors.WHITE),),
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

/*  Widget _intervalSelector() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: CupertinoSlidingSegmentedControl(
          children: myTabs,
          groupValue: segmentedControlGroupValue,
          onValueChanged: (value) {
            setState(() {
              segmentedControlGroupValue = value;
            });
          }
      ),
    );
  }

  PlotBand _makePlotBand (double start, double end, Color color) {
    return PlotBand(
        isVisible: true,
        opacity: .3,
        associatedAxisStart: start,
        associatedAxisEnd: end,
        color: color
    );
  }

  Widget _chart() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.65,
      child: SfCartesianChart(
        primaryXAxis: DateTimeAxis(
            visibleMinimum: DateTime(0,0,0,0,0,5),
            visibleMaximum: DateTime(0,0,0,0,0,10),
            zoomFactor: .5,
            intervalType: DateTimeIntervalType.auto,
            plotBands: <PlotBand>[
              _makePlotBand(95.0, 100.0, Color.fromRGBO(27, 188, 155, .3)),
            ]
        ),
        zoomPanBehavior: ZoomPanBehavior(
            enablePanning: true,
            enableDoubleTapZooming: true,
            zoomMode: ZoomMode.x,
            enablePinching: true
        ),
        tooltipBehavior: TooltipBehavior(
            enable: true,
            builder: (dynamic data, dynamic point, dynamic series,
                int pointIndex, int seriesIndex) {
              return Card(
                  child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      child: ListTile(
                        title: Text(
                          '${data.saturation.toStringAsFixed(1)}%',
                          style: TextStyle(fontSize: 14),
                        ),
                        subtitle: Text(
                          '${data.time.toString()}',
                          style: TextStyle(fontSize: 14),
                        ),
                      )
                  )
              );
            }
        ),
        series: <ChartSeries<OxygenSaturationModel, DateTime>>[
          LineSeries<OxygenSaturationModel, DateTime>(
              dataSource: this._oxygenSaturationModel,
              xValueMapper: (OxygenSaturationModel sales, _) => sales.time,
              yValueMapper: (OxygenSaturationModel sales, _) => sales.saturation,
              markerSettings: MarkerSettings(
                  isVisible: true
              )
          )
        ],
      ),
    );
  }*/
}

