import 'package:flutter/material.dart';
import 'package:nepali_calendar/src/reuseables/flat_icon_button.dart';

class BottomMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      height: 300.0,
      child: ListView(
        children: [
          FlatIconButton(
            firstChild: Icon(
              Icons.date_range,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            secondChild: Text(
              'Browse by year',
              style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
            ),
            containerUse: true,
            onPressed: () {},
          ),
          FlatIconButton(
            firstChild: Icon(
              Icons.settings,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            secondChild: Text(
              'Settings',
              style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
            ),
            containerUse: true,
            onPressed: () {},
          ),
          FlatIconButton(
            firstChild: Icon(
              Icons.info,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            secondChild: Text(
              'About us',
              style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
            ),
            containerUse: true,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
