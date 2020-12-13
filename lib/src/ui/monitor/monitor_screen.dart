import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:health_body_checking/src/constants/app_colors.dart';
import 'package:health_body_checking/src/models/sensor_model.dart';
import 'package:health_body_checking/src/ui/monitor/widgets/sensor_card.dart';

class MonitorScreen extends StatefulWidget {
  MonitorScreen({Key key}) : super(key: key);

  @override
  _MonitorScreenState createState() => _MonitorScreenState();
}

class _MonitorScreenState extends State<MonitorScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  static const _kFontFam = 'Health';
  static const _kFontPkg = null;

  List<SensorModel> items = [
    SensorModel(id: 0, value: 35.6, time: Timestamp(10,5)),
    SensorModel(id: 1, value: 35.6, time: Timestamp(10,5)),
    SensorModel(id: 2, value: 35.6, time: Timestamp(10,5))
  ];
  static const List<IconData> icons = [
    IconData(0xf21e, fontFamily: _kFontFam, fontPackage: _kFontPkg),
    IconData(0xf496, fontFamily: _kFontFam, fontPackage: _kFontPkg),
    IconData(0xf2c9, fontFamily: _kFontFam, fontPackage: _kFontPkg)
  ];
  List<String> names = [
    "Latidos por minuto",
    "Índice de masa corporal",
    "Temperatura"
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: AppColors.ALICE_BLUE,
          elevation: 0.0,
          title: _tabBarHeader()
        ),
        body: TabBarView(
          children: [_monitor(), _riskMap()],
        ),
      )
    );
  }

  Widget _tabBarHeader() {
    return TabBar(
      unselectedLabelColor: AppColors.PRIMARY_DARK,
      indicatorSize: TabBarIndicatorSize.label,
      indicator: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: AppColors.PRIMARY_DARK),
      tabs: [_tabBarHeaderTextContainer(text: 'Monitor'), _tabBarHeaderTextContainer(text: 'Mapa de riesgo')]
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

  Widget _monitor() {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return SensorCard(icon: icons[index], name: names[index], sensor: items[index],);
          },
        ),
    );
  }

  Widget _riskMap() {
    return Container();
  }
}

