import 'package:flutter/material.dart';

Color hexToColor(String hex) {
  assert(RegExp(r'^#([0-9a-fA-F]{6})|([0-9a-fA-F]{8})$').hasMatch(hex),
      'hex color must be #rrggbb or #rrggbbaa');

  return Color(
    int.parse(hex.substring(1), radix: 16) +
        (hex.length == 7 ? 0xff000000 : 0x00000000),
  );
}

class ColorConstants {
  static Color lightScaffoldBackgroundColor = hexToColor('#F9F9F9');
  static Color primaryColor= hexToColor('#fd7e14');
  static Color darkScaffoldBackgroundColor = hexToColor('#2F2E2E');
  static Color secondaryAppColor = hexToColor('#E0E0E0');
  static Color darkButton = hexToColor('#151414');
  static Color gray= hexToColor('#BEC2C7');
  static Color secondaryDarkAppColor = Colors.white;
  static Color drawerBackground = hexToColor('#151414');
}