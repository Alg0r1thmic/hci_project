import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_body_checking/src/constants/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../models/temperature_model.dart';
import '../../../services/temperature_service.dart';

class ImcVisualizationScreen extends StatefulWidget {
  ImcVisualizationScreen({Key key}) : super(key: key);
  @override
  _ImcVisualizationScreenState createState() => _ImcVisualizationScreenState();
}

class _ImcVisualizationScreenState extends State<ImcVisualizationScreen> {
  List<TemperatureModel> _temperaturaModel = List();

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
            Text("Los valores normales son entre 18.5 y 24.9 .Este indicador refleja la realcion entre el peso y la talla, es importante por que refleja como se comporta tu peso.",textAlign: TextAlign.justify,),
            Text(
              'Recomendaciones valores menores a 18.5:',
              style: TextStyle(
                  color: AppColors.BLACK,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            Text('Estas delgado(a) podria afectar tu salud si te mantienes en este rango. Deberias ganar algo de peso.',textAlign: TextAlign.justify,),
            Text(
              'Recomendaciones valores menores a 17',
              style: TextStyle(
                  color: AppColors.BLACK,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            Text('Estas muy delgado(a) estas poniendo en riesgo tu salud acude a un especialista, definitivamente algo no esta bien aqui. No tengas miedo puedes salir de esto si buscas ayuda. Ten confianza.',textAlign: TextAlign.justify,),
           
            Text(
              'Recomendaciones valores entre 25 y 30',
              style: TextStyle(
                  color: AppColors.BLACK,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            Text('Estas con sobre peso, tranquilo es momento de empezar a adquirir habitos saludables el ejercicio y una alimentacion adecuada te ayudaran. Animo! Ahora es un buen momento para empezar. Visita un especialista.',textAlign: TextAlign.justify,),
           
            Text(
              'Recomendaciones valores mayores a 30',
              style: TextStyle(
                  color: AppColors.BLACK,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            Text('Estas en un estado de obesidad tu salud esta en peligro es necesario que acudas a un medico o un nutricionista. No debes esperar mas tiempo.',textAlign: TextAlign.justify,),
           
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
                          '${data.value.toStringAsFixed(1)}imc',
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
