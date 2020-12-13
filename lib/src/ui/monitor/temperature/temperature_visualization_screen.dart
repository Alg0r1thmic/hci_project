import 'package:flutter/material.dart';
import 'package:health_body_checking/src/models/temperature_model.dart';
import 'package:health_body_checking/src/services/temperature_service.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class TemperatureVisualizationScreen extends StatefulWidget {
  TemperatureVisualizationScreen({Key key}) : super(key: key);
  @override
  _TemperatureVisualizationScreenState createState() => _TemperatureVisualizationScreenState();
}

class _TemperatureVisualizationScreenState extends State<TemperatureVisualizationScreen> {
  List<TemperatureModel> _temperaturaModel = List();
  @override
  void initState() {
    super.initState();
    _listenStream();
  }

  _listenStream() {
    final database = Provider.of<TemperatureService>(context, listen: false);
    database.temperaturesStream().listen((event) {
      _temperaturaModel = event;
      setState(() {
        
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return _visualization();
  }

  Widget _visualization() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: ListView(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.65,
            child: SfCartesianChart(
              primaryXAxis: CategoryAxis(
                edgeLabelPlacement: EdgeLabelPlacement.shift,
                visibleMinimum: 5.0,
                visibleMaximum: 10.0,
                plotBands: <PlotBand>[
                  PlotBand(
                    isVisible: true,
                    opacity: .3,
                    associatedAxisStart: 36.0,
                    associatedAxisEnd: 37.5,
                    color: const Color.fromRGBO(27, 188, 155, .3)
                  ),
                  PlotBand(
                      isVisible: true,
                      opacity: .3,
                      associatedAxisStart: 37.5,
                      associatedAxisEnd: 40.5,
                      color: const Color.fromRGBO(200, 27, 50, .3)
                  ),
                  PlotBand(
                      isVisible: true,
                      opacity: .3,
                      associatedAxisStart: 34.0,
                      associatedAxisEnd: 36.0,
                      color: const Color.fromRGBO(200, 27, 50, .3)
                  ),
                ]
              ),
              zoomPanBehavior: ZoomPanBehavior(
                  enablePanning: true,
              ),
              legend: Legend(isVisible: true),
              tooltipBehavior: TooltipBehavior(enable: true),
              series: <ChartSeries<TemperatureModel, String>>[
                LineSeries<TemperatureModel, String>(
                    dataSource: this._temperaturaModel,
                    xValueMapper: (TemperatureModel sales, _) => sales.time.toDate().toString(),
                    yValueMapper: (TemperatureModel sales, _) => sales.temperature,
                    // Enable data label
                    dataLabelSettings: DataLabelSettings(isVisible: true)
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
