import 'package:flutter/material.dart';

class CustomIcons {
  static const _kFontFam = 'MyFlutterApp';
  static const _kFontPkg = null;
  static const IconData TWITTER = IconData(0xe900, fontFamily: "CustomIcons");
  static const IconData FACEBOOK = IconData(0xe901, fontFamily: "CustomIcons");
  static const IconData GOOGLE_PLUS = IconData(0xe902, fontFamily: "CustomIcons");
  static const IconData LINKEDIN = IconData(0xe903, fontFamily: "CustomIcons");
  static const IconData bxs_bot = IconData(0xe802, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData bx_scan = IconData(0xe803, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData bxs_car_mechanic = IconData(0xe804, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData bxs_cart = IconData(0xe805, fontFamily: _kFontFam, fontPackage: _kFontPkg);

  //monitor icons
  static const _monitorFontFam = 'Health';
  static const IconData PPM=  IconData(0xf21e, fontFamily: _monitorFontFam, fontPackage: _kFontPkg);
  static const IconData WEIGHT_SCALE=  IconData(0xf496, fontFamily: _monitorFontFam, fontPackage: _kFontPkg);
  static const IconData TEMPERATURE=  IconData(0xf2c9, fontFamily: _monitorFontFam, fontPackage: _kFontPkg);
  static const IconData HEART=  IconData(0xf604, fontFamily: 'Lungs', fontPackage: _kFontPkg);

  static final icons = {
    "twitter": TWITTER,
    "facebook": FACEBOOK,
    "google_plus": GOOGLE_PLUS,
    "linkedin": LINKEDIN,
    //monitor icons
    "ppm":PPM,
    "weight_scale":WEIGHT_SCALE,
    "temperature":TEMPERATURE,
    "heart":HEART
  };
  static IconData getIcon(String name) {
    return icons[name];
  }
}
