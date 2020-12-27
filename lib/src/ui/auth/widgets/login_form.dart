import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/auth_provider.dart';
import '../../../widgets/custom_button.dart';
import 'form_card.dart';
import 'input_text_login.dart';

class LoginForm extends StatefulWidget {
  final VoidCallback onGoToRegister;
  const LoginForm({Key key, @required this.onGoToRegister}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<InputTextLoginState> _emailKey = GlobalKey();
  final GlobalKey<InputTextLoginState> _passwordKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 150,),
            _formCard(context),
            Container(
                alignment: Alignment.centerRight,
                child: (authProvider.status == Status.Authenticating ||
                        authProvider.status == Status.GoogleAuthenticating)
                    ? CircularProgressIndicator()
                    : CustomButton(
                        text: 'Iniciar Sesión',
                        buttonColor: Colors.blueAccent,
                        ontap: ()async {
                           if (_formKey.currentState.validate()) {
                            FocusScope.of(context)
                                .unfocus(); //to hide the keyboard - if any

                            bool status =
                                await authProvider.signInWithEmailAndPassword(
                                    _emailKey.currentState.value,
                                    _passwordKey.currentState.value);

                            if (!status) {
                              Scaffold.of(context).showSnackBar(SnackBar(
                                content:Text('Ocurrio un error'),
                                duration: Duration(milliseconds: 400),
                              ));
                            }
                          }
                        },
                      )),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: _socialLoginText(),
            ),
            CustomButton(text: 'Crear Cuenta',ontap: widget.onGoToRegister,buttonColor: Colors.amber,)
          ],
        ),
      ),
    );
  }

  Widget _socialLoginText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        horizontalLine(),
        Text("O",
            style: TextStyle(fontSize: 16.0, fontFamily: "Poppins-Medium")),
        horizontalLine(),
      ],
    );
  }

  Widget horizontalLine() => Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Container(
          width: 100,
          height: 1.0,
          color: Colors.black26.withOpacity(.2),
        ),
      );

  Widget _formCard(BuildContext context) {
    return FormCard(
      cardItems: <Widget>[
        SizedBox(
          height: 50,
        ),
        Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              InputTextLogin(
                key: _emailKey,
                placeholder: "correo",
                incon: Icons.email,
                validator: (value) => (value.contains('@'))
                    ? null
                    : 'Verifica que el correo este bien',
              ),
              SizedBox(
                height: 15,
              ),
              InputTextLogin(
                key: _passwordKey,
                placeholder: "contraseña",
                incon: Icons.lock,
                isPassword: true,
                validator: (value) =>
                    (value.isEmpty) ? 'Ingrese una contraseña valida' :null ,
              )
            ],
          ),
        ),
        SizedBox(
          height: 15,
        ),
        _recoverPasswordText(context),
        SizedBox(
          height: 30,
        )
      ],
    );
  }

  Widget _recoverPasswordText(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        InkWell(
            onTap: () {
      
            },
            child: Text(
              "Olvidaste la contraseña?",
              style: TextStyle(
                  color: Colors.amber,
                  fontFamily: "Poppins-Medium",
                  fontSize: 14),
            ))
      ],
    );
  }
}
