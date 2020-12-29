import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DialogHelp extends StatelessWidget {

  final content;
  final context;
  DialogHelp({Key key, this.content, @required this.context}) : super(key: key);

  @override
  Widget build(BuildContext context) {
      return IconButton(
          icon: Icon(Icons.help_outline_rounded),
          onPressed: showAlertDialog(this.context)
      );
  }

  showAlertDialog(BuildContext context) {

    // set up the button
    Widget okButton = FlatButton(
      child: Text("Cerrar"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Ayuda"),
      content: Text(content),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}