import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nepali_calendar/src/app_base.dart';
import 'package:nepali_calendar/src/cubit/bottom_menu_cubit.dart';
import 'package:nepali_calendar/src/cubit/language_cubit.dart';
import 'package:nepali_calendar/src/cubit/starting_cubit.dart';
import 'package:nepali_calendar/src/cubit/timer_cubit.dart';
import 'package:nepali_calendar/src/styles/theme.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: 'Nepali Calendar',
      debugShowCheckedModeBanner: false,
      theme: kAppLightTheme,
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => TimerCubit(),
          ),
          BlocProvider(
            create: (_) => StartingCubit(),
          ),
          BlocProvider(
            create: (_) => BottomMenuCubit(),
          ),
          BlocProvider(
            create: (_) => LanguageCubit(),
          ),
        ],
        child: AppBase(),
      ),
    );
  }
}
