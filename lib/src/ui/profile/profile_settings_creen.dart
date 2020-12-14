import 'package:flutter/material.dart';

import '../../models/user_model.dart';
import '../../services/user_service.dart';

class ProfileSettingsScreen extends StatefulWidget {
  ProfileSettingsScreen({Key key}) : super(key: key);

  @override
  _ProfileSettingsScreenState createState() => _ProfileSettingsScreenState();
}

class _ProfileSettingsScreenState extends State<ProfileSettingsScreen> {
  UserService _userService;
  @override
  void initState() {
    super.initState();
    _userService = UserService();
    //_setSensorsToUser();
  }
  // _setSensorsToUser() {
  //   final _sensorService = SensorService();
  //   final _userService = UserService();
  //   List<SensorModel> list = List();
  //   _sensorService.sensorsStream().listen((event) {
  //     list = event;
  //     CurrentUserModel.instance.sensors = list;
  //     _userService.setUser(CurrentUserModel.instance);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Configuraciones'),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 20, right: 20, top: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('SENSORES'),
            SizedBox(
              height: 20,
            ),
            Expanded(child: _listOfSensors())
          ],
        ),
      ),
    );
  }

  Widget _listOfSensors() {
    return StreamBuilder(
        stream: _userService.userStream(id: CurrentUserModel.instance.id),
        builder: (BuildContext context, AsyncSnapshot<CurrentUserModel> snapshot) {
          if (snapshot.hasData) {
            CurrentUserModel user = snapshot.data;
            return (user.sensors!=null)? ListView.separated(
              itemCount: user.sensors.length,
              itemBuilder: (BuildContext context, index) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(user.sensors[index].name),
                    Switch(
                        value: user.sensors[index].enabled,
                        onChanged: (value) {
                          setState(() {
                            user.sensors[index].enabled = value;
                            _userService.setUser(user);
                          });
                        })
                  ],
                );
              },
              separatorBuilder: (BuildContext context, index) {
                return Divider();
              },
            ):Text('Actualmente no tiene ningun sensor');
          }
          return Center(child: CircularProgressIndicator());
        });
  }
}
