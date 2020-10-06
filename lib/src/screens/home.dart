import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nepali_calendar/src/cubit/calendar_cubit.dart';
import 'package:nepali_calendar/src/cubit/timer_cubit.dart';
import 'package:nepali_calendar/src/models/time_model.dart';
import 'package:nepali_calendar/src/widgets/bottom_navigation_bar.dart';
import 'package:nepali_calendar/src/widgets/calendar_container.dart';
import 'package:nepali_calendar/src/widgets/calendar_error.dart';

class HomeScreen extends StatelessWidget {
  final language = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorDark,
      body: BlocBuilder<TimerCubit, CurrentTimeModel>(
        builder: (context, timeState) {
          return BlocBuilder<CalendarCubit, CalendarState>(
            builder: (context, calendarState) {
              if (calendarState is CalendarError) {
                return CustomCalendarError(
                  title: calendarState.error,
                  onPressed: () {
                    context
                        .bloc<CalendarCubit>()
                        .getCalendar(timeState.nepaliDateTime.year);
                  },
                );
              } else if (calendarState is CalendarFileError) {
                return CustomCalendarError(
                  title: calendarState.error,
                  onPressed: () {
                    context
                        .bloc<CalendarCubit>()
                        .getCalendar(timeState.nepaliDateTime.year);
                  },
                );
              } else if (calendarState is CalendarLoaded) {
                return CalendarContainer(
                  monthCalendar: calendarState.calendar['coreData'][language]
                      ['data'][0],
                );
              }
              return CustomCalendarError(
                loading: true,
              );
            },
          );
        },
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.calendar_today),
        onPressed: () {},
      ),
    );
  }
}
