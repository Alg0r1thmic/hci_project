import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'package:health_body_checking/src/ui/questions/widgets/next_or_back_button.dart';
import 'package:health_body_checking/src/ui/questions/widgets/pagination.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:sticky_headers/sticky_headers.dart';

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


  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
          child: Column(
            children: [
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
          inputFunction: widget.onGoToNextQuestion,
          icon: Icons.east,
        )
      ],
    );
  }

  Widget _content() {
    return ListView(
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

        SizedBox(height: 25,),

        RichText(
          text:
          TextSpan(style: TextStyle(fontSize: 20, color: Colors.black),
            children: <TextSpan>[
              TextSpan(text: 'Talla ', style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(text: 'en centimetros:', style: TextStyle(fontWeight: FontWeight.normal)),
            ],
          ),
        ),

        TextField(
          controller: _estaturaString,
          decoration: new InputDecoration(hintText: "Ingrese su talla en centimetros."),
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ], // Only numbers can be entered
        ),

        SizedBox(height: 25,),

        RichText(
          text:
          TextSpan(style: TextStyle(fontSize: 20, color: Colors.black),
            children: <TextSpan>[
              TextSpan(text: 'Edad ', style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(text: 'en años:', style: TextStyle(fontWeight: FontWeight.normal)),
            ],
          ),
        ),

        TextField(
          controller: _edadString,
          decoration: new InputDecoration(hintText: "Ingrese su edad en años."),
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ], // Only numbers can be entered
        ),
      ],
    );
  }

}
