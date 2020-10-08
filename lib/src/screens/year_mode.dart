import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nepali_calendar/src/cubit/bottom_menu_cubit.dart';
import 'package:nepali_calendar/src/cubit/calendar_cubit.dart';
import 'package:nepali_calendar/src/cubit/calendar_mode_cubit.dart';
import 'package:nepali_calendar/src/cubit/downloaded_year_cubit.dart';
import 'package:nepali_calendar/src/cubit/downloaded_year_state.dart';
import 'package:nepali_calendar/src/cubit/language_cubit.dart';
import 'package:nepali_calendar/src/cubit/timer_cubit.dart';
import 'package:nepali_calendar/src/models/time_model.dart';
import 'package:nepali_calendar/src/screens/downloading_widget.dart';
import 'package:nepali_calendar/src/services/time_util.dart';
import 'package:nepali_calendar/src/widgets/bottom_menu.dart';
import 'package:nepali_calendar/src/widgets/bottom_navigation_bar.dart';
import 'package:nepali_calendar/src/widgets/calendar_error.dart';

class YearMode extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimerCubit, CurrentTimeModel>(
      builder: (context, timeState) {
        return BlocBuilder<BottomMenuCubit, bool>(
          builder: (context, bottomMenuState) {
            return BlocBuilder<LanguageCubit, int>(
              builder: (context, languageState) {
                return Scaffold(
                  backgroundColor: Theme.of(context).primaryColorDark,
                  body: Stack(
                    fit: StackFit.expand,
                    children: [
                      BlocBuilder<DownloadedYearCubit, DownloadedYearState>(
                        builder: (context, downloadedYearState) {
                          if (downloadedYearState is DownloadedYearError) {
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
                            );
                          } else if (downloadedYearState
                              is DownloadedYearEmpty) {
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
                                    ? 'No calendar downloaded yet'
                                    : 'कुनै पात्रो अझै डाउनलोड गरिएको छैन',
                                onPressed: () {
                                  context.bloc<CalendarCubit>().getCalendar(
                                      timeState.nepaliDateTime.year);
                                },
                              ),
                            );
                          } else if (downloadedYearState
                              is DownloadedYearLoaded) {
                            return GestureDetector(
                              onTap: bottomMenuState
                                  ? () {
                                      context
                                          .bloc<BottomMenuCubit>()
                                          .toggleMenu();
                                    }
                                  : null,
                              child: Center(
                                child: ListView(
                                    children: <Widget>[
                                          AppBar(
                                            elevation: 0.0,
                                            title: Text(
                                              languageState == 0
                                                  ? 'Downloaded Calendars'
                                                  : 'डाउनलोड गरिएको पात्रोहरू',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline6
                                                  .copyWith(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .onPrimary,
                                                    fontSize: 15.0,
                                                  ),
                                            ),
                                          ),
                                        ] +
                                        List.generate(
                                            downloadedYearState.years.length,
                                            (index) {
                                          return ListTile(
                                            trailing: IconButton(
                                              icon: Icon(
                                                Icons.open_in_new,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onPrimary,
                                              ),
                                              onPressed: () {
                                                context
                                                    .bloc<CalendarCubit>()
                                                    .getCalendar(
                                                        downloadedYearState
                                                            .years[index]);
                                                context
                                                    .bloc<CalendarModeCubit>()
                                                    .changeMode(0);
                                              },
                                            ),
                                            leading: IconButton(
                                              icon: Icon(
                                                Icons.close,
                                                color: Theme.of(context)
                                                    .errorColor,
                                              ),
                                              onPressed: () {
                                                context
                                                    .bloc<DownloadedYearCubit>()
                                                    .removeYear(
                                                        downloadedYearState
                                                            .years[index]);
                                              },
                                            ),
                                            title: Text(
                                              languageState == 0
                                                  ? downloadedYearState
                                                      .years[index]
                                                      .toString()
                                                  : CustomTimeUtil()
                                                      .englishToNepaliDate(
                                                          downloadedYearState
                                                              .years[index]),
                                              style: TextStyle(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onPrimary,
                                                fontSize: languageState == 0
                                                    ? 14.0
                                                    : 15.0,
                                              ),
                                            ),
                                          );
                                        }) +
                                        <Widget>[
                                          SizedBox(
                                            height: 20.0,
                                          ),
                                          AppBar(
                                            elevation: 0.0,
                                            title: Text(
                                              languageState == 0
                                                  ? 'Download more calendars'
                                                  : 'पात्रोहरू डाउनलोड गर्नुहोस्',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline6
                                                  .copyWith(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .onPrimary,
                                                    fontSize: 15.0,
                                                  ),
                                            ),
                                          ),
                                        ] +
                                        List.generate(90, (index) {
                                          return ListTile(
                                            trailing: IconButton(
                                              icon: Icon(
                                                !downloadedYearState.years
                                                        .contains(index + 2000)
                                                    ? Icons.get_app
                                                    : Icons.open_in_new,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onPrimary,
                                              ),
                                              onPressed: () {
                                                if (downloadedYearState.years
                                                    .contains(index + 2000)) {
                                                  context
                                                      .bloc<CalendarModeCubit>()
                                                      .changeMode(0);
                                                  context
                                                      .bloc<CalendarCubit>()
                                                      .getCalendar(
                                                          index + 2000);
                                                } else {
                                                  context
                                                      .bloc<
                                                          DownloadedYearCubit>()
                                                      .getYears();
                                                  Navigator.of(context)
                                                      .pushReplacement(
                                                          PageRouteBuilder(
                                                    pageBuilder:
                                                        (_, animation, __) {
                                                      return DownloadingFileWidget(
                                                        year: (index + 2000)
                                                            .toString(),
                                                      );
                                                    },
                                                    transitionDuration:
                                                        Duration(
                                                            milliseconds: 350),
                                                    transitionsBuilder: (_,
                                                        animation, __, child) {
                                                      animation =
                                                          CurvedAnimation(
                                                        curve:
                                                            Curves.decelerate,
                                                        parent: animation,
                                                      );
                                                      return SlideTransition(
                                                        position: Tween(
                                                          begin:
                                                              Offset(1.0, 0.0),
                                                          end: Offset(0.0, 0.0),
                                                        ).animate(animation),
                                                        child: child,
                                                      );
                                                    },
                                                  ));
                                                }
                                              },
                                            ),
                                            leading: Text(
                                              languageState == 0
                                                  ? (index + 1).toString()
                                                  : CustomTimeUtil()
                                                      .englishToNepaliDate(
                                                          index + 1),
                                              style: TextStyle(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onPrimary,
                                                fontSize: languageState == 0
                                                    ? 14.0
                                                    : 15.0,
                                              ),
                                            ),
                                            title: Text(
                                              languageState == 0
                                                  ? (2000 + index).toString()
                                                  : CustomTimeUtil()
                                                      .englishToNepaliDate(
                                                          2000 + index),
                                              style: TextStyle(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onPrimary,
                                                fontSize: languageState == 0
                                                    ? 14.0
                                                    : 15.0,
                                              ),
                                            ),
                                          );
                                        })),
                              ),
                            );
                          }
                          return GestureDetector(
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
                          );
                        },
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
                  ),
                  bottomNavigationBar: CustomBottomNavigationBar(),
                );
              },
            );
          },
        );
      },
    );
  }
}
