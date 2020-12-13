import 'package:flutter/material.dart';
import 'package:health_body_checking/src/ui/monitor/oxygen_saturation/oxygen_saturation_visualization_screen.dart';
import 'package:health_body_checking/src/ui/monitor/temperature/temperature_visualization_screen.dart';
import 'package:health_body_checking/src/constants/app_colors.dart';

class DataVisualizationScreen extends StatefulWidget {
  DataVisualizationScreen({Key key}) : super(key: key);

  @override
  _DataVisualizationScreenState createState() => _DataVisualizationScreenState();
}

class _DataVisualizationScreenState extends State<DataVisualizationScreen> {

  List<String> names = [
    "Latidos por minuto",
    "Índice de masa corporal",
    "Temperatura"
  ];

  @override
  Widget build(BuildContext context) {
    final int args = ModalRoute.of(context).settings.arguments;
    return DefaultTabController(
        initialIndex: args,
        length: names.length,
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
            children: [
              OxygenSaturationVisualizationScreen(),
              OxygenSaturationVisualizationScreen(),
              TemperatureVisualizationScreen(),
            ],
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
        tabs: [
          _tabBarHeaderTextContainer(text: names[0]),
          _tabBarHeaderTextContainer(text: names[1]),
          _tabBarHeaderTextContainer(text: names[2]),
        ]
    );
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
