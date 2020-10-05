import 'package:flutter/material.dart';


ThemeData kAppLightTheme = ThemeData.light().copyWith(
  primaryColor: Colors.indigo[900],
  primaryColorLight: Color(0xff534bae),
  primaryColorDark: Color(0xff000051),
  accentColor: Colors.indigoAccent,
  colorScheme: ThemeData.light().colorScheme.copyWith(
    primary: Colors.indigo[900],
    onPrimary: Colors.white,
  )
);