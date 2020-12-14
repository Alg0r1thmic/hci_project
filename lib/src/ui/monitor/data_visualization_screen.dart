import 'package:flutter/material.dart';

import 'oxygen_saturation/oxygen_saturation_visualization_screen.dart';
import 'temperature/temperature_visualization_screen.dart';

class VisualizationIndex {
  VisualizationIndex._();
  static const int VIS_0 = 0;
  static const int VIS_1 = 1;
  static const int VIS_2 = 2;
  static const int VIS_3 = 3;
  static const int VIS_4 = 4;
}

class DataVisualizationScreen extends StatefulWidget {
  DataVisualizationScreen({Key key}) : super(key: key);

  @override
  _DataVisualizationScreenState createState() => _DataVisualizationScreenState();
}

class _DataVisualizationScreenState extends State<DataVisualizationScreen> {
  PageController _pageController = PageController(initialPage: 0);
  @override
  void initState() {
    super.initState();
  }

  void _switchForm(int page) {
    _pageController.animateToPage(page, duration: Duration(milliseconds: 300), curve: Curves.fastOutSlowIn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('visualisacion'),
      ),
      body:PageView(
        controller: _pageController,
        children: <Widget>[
          TemperatureVisualizationScreen(
            onGoToNextQuestion: () {
              _switchForm(VisualizationIndex.VIS_1);
            },
          ),
          OxygenSaturationVisualizationScreen(
            onGoToNextQuestion: (){
              _switchForm(VisualizationIndex.VIS_0);
            },
            onGoToBackQuestion: (){
              _switchForm(VisualizationIndex.VIS_2);
            },
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
