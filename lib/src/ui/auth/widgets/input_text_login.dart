import 'package:flutter/material.dart';
class InputTextLogin extends StatefulWidget {
  final String placeholder;
  final IconData incon;
  final bool isPassword;
  final String Function(String text) validator;
  final String initvalue;
  const InputTextLogin({Key key,@required this.placeholder,@required this.incon, this.isPassword=false, this.validator, this.initvalue=''}) 
  :assert(incon!=null && placeholder!=null), super(key: key);

  @override
  InputTextLoginState createState() => InputTextLoginState();
}
class InputTextLoginState extends State<InputTextLogin> {
  TextEditingController _textController;
  String get value=>_textController.text;
  
  @override
  void initState() { 
    super.initState();
    _textController=TextEditingController(text: widget.initvalue);
  }
  @override
  void dispose() { 
    _textController?.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _textController,
      textInputAction: TextInputAction.next,
      obscureText:this.widget.isPassword,
      decoration: InputDecoration(
        hintText: widget.placeholder,
        hintStyle: TextStyle(
          color: Colors.grey,fontSize: 12.0
        ),
        prefixIcon: Icon(this.widget.incon),
        //suffix:widget.validator!=null?Icon(Icons.check_circle):null
      ),
      keyboardType: TextInputType.emailAddress,
      //controller: _email,
      validator:widget.validator,    
    );
  }
}