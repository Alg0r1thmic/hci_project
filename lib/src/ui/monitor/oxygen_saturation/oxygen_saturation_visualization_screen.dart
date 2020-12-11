import 'package:flutter/material.dart';
import 'package:health_body_checking/src/ui/monitor/widgets/visualization_header.dart';

class OxygenSaturationVisualizationScreen extends StatefulWidget {
  final VoidCallback onGoToNextQuestion;
  final VoidCallback onGoToBackQuestion;
  OxygenSaturationVisualizationScreen({Key key, this.onGoToNextQuestion, this.onGoToBackQuestion}) : super(key: key);

  @override
  _OxygenSaturationVisualizationScreenState createState() => _OxygenSaturationVisualizationScreenState();
}

class _OxygenSaturationVisualizationScreenState extends State<OxygenSaturationVisualizationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 10),
              child: Column(
          children: [
            VisualizationHeader(text: 'Oxigeno',)
          ],
        ),
      ),
    );
  }

}
