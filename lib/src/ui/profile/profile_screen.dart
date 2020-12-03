import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';
class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key key}) : super(key: key);

  @override
  _ProfileScreemState createState() => _ProfileScreemState();
}

class _ProfileScreemState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Container(
      child: Center(
        child: MaterialButton(
          color: Colors.blue,
          child: Text('Sign Out'),
          onPressed: (){
            authProvider.signOut();
          },
        ),
      ),  
    );
  }
}