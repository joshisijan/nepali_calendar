import 'package:flutter/material.dart';
import 'package:nepali_calendar/src/cubit/calendar_cubit.dart';
import 'package:nepali_calendar/src/cubit/starting_cubit.dart';
import 'package:nepali_calendar/src/cubit/timer_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';
import 'package:nepali_calendar/src/screens/full_screen_scaffold_loader.dart';
import 'package:nepali_calendar/src/screens/home.dart';
import 'package:nepali_calendar/src/screens/first_starting.dart';

class AppBase extends StatefulWidget {
  @override
  _AppBaseState createState() => _AppBaseState();
}

class _AppBaseState extends State<AppBase> {
  Timer timeTimer;

  @override
  void initState() {
    super.initState();
    timeTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      context.bloc<TimerCubit>().getNewDateTime();
    });
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
        return BlocProvider(
          create: (context) => CalendarCubit(),
          child: HomeScreen(),
        );
      },
    );
  }
}
