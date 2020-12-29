import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_body_checking/src/models/exercise_question_model.dart';
import 'package:health_body_checking/src/models/user_model.dart';
import 'package:health_body_checking/src/services/exercise_question_service.dart';
import 'package:number_inc_dec/number_inc_dec.dart';
//import 'package:numberpicker/numberpicker.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import 'widgets/next_or_back_button.dart';
import 'widgets/pagination.dart';

class QuestionFourScreen extends StatefulWidget {
  final VoidCallback onGoToNextQuestion;
  final VoidCallback onGoToBackQuestion;
  QuestionFourScreen({Key key, @required this.onGoToNextQuestion, @required this.onGoToBackQuestion}) : super(key: key);
  @override
  _QuestionFourScreenState createState() => _QuestionFourScreenState();
}

class _QuestionFourScreenState extends State<QuestionFourScreen> {

  ExerciseQuestionService _service;
  ExerciseQuestionModel _model;
  TextEditingController _controller = TextEditingController();
  @override
  void initState() { 
    super.initState();
    _service=ExerciseQuestionService();
    _getQuestion();
  }
  double _currentSliderValue = 2;
  void _saveData()async{
    _model=ExerciseQuestionModel(id: DateTime.now().toIso8601String(),userId: CurrentUserModel.instance.id,days: _currentSliderValue.toInt(),minuts:int.parse(_controller.text));
    await _service.createOne(_model);
  }
  void _getQuestion(){
     _service.findByUserId(userId: CurrentUserModel.instance.id).listen((event) {
       if(event.length>0){
        _model=event[0];
        _currentSliderValue=_model.days.toDouble();
        _controller.text=_model.minuts.toString();
       }
    });
    setState(() {  
    });
  }

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
                        _showMyDialog("Por favor ingresa la informacion real, por que esta sirve para establecer el punto de partida en el proceso de adquirir nuevos habitos.\nLa informacion solicitada es unicamente para realizar calculos necesarios para obtener indicadores como IMC y para establecer un punto de partida para los retos propuestos con la finalidad de ayudarte a adquirr un nuevo habito.");
                      }
                  )
                  //DialogHelp(context: this.context, content: "Por favor ingresa la informacion real, por que esta sirve para establecer el punto de partida en el proceso de adquirir nuevos habitos.\nLa informacion solicitada es unicamente para realizar calculos necesarios para obtener indicadores como IMC y para establecer un punto de partida para los retos propuestos con la finalidad de ayudarte a adquirr un nuevo habito.")
                ],
              ),
              PaginationText(total: 6, actual: 5),
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
          inputFunction:(){
            this._saveData();
            widget.onGoToNextQuestion();
          
          } ,
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
          child: Image.asset("assets/images/ejer.png", height: 150,),
        ),

        RichText(
          text:
          TextSpan(style: TextStyle(fontSize: 20, color: Colors.black),
            children: <TextSpan>[
              TextSpan(text: '¿Cuantas ', style: TextStyle(fontWeight: FontWeight.normal)),
              TextSpan(text: 'veces a la semana realizas ', style: TextStyle(fontWeight: FontWeight.normal)),
              TextSpan(text: 'actividad fisica? ', style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          textAlign: TextAlign.center,
        ),

        SfSlider(
          min: 0.0,
          max: 7.0,
          value: _currentSliderValue,
          interval: 1,
          showLabels: true,
          showTicks: true,
          showDivisors: true,
          enableTooltip: true,
          onChanged: (dynamic value) {
            setState(() {
              int val=value.toInt();
              _currentSliderValue = val.toDouble();
            });
          },
        ),

        RichText(
          text:
          TextSpan(style: TextStyle(fontSize: 20, color: Colors.black),
            children: <TextSpan>[
              TextSpan(text: '¿Durante cuántos ', style: TextStyle(fontWeight: FontWeight.normal)),
              TextSpan(text: 'minutos ', style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(text: '?', style: TextStyle(fontWeight: FontWeight.normal)),
            ],
          ),
          textAlign: TextAlign.center,
        ),


        _currentSliderValue != 0 ?
        NumberInputPrefabbed.roundedEdgeButtons(
          controller: _controller,
          autovalidate: true,
          min: 0,
          max: 40,
          incDecBgColor: Colors.blue,
          buttonArrangement: ButtonArrangement.incRightDecLeft,
        ): Container()

      ],
    );
  }
}
