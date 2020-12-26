import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../models/oxygen_saturation_model.dart';
import '../../../services/oxygen_saturation_service.dart';

class OxygenSaturationVisualizationScreen extends StatefulWidget {
  OxygenSaturationVisualizationScreen({Key key}) : super(key: key);

  @override
  _OxygenSaturationVisualizationScreenState createState() => _OxygenSaturationVisualizationScreenState();
}

class _OxygenSaturationVisualizationScreenState extends State<OxygenSaturationVisualizationScreen> {
  List<OxygenSaturationModel> _oxygenSaturationModel = List();

  int segmentedControlGroupValue = 0;
  final Map<int, Widget> myTabs = const <int, Widget>{
    0: Text("Dias", textAlign: TextAlign.center),
    1: Text("Meses", textAlign: TextAlign.center),
    2: Text("Años", textAlign: TextAlign.center)
  };

  @override
  void initState() {
    super.initState();
    _listenStream();
  }

  _listenStream() {
    final database = Provider.of<OxygenSaturationService>(context, listen: false);
    database.lastDocumentsStream(100).listen((event) {
      _oxygenSaturationModel = event;
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
          _chart(),
          _intervalSelector(),
          _info()
        ],
      ),
    );
  }

  DateTimeIntervalType _getTimeIntervalType() {
    if (segmentedControlGroupValue == 0) return DateTimeIntervalType.days;
    else if (segmentedControlGroupValue == 1) return DateTimeIntervalType.months;
    else return DateTimeIntervalType.years;
  }

  Widget _info() {
    return Container(
    );
  }

  Widget _intervalSelector() {
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
              yValueMapper: (OxygenSaturationModel sales, _) => sales.value,
              markerSettings: MarkerSettings(
                  isVisible: true
              )
          )
        ],
      ),
    );
  }

}
