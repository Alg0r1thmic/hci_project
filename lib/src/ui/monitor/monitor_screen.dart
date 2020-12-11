
import 'package:flutter/material.dart';

import '../../core/routes/routes.dart';

class MonitorScreen extends StatefulWidget {
  MonitorScreen({Key key}) : super(key: key);

  @override
  _MonitorScreenState createState() => _MonitorScreenState();
}

class _MonitorScreenState extends State<MonitorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          MaterialButton(
            child: Text('Click!'),
            onPressed: () {
            Navigator.of(context).pushNamed(Routes.data_visualization);
          }),
        ],
      ),
    );
  }
}
