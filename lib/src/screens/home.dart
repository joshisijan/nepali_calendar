import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nepali_calendar/src/cubit/bottom_menu_cubit.dart';
import 'package:nepali_calendar/src/cubit/calendar_cubit.dart';
import 'package:nepali_calendar/src/cubit/language_cubit.dart';
import 'package:nepali_calendar/src/cubit/timer_cubit.dart';
import 'package:nepali_calendar/src/models/time_model.dart';
import 'package:nepali_calendar/src/screens/downloading_widget.dart';
import 'package:nepali_calendar/src/services/time_util.dart';
import 'package:nepali_calendar/src/widgets/bottom_menu.dart';
import 'package:nepali_calendar/src/widgets/bottom_navigation_bar.dart';
import 'package:nepali_calendar/src/widgets/calendar_container.dart';
import 'package:nepali_calendar/src/widgets/calendar_error.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomMenuCubit, bool>(
      builder: (context, bottomMenuState) {
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
                              child: CustomCalendarError(
                                title: languageState == 0
                                    ? 'An error occurred. Try Again'
                                    : 'त्रुटि देखा पर्‍यो। फेरि प्रयास गर्नुहोस्',
                                onPressed: () {
                                  context.bloc<CalendarCubit>().getCalendar(
                                      timeState.nepaliDateTime.year);
                                },
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
                      } else if (calendarState is CalendarFileError) {
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
                              child: CustomCalendarError(
                                title: languageState == 0
                                    ? 'Calendar not Downloaded for year ${timeState.nepaliDateTime.year.toString()}. Download by clicking on the button above.'
                                    : 'वर्ष ${CustomTimeUtil().englishToNepaliDate(timeState.nepaliDateTime.year)} को लागि क्यालेन्डर डाउनलोड गरिएको छैन। माथिको बटन क्लिक गरेर डाउनलोड गर्नुहोस्',
                                icon: Icons.download_sharp,
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushReplacement(PageRouteBuilder(
                                    pageBuilder: (_, animation, __) {
                                      return DownloadingFileWidget();
                                    },
                                    transitionDuration:
                                        Duration(milliseconds: 350),
                                    transitionsBuilder:
                                        (_, animation, __, child) {
                                      animation = CurvedAnimation(
                                        curve: Curves.decelerate,
                                        parent: animation,
                                      );
                                      return SlideTransition(
                                        position: Tween(
                                          begin: Offset(1.0, 0.0),
                                          end: Offset(0.0, 0.0),
                                        ).animate(animation),
                                        child: child,
                                      );
                                    },
                                  ));
                                },
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
                      } else if (calendarState is CalendarLoaded) {
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
                                    currentYear: timeState.nepaliDateTime.year,
                                    yearCalendar: calendarState
                                        .calendar['coreData'][language]['data'],
                                    year: calendarState.calendar['year'] ==
                                            timeState.nepaliDateTime.year
                                        ? timeState.nepaliDateTime.year
                                        : calendarState.calendar['year'],
                                    month: calendarState.calendar['year'] ==
                                            timeState.nepaliDateTime.year
                                        ? timeState.nepaliDateTime.month
                                        : 1,
                                    day: calendarState.calendar['year'] ==
                                            timeState.nepaliDateTime.year
                                        ? timeState.nepaliDateTime.day
                                        : 1,
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
                      }
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
                            child: CustomCalendarError(
                              loading: true,
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
      },
    );
  }
}
