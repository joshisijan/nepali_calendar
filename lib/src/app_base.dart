import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:nepali_calendar/src/cubit/calendar_cubit.dart';
import 'package:nepali_calendar/src/cubit/calendar_mode_cubit.dart';
import 'package:nepali_calendar/src/cubit/starting_cubit.dart';
import 'package:nepali_calendar/src/cubit/timer_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';
import 'package:nepali_calendar/src/screens/full_screen_scaffold_loader.dart';
import 'package:nepali_calendar/src/screens/home.dart';
import 'package:nepali_calendar/src/screens/first_starting.dart';
import 'package:nepali_calendar/src/screens/year_mode.dart';

class AppBase extends StatefulWidget {
  final int onYear;

  const AppBase({
    Key key,
    this.onYear,
  }) : super(key: key);
  @override
  _AppBaseState createState() => _AppBaseState();
}

class _AppBaseState extends State<AppBase> {
  Timer timeTimer;

  FirebaseMessaging firebaseMessaging = FirebaseMessaging();

  @override
  void initState() {
    super.initState();
    timeTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      context.bloc<TimerCubit>().getNewDateTime();
    });
    if (widget.onYear != null) {
      context.bloc<CalendarCubit>().getCalendar(widget.onYear);
    }
    firebaseMessaging.configure();
  }

  @override
  void dispose() {
    timeTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StartingCubit, bool>(
      builder: (context, state) {
        // while processing
        if (state == null)
          return FullScreenScaffoldLoadingScreen();
        else if (state == false)
          // if loading for first time
          return FirstWidget();
        // if loaging not for first time
        return WillPopScope(
          child: Stack(
            children: [
              Container(
                child: BlocBuilder<CalendarModeCubit, int>(
                  builder: (context, calendarModeState) {
                    if (calendarModeState == 0) {
                      return HomeScreen();
                    }
                    return YearMode();
                  },
                ),
              ),
            ],
          ),
          onWillPop: () {
            return showDialog(
              context: context,
              child: AlertDialog(
                backgroundColor: Theme.of(context).primaryColor,
                title: Text(
                  'Exit app',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
                content: Text(
                  'Do you want to exit the app?',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
                actions: [
                  IconButton(
                    icon: Icon(
                      Icons.check,
                      color: Colors.green,
                    ),
                    onPressed: () {
                      Navigator.pop(context, true);
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.close,
                      color: Theme.of(context).errorColor,
                    ),
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
