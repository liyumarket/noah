import 'package:flutter/material.dart';
import 'package:noahrealstate/app/config/color_constant.dart';

MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = {};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  strengths.forEach((strength) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  });
  return MaterialColor(color.value, swatch);
}

 // Define your custom theme with primary color
  final ThemeData customTheme = ThemeData(
    primaryColor: ColorConstants.primaryColor,
    primarySwatch: createMaterialColor(ColorConstants.primaryColor),
    brightness: Brightness.light,
    // appBarTheme: AppBarTheme(
    //   // backgroundColor: ColorConstants.primaryColor,
    //   foregroundColor: Colors.white,
    // ),
    // buttonTheme: ButtonThemeData(
    //   buttonColor: ColorConstants.primaryColor,
    //   textTheme: ButtonTextTheme.primary,
    // ),
    // textTheme: TextTheme(
    //   headline1: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
    //   bodyText1: TextStyle(fontSize: 16.0),
    // ),
  );