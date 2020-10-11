import 'package:flutter/material.dart';

ColorScheme kLightColorScheme = ThemeData.light().colorScheme.copyWith(
      primary: Colors.indigo[900],
      onPrimary: Colors.white,
      secondary: Colors.lightBlue,
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
  buttonColor: Colors.blue[800],
);

ThemeData kAppDarkTheme = ThemeData.dark().copyWith(
  colorScheme: ThemeData.dark().colorScheme.copyWith(
        secondary: Colors.blueGrey,
      ),
  accentColor: ThemeData.dark().primaryColorLight,
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: ThemeData.dark().primaryColor,
  ),
);
