import 'package:flutter/material.dart';
import 'package:health_body_checking/src/models/temperature_model.dart';
import 'package:health_body_checking/src/services/temperature_service.dart';
import 'package:provider/provider.dart';

class DataVisualizationScren extends StatefulWidget {
  DataVisualizationScren({Key key}) : super(key: key);

  @override
  _DataVisualizationScrenState createState() => _DataVisualizationScrenState();
}

class _DataVisualizationScrenState extends State<DataVisualizationScren> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data visualization'),
      ),
      body: _temperatureList(),
    );
  }

  Widget _temperatureList() {
    final database = Provider.of<TemperatureService>(context, listen: false);

    return StreamBuilder(
      stream: database.temperaturesStream(),
      builder: (BuildContext context, AsyncSnapshot<List<TemperatureModel>> snapshot) {
        if (snapshot.hasData) {
          List<TemperatureModel> _temperatures = snapshot.data;
          return ListView.separated(
              itemBuilder: (context, index) {
                return Text('Temperature ${_temperatures[index].temperature}');
              },
              separatorBuilder: (context, index) {
                return Divider(
                  height: 10,
                );
              },
              itemCount: _temperatures.length);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
