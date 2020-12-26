import 'package:flutter/material.dart';
import 'package:health_body_checking/src/models/user_model.dart';
import 'package:health_body_checking/src/services/base.service.dart';
import 'package:health_body_checking/src/services/hearth_service.dart';
import 'package:health_body_checking/src/services/imc_service.dart';
import 'package:health_body_checking/src/services/oxygen_saturation_service.dart';
import 'package:health_body_checking/src/services/temperature_service.dart';
import 'package:health_body_checking/src/ui/monitor/hearth_rate/hearth_rate_visualization_screen.dart';
import 'package:health_body_checking/src/ui/monitor/imc/imc_visualization_screen.dart';

import '../../constants/app_colors.dart';
import 'oxygen_saturation/oxygen_saturation_visualization_screen.dart';
import 'temperature/temperature_visualization_screen.dart';

class DataVisualizationScreen extends StatefulWidget {
  DataVisualizationScreen({Key key}) : super(key: key);

  @override
  _DataVisualizationScreenState createState() => _DataVisualizationScreenState();
}

class _DataVisualizationScreenState extends State<DataVisualizationScreen> {
  List<Widget> _visualizationScreens=[];
  List<String> _names=[];
  @override
  void initState() { 
    super.initState();
    _generateScreens();
  }
  void _generateScreens(){
    CurrentUserModel.instance.sensors.forEach((element){
      if(element.enabled){
        _visualizationScreens.add(_sensorScreens[element.sensorName]);
        _names.add(element.sensorName);
      }
    });
    setState(() {
      
    });
  }
  Map<String,Widget> _sensorScreens={
    "Temperatura":new TemperatureVisualizationScreen(),
    "Oximetro":new OxygenSaturationVisualizationScreen(),
    "HearthRate":new HearthRateVisualizationScreen(),
    "Imc":new ImcVisualizationScreen()
  };
  List<String> names = [
    "Latidos por minuto",
    "Índice de masa corporal",
    "Temperatura",
    "Saturacion de oxigeno"
  ];

  @override
  Widget build(BuildContext context) {
    final String args = ModalRoute.of(context).settings.arguments;
    return DefaultTabController(
        initialIndex:_names.indexOf(args),
        length: CurrentUserModel.instance.sensors.fold(0,(enabled,sensor)=>(sensor.enabled)?enabled+1:enabled+0),
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
              backgroundColor: AppColors.ALICE_BLUE,
              elevation: 0.0,
              leading: InkWell(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Icon(Icons.west, color: Colors.black,),
              ),
              bottom: _tabBarHeader()
          ),
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: _visualizationScreens
          ),
        )
    );
  }

  Widget _tabBarHeader() {
    return TabBar(
        isScrollable: true,
        unselectedLabelColor: AppColors.PRIMARY_DARK,
        indicatorSize: TabBarIndicatorSize.label,
        indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: AppColors.PRIMARY_DARK),
        tabs: _getsTabs()
    );
  }

  List<Widget> _getsTabs() {
    List<Widget> list = [];
    CurrentUserModel.instance.sensors.forEach((element){
      if(element.enabled){
        list.add(_tabBarHeaderTextContainer(text: element.displayName));
      }
    });
    return list;
  }

  Widget _tabBarHeaderTextContainer({String text}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          border: Border.all(color: AppColors.PRIMARY_DARK, width: 1)),
      child: Align(
        alignment: Alignment.center,
        child: Text(text),
      ),
    );
  }

}
