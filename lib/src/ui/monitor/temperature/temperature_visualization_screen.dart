
import 'package:flutter/material.dart';
import 'package:health_body_checking/src/models/temperature_model.dart';
import 'package:health_body_checking/src/services/temperature_service.dart';
import 'package:health_body_checking/src/ui/monitor/widgets/visualization_header.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class TemperatureVisualizationScreen extends StatefulWidget {
  final VoidCallback onGoToNextQuestion;

  TemperatureVisualizationScreen({Key key, this.onGoToNextQuestion}) : super(key: key);
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
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 10),
        child: Column(
          children: [
            VisualizationHeader(
              text: 'Temperatura',
            ),
            _visualization(),
          ],
        ),
      ),
    );
  }

  Widget _visualization() {
    return SfCartesianChart(
      primaryXAxis: CategoryAxis(
        edgeLabelPlacement: EdgeLabelPlacement.shift,               
      ),
      zoomPanBehavior: ZoomPanBehavior(  
        enableDoubleTapZooming: true
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

    );
  }
}
