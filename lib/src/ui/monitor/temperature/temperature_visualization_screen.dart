import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_body_checking/src/constants/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../models/temperature_model.dart';
import '../../../services/temperature_service.dart';

class TemperatureVisualizationScreen extends StatefulWidget {
  TemperatureVisualizationScreen({Key key}) : super(key: key);
  @override
  _TemperatureVisualizationScreenState createState() => _TemperatureVisualizationScreenState();
}

class _TemperatureVisualizationScreenState extends State<TemperatureVisualizationScreen> {
  List<TemperatureModel> _temperaturaModel = List();
  final GlobalKey<SfCartesianChartState> sfkey = GlobalKey();
  
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
    final database = Provider.of<TemperatureService>(context, listen: false);
    database.lastDocumentsStream(20).listen((event) {
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
    return SingleChildScrollView( 
      child: Padding(
        padding: EdgeInsets.only(left: 10,right: 10),
              child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Informacion Importante',
              style: TextStyle(
                  color: AppColors.BLACK,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            Text("valores normales oscilan entre 36° y 37,2° Celsius Durante el dia distintas situaciones alteran la tempreatura en este rango.",textAlign: TextAlign.justify,),
            Text(
              'Recomendaciones valores entre 35.5 a 36',
              style: TextStyle(
                  color: AppColors.BLACK,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            Text('Si sientes que te desvances, tienes dificultades para respirar o sientes dolor en el pecho durante más de unos minutos, avisa a alguien cercano y llama al numero de emergencias o acude de inmediato a un centro de salud.',textAlign: TextAlign.justify,),
            Text(
              'Recomendaciones valores menores a 35.5',
              style: TextStyle(
                  color: AppColors.BLACK,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            Text('Busca ayuda medica definitivamente no estas bien podria estar en riesgo tu salud.',textAlign: TextAlign.justify,),
            
            Text(
              'Recomendaciones valores normales',
              style: TextStyle(
                  color: AppColors.BLACK,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            Text('Vamos bien todo OK! si sientes calor hidratate y si sientes frio una bebida caliente estaria perfecta.',textAlign: TextAlign.justify,),
            
            Text(
              'Recomendaciones valores entre 37.2 y 38',
              style: TextStyle(
                  color: AppColors.BLACK,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            Text('Esto se llama febricula, algo esta causando esto, si sientes alguna molestia adicional, estamos a tiempo de parar una fiebre acudiendo a una consulta en algun centro de salud.',textAlign: TextAlign.justify,),
            
            Text(
              'Recomendaciones valores mayores a 38',
              style: TextStyle(
                  color: AppColors.BLACK,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            Text('Tienes fiebre, existen muchas causas algunas podrian ser graves, por favor acude por atencion medica para no poner en riesgo tu salud.',textAlign: TextAlign.justify,),
          ],
        ),
      ),
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
        key:sfkey,
        primaryXAxis: DateTimeAxis(
            visibleMinimum: DateTime(0,0,0,5,5),
            visibleMaximum: DateTime(0,0,0,8,8),
            zoomFactor: 0.1,
            intervalType: DateTimeIntervalType.auto,
            plotBands: <PlotBand>[
              _makePlotBand(36.0, 37.5, Color.fromRGBO(27, 188, 155, .3)),
              _makePlotBand(37.5, 40.5, Color.fromRGBO(200, 27, 50, .3)),
              _makePlotBand(34.0, 36.0, Color.fromRGBO(200, 27, 50, .3))
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
                          '${data.value.toStringAsFixed(1)}°C',
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

        series: <ChartSeries<TemperatureModel, DateTime>>[
          LineSeries<TemperatureModel, DateTime>(
              dataSource: this._temperaturaModel,
              xValueMapper: (TemperatureModel sales, _) => sales.time,
              yValueMapper: (TemperatureModel sales, _) => sales.value,
              markerSettings: MarkerSettings(
                  isVisible: true
              )
          )
        ],
      ),
    );
  }

}
