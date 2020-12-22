import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:health_body_checking/src/services/base.service.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../constants/app_colors.dart';
import '../../../core/routes/routes.dart';
import '../../../models/sensor_model.dart';

class SensorCard extends StatefulWidget {
  final SensorModel sensor;
  final String name;
  final IconData icon;
  final VoidCallback inputFunction;
  final BaseService service;
  SensorCard({Key key, this.sensor, this.name, this.icon, this.inputFunction,@required this.service}) : super(key: key);
  @override State createState() => SensorCardState();
}

class SensorCardState extends State<SensorCard> {
  @override
  void initState() {
    super.initState();
    _getAllData();
  }
  void _getAllData(){
    widget.service.findAllStream().listen((event) { 
      print(event);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(Routes.data_visualization, arguments: widget.sensor.index);
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
                     child: SfCartesianChart(
                      // Initialize category axis
                      primaryXAxis: CategoryAxis(),
                      backgroundColor: AppColors.WHITE,
                      plotAreaBackgroundColor: Colors.white,
                      plotAreaBorderColor: Colors.transparent,
                      borderColor: AppColors.WHITE,
                      series: <LineSeries<SalesData, String>>[
                        LineSeries<SalesData, String>(
                          // Bind data source
                          dataSource:  <SalesData>[
                            SalesData('Jan', 35),
                            SalesData('Feb', 28),
                            SalesData('Mar', 34),
                            SalesData('Apr', 32),
                            SalesData('May', 40)
                          ],
                          xValueMapper: (SalesData sales, _) => sales.year,
                          yValueMapper: (SalesData sales, _) => sales.sales
                        )
                      ]
                    )
                  )
              )
            ],
          ),
        ),
      )
    );
  }
}

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}