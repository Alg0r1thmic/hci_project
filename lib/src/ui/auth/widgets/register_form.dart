import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/user_model.dart';
import '../../../providers/auth_provider.dart';
import '../../../widgets/custom_button.dart';
import 'form_card.dart';
import 'input_text_header.dart';
import 'input_text_login.dart';

class RegisterForm extends StatefulWidget {
  final VoidCallback onGoToLogin;
  const RegisterForm({Key key, @required this.onGoToLogin}) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<InputTextLoginState> _userKey = GlobalKey();
  final GlobalKey<InputTextLoginState> _emailKey = GlobalKey();
  final GlobalKey<InputTextLoginState> _passwordKey = GlobalKey();
  final GlobalKey<InputTextLoginState> _vpasswordKey = GlobalKey();
  
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 150,
            ),
            _formCard(context),
            SizedBox(
              height: 20,
            ),
            (authProvider.status==Status.Registering||authProvider.status==Status.GoogleAuthenticating)?
            Center(
              child: CircularProgressIndicator(),
            )
            :CustomButton(
              text: 'Crear cuenta',
              buttonColor: Colors.blue,
              ontap:()async{
                if(_formKey.currentState.validate()){ 
                  FocusScope.of(context).unfocus();
                  UserModel userModel=await authProvider.registerWithEmailAndPassword(_userKey.currentState.value,_emailKey.currentState.value,_passwordKey.currentState.value);
                  if(userModel==null){
                    Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content:Text('Ocurrio un error'),
                      duration: Duration(milliseconds: 400),
                    )
                    );
                  }
                }
              }
            ),
            SizedBox(
              height: 20,
            ),
            CustomButton(text: 'Iniciar sesion',buttonColor: Colors.amber,ontap: widget.onGoToLogin,),
          ],
        ),
      ),
    );
  }

  Widget _formCard(BuildContext context) {
    return FormCard(
      cardItems: <Widget>[
        SizedBox(
          height: 15,
        ),
        Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              InputTextHeader(title: "Usuario"),
              InputTextLogin(
                  key: _userKey,
                  placeholder: "usuario",
                  incon: Icons.person,
                  validator: (value) =>
                      (value.isEmpty) ? "Por fabor ingresa un Usuario" : null),
              SizedBox(
                height: 15,
              ),
              InputTextHeader(title: "Correo"),
              InputTextLogin(
                  key: _emailKey,
                  placeholder: "correo",
                  incon: Icons.email,
                  validator: (value) =>
                      (value.contains('@')) ? null : "Ingrese un email correcto"),
              SizedBox(
                height: 15,
              ),
              InputTextHeader(title: "Contraseña"),
              InputTextLogin(
                  key: _passwordKey,
                  placeholder: "contraseña",
                  incon: Icons.lock,
                  isPassword: true,
                  validator: (value) => (value.trim().length>=6)
                      ? null
                      : "la contraseña debe tener almenos 6 caracteres"),
              SizedBox(
                height: 15,
              ),
              InputTextHeader(title: "Confirmar contraseña"),
              InputTextLogin(
                  key: _vpasswordKey,
                  placeholder: "confirmar contraseña",
                  incon: Icons.lock,
                  isPassword: true,
                  validator: (value) =>
                      (value.trim().length>=6 && _vpasswordKey.currentState.value==_passwordKey.currentState.value) ?null:"Verifique que la contraseña sea igual a la anteior")
            ],
          ),
        ),
        SizedBox(
          height: 15,
        ),
        SizedBox(
          height: 30,
        )
      ],
    );
  }
}
