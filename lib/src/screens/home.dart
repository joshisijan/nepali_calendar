import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nepali_calendar/src/cubit/bottom_menu_cubit.dart';
import 'package:nepali_calendar/src/cubit/calendar_cubit.dart';
import 'package:nepali_calendar/src/cubit/language_cubit.dart';
import 'package:nepali_calendar/src/cubit/timer_cubit.dart';
import 'package:nepali_calendar/src/models/time_model.dart';
import 'package:nepali_calendar/src/widgets/bottom_menu.dart';
import 'package:nepali_calendar/src/widgets/bottom_navigation_bar.dart';
import 'package:nepali_calendar/src/widgets/calendar_container.dart';
import 'package:nepali_calendar/src/widgets/calendar_error.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageCubit, int>(
      builder: (context, languageState) {
        int language = languageState;
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
                    return BlocBuilder<BottomMenuCubit, bool>(
                      builder: (context, bottomMenuState) {
                        return Stack(
                          fit: StackFit.expand,
                          children: [
                            GestureDetector(
                              onTap: bottomMenuState
                                  ? () {
                                      context
                                          .bloc<BottomMenuCubit>()
                                          .toggleMenu();
                                    }
                                  : null,
                              child: AnimatedOpacity(
                                duration: Duration(milliseconds: 350),
                                opacity: bottomMenuState ? 0.6 : 1.0,
                                child: AbsorbPointer(
                                  absorbing: bottomMenuState,
                                  child: CalendarContainer(
                                    yearCalendar: calendarState
                                        .calendar['coreData'][language]['data'],
                                    year: timeState.nepaliDateTime.year,
                                    month: timeState.nepaliDateTime.month,
                                    day: timeState.nepaliDateTime.day,
                                  ),
                                ),
                              ),
                            ),
                            AnimatedPositioned(
                              curve: Curves.decelerate,
                              duration: Duration(milliseconds: 350),
                              bottom: bottomMenuState ? 0.0 : -300.0,
                              left: 0.0,
                              right: 0.0,
                              child: BottomMenu(),
                            ),
                          ],
                        );
                      },
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
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: BlocBuilder<BottomMenuCubit, bool>(
            builder: (context, bottomMenuCubit) {
              return AnimatedCrossFade(
                crossFadeState: !bottomMenuCubit
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
                duration: Duration(milliseconds: 350),
                firstChild: FloatingActionButton(
                  child: Icon(Icons.today),
                  onPressed: () {},
                ),
                secondChild: SizedBox.shrink(),
              );
            },
          ),
        );
      },
    );
  }
}
