import 'package:flutter/material.dart';

class CurrentChallengeScreen extends StatefulWidget {
  CurrentChallengeScreen({Key key}) : super(key: key);

  @override
  _CurrentChallengeScreenState createState() => _CurrentChallengeScreenState();
}

class _CurrentChallengeScreenState extends State<CurrentChallengeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reto Actual'),
      ),
      body: Row(
        children: [
          
        ],
      ),
    );
  }
}
