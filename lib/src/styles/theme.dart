import 'package:flutter/material.dart';

ColorScheme kLightColorScheme = ThemeData.light().colorScheme.copyWith(
      primary: Colors.indigo[900],
      onPrimary: Colors.white,
    );

ThemeData kAppLightTheme = ThemeData.light().copyWith(
  primaryColor: Colors.indigo[900],
  primaryColorLight: Color(0xff534bae),
  primaryColorDark: Color(0xff000051),
  accentColor: Colors.indigoAccent,
  colorScheme: kLightColorScheme,
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Colors.indigo[900],
  ),
);
