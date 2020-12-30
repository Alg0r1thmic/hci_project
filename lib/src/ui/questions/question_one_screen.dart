import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:health_body_checking/src/models/user_model.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import 'widgets/next_or_back_button.dart';
import 'widgets/pagination.dart';

class QuestionOneScreen extends StatefulWidget {
  final VoidCallback onGoToNextQuestion;
  final VoidCallback onGoToBackQuestion;
  QuestionOneScreen({Key key, @required this.onGoToBackQuestion, @required this.onGoToNextQuestion}) : super(key: key);
  @override
  _QuestionOneScreenState createState() => _QuestionOneScreenState();
}

class _QuestionOneScreenState extends State<QuestionOneScreen> {
  double _currentSliderValue = CurrentUserModel.instance.glassOfWaterPerDay!=null?CurrentUserModel.instance.glassOfWaterPerDay.toDouble():0;

  Future<void> _showMyDialog(String content) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Ayuda'),
          content: ListTile(
            title: Text(content),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cerrar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      icon: Icon(Icons.help_outline_rounded),
                      onPressed: () {
                        _showMyDialog("Por favor ingresa la informacion real, por que esta sirve para establecer el punto de partida en el proceso de adquirir nuevos habitos.\nEl agua es indispensable para el buen funcionamiento de nuestro organismo, y dado que no se almacena en el cuerpo, es preciso reponerla durante el día.");
                      }
                  )
                  //DialogHelp(context: this.context, content: "Por favor ingresa la informacion real, por que esta sirve para establecer el punto de partida en el proceso de adquirir nuevos habitos.\nLa informacion solicitada es unicamente para realizar calculos necesarios para obtener indicadores como IMC y para establecer un punto de partida para los retos propuestos con la finalidad de ayudarte a adquirr un nuevo habito.")
                ],
              ),
              PaginationText(total: 6, actual: 2),
              Expanded(child: SizedBox(child: _content(),)),
              _questionsChangeButton(),
            ],
          ),
        )
      )
    );
  }

  Widget _questionsChangeButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        NextOrBackButton(
          inputFunction: widget.onGoToBackQuestion,
          icon: Icons.west,
        ),
        NextOrBackButton(
          inputFunction: widget.onGoToNextQuestion,
          icon: Icons.east,
        )
      ],
    );
  }

  Widget _content() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          child: Image.asset("assets/images/glass.png", height: 150,),
        ),

        Text(
          _currentSliderValue.round().toString(),
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold
          ),
        ),


        RichText(
          text:
            TextSpan(style: TextStyle(fontSize: 20, color: Colors.black),
              children: <TextSpan>[
                TextSpan(text: '¿Cuantos ', style: TextStyle(fontWeight: FontWeight.normal)),
                TextSpan(text: 'vasos de agua ', style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(text: 'tomas al dia? ', style: TextStyle(fontWeight: FontWeight.normal)),
            ],
          ),
          textAlign: TextAlign.center,
        ),
         SfSlider(
          min: 0.0,
          max: 8.0,
          value: CurrentUserModel.instance.glassOfWaterPerDay!=null?CurrentUserModel.instance.glassOfWaterPerDay.toDouble():_currentSliderValue,
          interval: 1,
          showLabels: true,
          showTicks: true,
          showDivisors: true,
          enableTooltip: true,
          onChanged: (dynamic value) {
            setState(() {
              int val=value.toInt();
              _currentSliderValue = val.toDouble();
              CurrentUserModel.instance.glassOfWaterPerDay=val;
            });
          },
        ),

      ],
    );
  }
  
}
