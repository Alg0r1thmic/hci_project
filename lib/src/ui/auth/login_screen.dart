
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../widgets/backgroundImage.dart';
import 'widgets/login_form.dart';
import 'widgets/register_form.dart';
class LoginFormType {
  LoginFormType._();
  static const int LOGIN=0;
  static const int REGISTER=1;
}
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen> {
  final _key = GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> get scaffoldKey=>_key;
  PageController _pageController=PageController(initialPage: 0);
  @override
  void initState(){
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
  }
  @override
  void dispose() { 
    _pageController.dispose();
    super.dispose();
  }
  void _switchForm(int page){
    _pageController.animateToPage(page, duration:Duration(milliseconds: 300), curve:Curves.fastOutSlowIn);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: false,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          BackgroundImage(),
          PageView(
            physics:NeverScrollableScrollPhysics(),
            controller: _pageController,
            children: <Widget>[
              LoginForm(onGoToRegister: (){_switchForm(LoginFormType.REGISTER);},),
              RegisterForm(onGoToLogin: (){_switchForm(LoginFormType.LOGIN);},)
            ],
          )
        ],
      ),
    );
  }
 
}