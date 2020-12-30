import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:health_body_checking/src/models/user_model.dart';
import 'package:health_body_checking/src/ui/questions/widgets/dialog_help.dart';

import 'widgets/next_or_back_button.dart';
import 'widgets/pagination.dart';

class QuestionZeroScreen extends StatefulWidget {
  final VoidCallback onGoToNextQuestion;
  QuestionZeroScreen({Key key, @required this.onGoToNextQuestion,}) : super(key: key);
  @override
  _QuestionZeroScreenState createState() => _QuestionZeroScreenState();
}

TextEditingController _estaturaString = new TextEditingController();
TextEditingController _edadString = new TextEditingController();
enum SexOption { Hombre, Mujer }
class _QuestionZeroScreenState extends State<QuestionZeroScreen> {
  double _estatura = 160;
  double _edad = 160;
  Color _myColor = Colors.lightBlueAccent;
  String _myAccountState = "Account Enabled";
  int _value = 1;
  SexOption _character = SexOption.Hombre;
  final _formKey = GlobalKey<FormState>();


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
              PaginationText(total: 6, actual: 1),
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
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        NextOrBackButton(
          inputFunction: (){
            if(_formKey.currentState.validate()){
              CurrentUserModel.instance.age=int.parse(_edadString.text);
              CurrentUserModel.instance.height=double.parse(_estaturaString.text);
              widget.onGoToNextQuestion();
            }
          },
          icon: Icons.east,
        )
      ],
    );
  }

  Widget _content() {
    return Form(
        key: _formKey,
          child: ListView(
        children: [
          RichText(
            text:
            TextSpan(style: TextStyle(fontSize: 20, color: Colors.black),
              children: <TextSpan>[
                TextSpan(text: 'Sexo', style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(text: ':', style: TextStyle(fontWeight: FontWeight.normal)),
              ],
            ),
          ),

          ListTile(
            title: const Text('Hombre'),
            leading: Radio(
              value: SexOption.Hombre,
              groupValue: _character,
              onChanged: (SexOption value) {
                setState(() {
                  _character = value;
                });
              },
            ),
          ),
          ListTile(
            title: const Text('Mujer'),
            leading: Radio(
              value: SexOption.Mujer,
              groupValue: _character,
              onChanged: (SexOption value) {
                setState(() {
                  _character = value;
                });
              },
            ),
          ),

          SizedBox(height: 30,),

          RichText(
            text:
            TextSpan(style: TextStyle(fontSize: 20, color: Colors.black),
              children: <TextSpan>[
                TextSpan(text: '¿Cuantos ', style: TextStyle(fontWeight: FontWeight.normal)),
                TextSpan(text: 'centimetros ', style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(text: 'de altura mide?', style: TextStyle(fontWeight: FontWeight.normal)),
              ],
            ),
          ),

          TextFormField(
            controller: _estaturaString,
            decoration: new InputDecoration(
              hintText: "Ingrese su talla en centimetros.",
              suffixText: "cm"
            ),
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            validator:(value){
              if(value.isEmpty){
                return 'Ingrese su talla';
              }
              else{
                return null;
              }
            }, // Only numbers can be entered
          ),

          SizedBox(height: 30,),

          RichText(
            text:
            TextSpan(style: TextStyle(fontSize: 20, color: Colors.black),
              children: <TextSpan>[
                TextSpan(text: '¿Cuantos ', style: TextStyle(fontWeight: FontWeight.normal)),
                TextSpan(text: 'años', style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(text: ' tiene?', style: TextStyle(fontWeight: FontWeight.normal))
              ],
            ),
          ),


          TextFormField(
            controller: _edadString,
            decoration: new InputDecoration(
              hintText: "Ingrese su edad en años.",
              suffixText: "años"
            ),
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.done,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            validator: (value){
              if(value.isEmpty){
                return 'Ingrese su edad';
              }
              return null;
            }, // Only numbers can be entered
          ),
        ],
      ),
    );
  }

}
