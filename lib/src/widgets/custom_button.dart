import 'package:flutter/material.dart';

import '../constants/app_font_family.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback ontap;
  final Color buttonColor;
  const CustomButton({Key key, @required this.text, this.ontap, this.buttonColor, })
      : assert(text != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: buttonColor),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: null,
            child: Center(
              child: Text(
                text,
                style: TextStyle(color: Colors.white, fontFamily: AppFontFamily.POPPINS_BOLD, fontSize: 18, letterSpacing: 1.0),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
