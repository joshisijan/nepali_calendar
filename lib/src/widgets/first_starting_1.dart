import 'package:flutter/material.dart';

class FirstWidget1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(
          height: 80.0,
        ),
        Text(
          'Welcome to\nNepali Calendar',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline4.copyWith(
                color: Theme.of(context).colorScheme.onPrimary.withAlpha(180),
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    );
  }
}
