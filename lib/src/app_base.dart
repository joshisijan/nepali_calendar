import 'package:flutter/material.dart';
import 'package:nepali_calendar/data/years/2000.json';

class AppBase extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).primaryColor,
        child: Text('This is a container'),
      ),
    );
  }
}
