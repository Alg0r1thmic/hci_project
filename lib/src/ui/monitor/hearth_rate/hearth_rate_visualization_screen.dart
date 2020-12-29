import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../constants/app_colors.dart';
import '../../../models/hearth_rate_model.dart';
import '../../../models/temperature_model.dart';
import '../../../services/hearth_service.dart';
import '../../../services/temperature_service.dart';

class HearthRateVisualizationScreen extends StatefulWidget {
  HearthRateVisualizationScreen({Key key}) : super(key: key);
  @override
  _HearthRateVisualizationScreenState createState() => _HearthRateVisualizationScreenState();
}

class _HearthRateVisualizationScreenState extends State<HearthRateVisualizationScreen> {
  List<HearthRateModel> _temperaturaModel = List();

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
    final database = Provider.of<HearthRateService>(context, listen: false);
    database.lastDocumentsStream(10).listen((event) {
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
              'Información importante:',
              style: TextStyle(
                  color: AppColors.BLACK,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            Text("En adultos los valores normales estan entre 60 a 80 pulsaciones/min Los latidos del corazon se incrementa en respuesta a la necesidad del cuerpo por recibir más oxigeno o nutrientes. Recomendaciones valores menores a 60 .Si sientes que te desvances, tienes dificultades para respirar o sientes dolor en el pecho durante más de unos minutos, avisa a alguien cercano y llama al numero de emergencias o acude de inmediato a un centro de salud.",textAlign: TextAlign.justify,),
            Text(
              'Recomendaciones valores menores a 60:',
              style: TextStyle(
                  color: AppColors.BLACK,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            Text('Si sientes que te desvances, tienes dificultades para respirar o sientes dolor en el pecho durante más de unos minutos, avisa a alguien cercano y llama al numero de emergencias o acude de inmediato a un centro de salud.',textAlign: TextAlign.justify,),
            Text(
              'Recomendaciones valores sobre 80:',
              style: TextStyle(
                  color: AppColors.BLACK,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            Text('¿Estas realizando ejercicio o acabas de pasar por alguna situacion de estres leve?',textAlign: TextAlign.justify,),
            RichText(text:TextSpan(
              children: [
                TextSpan(text: 'Si  ',style: TextStyle(color: AppColors.BLACK,fontWeight: FontWeight.bold)),
                TextSpan(text: 'entonces es normal descansando pasara.',style: TextStyle(color: AppColors.BLACK))
              ]
            )),
            RichText(text:TextSpan(
              children: [
                TextSpan(text: 'No  ',style: TextStyle(color: AppColors.BLACK,fontWeight: FontWeight.bold)),
                TextSpan(text: 'entonces podrias tener algun problema cardiaco u otro que pone en riesgo tu salud o tu vida debes acudir a un centro de salud.',style: TextStyle(color: AppColors.BLACK))
              ]
            ))
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
        primaryXAxis: DateTimeAxis(
             visibleMinimum: DateTime(0,0,0,5,5),
            visibleMaximum: DateTime(0,0,0,8,8),
            zoomFactor: 0.1,
            intervalType: DateTimeIntervalType.auto,
            plotBands: <PlotBand>[
              _makePlotBand(72.0, 87.5, Color.fromRGBO(27, 188, 155, .3)),
              _makePlotBand(87.5, 100.0, Color.fromRGBO(200, 27, 50, .3)),
              _makePlotBand(60.0, 72.0, Color.fromRGBO(200, 27, 50, .3))
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
                          '${data.value.toStringAsFixed(1)}°lpm',
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
        series: <ChartSeries<HearthRateModel, DateTime>>[
          LineSeries<HearthRateModel, DateTime>(
              dataSource: this._temperaturaModel,
              xValueMapper: (HearthRateModel sales, _) => sales.time,
              yValueMapper: (HearthRateModel sales, _) => sales.value,
              markerSettings: MarkerSettings(
                  isVisible: true
              )
          )
        ],
      ),
    );
  }

}
