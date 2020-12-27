import 'dart:ui';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';
import '../../../core/routes/routes.dart';
import '../../../models/sensor_model.dart';
import '../../../services/base.service.dart';

class SensorCard extends StatefulWidget {
  final SensorModel sensor;
  final String name;
  final IconData icon;
  final VoidCallback inputFunction;
  final BaseService service;
  final int minValue;
  final int maxValue;
  final String unitOfMeasurement;
  SensorCard(
      {Key key,
      this.sensor,
      this.name,
      this.icon,
      this.inputFunction,
      @required this.service,
      @required this.minValue,
      @required this.maxValue,
      this.unitOfMeasurement})
      : super(key: key);
  @override
  State createState() => SensorCardState();
}

class SensorCardState extends State<SensorCard> {
  var list;
  double value;
  @override
  void initState() {
    super.initState();
    _getAllData();
  }

  void _getAllData() {
    widget.service.lastDocumentsStream(10).listen((event) {});
  }

  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(Routes.data_visualization,
            arguments: widget.sensor.sensorName);
      },
      child: Container(
        margin: EdgeInsets.only(left: 10, right: 10, top: 10),
        padding: EdgeInsets.all(10),
        width: double.infinity,
        height: 200,
        decoration: BoxDecoration(
            color: AppColors.WHITE,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0.0, 15.0),
                  blurRadius: 15.0)
            ]),
        child: StreamBuilder<Object>(
            stream: widget.service.lastDocumentsStream(6),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<dynamic> list = snapshot.data;
                list.sort((a, b) => a.time.compareTo(b.time));
                value = list.last.value;
                double index = -1;
                list = list
                    .map((e) => FlSpot(index += 1, _getNewValue(e.value)))
                    .toList();
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        width: 130,
                        padding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              widget.icon,
                              color: AppColors.PRIMARY_DARK,
                            ),
                            Text(
                              value.toStringAsFixed(1)+' '+widget.unitOfMeasurement,
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),

                            Text(
                              widget.name,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        )),
                    Expanded(
                        child: Container(
                      child: LineChart(
                        mainData(list, snapshot.data),
                        swapAnimationDuration:
                            const Duration(milliseconds: 900),
                      ),
                    ))
                  ],
                );
              }
              return Center(child: CircularProgressIndicator());
            }),
      ),
    );
  }

  double _getNewValue(double value) {
    int oldRange = (widget.maxValue - widget.minValue);
    int newMin = 0;
    int newMax = oldRange;
    int newRange = (newMax - newMin);
    return (((value - widget.minValue) * newRange) / oldRange) + newMin;
  }

  LineChartData mainData(List<dynamic> list, dynamic data) {
    return LineChartData(
      gridData: FlGridData(
        show: false,
        drawVerticalLine: true,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          getTextStyles: (value) => const TextStyle(
              color: Color(0xff68737d),
              fontWeight: FontWeight.bold,
              fontSize: 16),
          getTitles: (value) {
            return '';
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 10,
          ),
          getTitles: (value) {
            return '';
          },
          reservedSize: 20,
          margin: 12,
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: const Border(
          bottom: BorderSide(
            color: Colors.transparent,
          ),
          left: BorderSide(
            color: Colors.transparent,
          ),
          right: BorderSide(
            color: Colors.transparent,
          ),
          top: BorderSide(
            color: Colors.transparent,
          ),
        ),
      ),
      minX: 0,
      maxX: 5,
      minY: 0,
      maxY: (widget.maxValue - widget.minValue).toDouble(),
      lineBarsData: [
        LineChartBarData(
          spots: list,
          isCurved: true,
          colors: gradientColors,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors:
                gradientColors.map((color) => color.withOpacity(0.2)).toList(),
          ),
        ),
      ],
    );
  }
}
