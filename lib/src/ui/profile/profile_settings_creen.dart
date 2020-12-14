import 'package:flutter/material.dart';
class ProfileSettingsScreen extends StatefulWidget {
  ProfileSettingsScreen({Key key}) : super(key: key);

  @override
  _ProfileSettingsScreenState createState() => _ProfileSettingsScreenState();
}

class _ProfileSettingsScreenState extends State<ProfileSettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Configuraciones'),
      ),
      body: Column(
        children: [],
      ),
    );
  }
}