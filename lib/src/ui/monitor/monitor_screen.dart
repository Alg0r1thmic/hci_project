import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:health_body_checking/src/services/oxygen_saturation_service.dart';

import '../../constants/app_colors.dart';
import '../../constants/custom_icons..dart';
import '../../models/sensor_model.dart';
import '../../models/user_model.dart';
import 'widgets/sensor_card.dart';

class MonitorScreen extends StatefulWidget {
  MonitorScreen({Key key}) : super(key: key);

  @override
  _MonitorScreenState createState() => _MonitorScreenState();
}

class _MonitorScreenState extends State<MonitorScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  OxygenSaturationService _oxygenSaturationService;
  @override
  void initState() {
    _oxygenSaturationService=OxygenSaturationService();
    super.initState();
  }
  List<SensorModel> items = [SensorModel(value: 35.6, time: Timestamp(10, 5)), SensorModel(value: 35.6, time: Timestamp(10, 5)), SensorModel(value: 35.6, time: Timestamp(10, 5)), SensorModel(value: 35.6, time: Timestamp(10, 5))];
  List<IconData> icons = [
    CustomIcons.icons["ppm"],
    CustomIcons.icons["weight_scale"],
    CustomIcons.icons["temperature"],
    CustomIcons.icons["hearth"],
  ];
  List<String> names = ["Latidos por minuto", "Índice de masa corporal", "Temperatura", "Saturacion de oxigeno"];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(backgroundColor: AppColors.ALICE_BLUE, elevation: 0.0, title: _tabBarHeader()),
          body: TabBarView(
            children: [_monitor(), _riskMap()],
          ),
        ));
  }

  Widget _tabBarHeader() {
    return TabBar(unselectedLabelColor: AppColors.PRIMARY_DARK, indicatorSize: TabBarIndicatorSize.label, indicator: BoxDecoration(borderRadius: BorderRadius.circular(50), color: AppColors.PRIMARY_DARK), tabs: [_tabBarHeaderTextContainer(text: 'Monitor'), _tabBarHeaderTextContainer(text: 'Mapa de riesgo')]);
  }

  Widget _tabBarHeaderTextContainer({String text}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(50), border: Border.all(color: AppColors.PRIMARY_DARK, width: 1)),
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
        itemCount: CurrentUserModel.instance.sensors.length,
        itemBuilder: (context, index) {
          return(CurrentUserModel.instance.sensors[index].enabled)? SensorCard(
            icon: CustomIcons.icons[CurrentUserModel.instance.sensors[index].icon],
            name:CurrentUserModel.instance.sensors[index].displayName,
            sensor:CurrentUserModel.instance.sensors[index],
            service: _oxygenSaturationService,
          ):null;
        },
      ),
    );
  }

  Widget _riskMap() {
    return Container();
  }
}
