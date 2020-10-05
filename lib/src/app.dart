import 'package:flutter/material.dart';
import 'package:nepali_calendar/src/app_base.dart';
import 'package:nepali_calendar/src/styles/theme.dart';

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nepali Calendar',
      debugShowCheckedModeBanner: false,
      theme: kAppLightTheme,
      home: AppBase(),
    );
  }
}

