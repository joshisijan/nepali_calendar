import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nepali_calendar/src/cubit/bottom_menu_cubit.dart';
import 'package:nepali_calendar/src/cubit/calendar_cubit.dart';
import 'package:nepali_calendar/src/cubit/calendar_mode_cubit.dart';
import 'package:nepali_calendar/src/cubit/language_cubit.dart';
import 'package:nepali_calendar/src/cubit/theme_cubit.dart';
import 'package:nepali_calendar/src/models/time_model.dart';
import 'package:nepali_calendar/src/reuseables/custom_filter_chip.dart';
import 'package:nepali_calendar/src/reuseables/flat_icon_button.dart';
import 'package:nepali_calendar/src/screens/about.dart';

class BottomMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      height: 350.0,
      child: BlocBuilder<LanguageCubit, int>(
        builder: (context, languageState) {
          return ListView(
            children: [
              Container(
                height: 35.0,
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        context.bloc<LanguageCubit>().setLanguage(0);
                      },
                      child: Container(
                        padding: EdgeInsets.all(10.0),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: languageState == 0
                              ? Theme.of(context)
                                  .colorScheme
                                  .secondary
                                  .withAlpha(180)
                              : Colors.transparent,
                          border: Border.all(
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                        child: Text(
                          'English',
                          style: Theme.of(context).textTheme.overline.copyWith(
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        context.bloc<LanguageCubit>().setLanguage(1);
                      },
                      child: Container(
                        padding: EdgeInsets.all(10.0),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: languageState == 1
                              ? Theme.of(context)
                                  .colorScheme
                                  .secondary
                                  .withAlpha(180)
                              : Colors.transparent,
                          border: Border.all(
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                        child: Text(
                          'नेपाली',
                          style: Theme.of(context).textTheme.overline.copyWith(
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              BlocBuilder<CalendarModeCubit, int>(
                builder: (context, calendarModeState) {
                  if (calendarModeState == 0)
                    return Column(
                      children: [
                        FlatIconButton(
                          containerUse: true,
                          onPressed: null,
                          firstChild: Icon(
                            Icons.theater_comedy,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                          secondChild: Text(
                            languageState == 0 ? 'Theme' : 'थीम',
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.onPrimary),
                          ),
                        ),
                        BlocBuilder<ThemeCubit, int>(
                          builder: (context, themeState) {
                            return Wrap(
                              children: [
                                CustomFilterChip(
                                  label: languageState == 0 ? 'Light' : 'लाईट',
                                  selected: themeState == 0 ? true : false,
                                  onSelected: (value) {
                                    context.bloc<ThemeCubit>().setTheme(0);
                                  },
                                ),
                                CustomFilterChip(
                                  label: languageState == 0 ? 'Dark' : 'डार्क',
                                  selected: themeState == 1 ? true : false,
                                  onSelected: (value) {
                                    context.bloc<ThemeCubit>().setTheme(1);
                                  },
                                ),
                              ],
                            );
                          },
                        ),
                        FlatIconButton(
                          firstChild: Icon(
                            Icons.date_range,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                          secondChild: Text(
                            languageState == 0
                                ? 'Browse by year'
                                : 'वर्ष बाट ब्राउज गर्नुहोस्',
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.onPrimary),
                          ),
                          containerUse: true,
                          onPressed: () {
                            context.bloc<CalendarModeCubit>().changeMode(1);
                            context.bloc<BottomMenuCubit>().toggleMenu();
                          },
                        ),
                        FlatIconButton(
                          firstChild: Icon(
                            Icons.calendar_today,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                          secondChild: Text(
                            languageState == 0
                                ? 'View current year'
                                : 'हालको वर्षमा जानुहोस्',
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.onPrimary),
                          ),
                          containerUse: true,
                          onPressed: () {
                            context.bloc<CalendarModeCubit>().changeMode(0);
                            context.bloc<CalendarCubit>().getCalendar(
                                CurrentTimeModel(
                                        englishDateTime: DateTime.now())
                                    .nepaliDateTime
                                    .year);
                            context.bloc<BottomMenuCubit>().toggleMenu();
                          },
                        ),
                      ],
                    );
                  return FlatIconButton(
                    firstChild: Icon(
                      Icons.calendar_today,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                    secondChild: Text(
                      languageState == 0
                          ? 'View current year'
                          : 'हालको वर्ष हेर्नुहोस्',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary),
                    ),
                    containerUse: true,
                    onPressed: () {
                      context.bloc<CalendarModeCubit>().changeMode(0);
                      context.bloc<CalendarCubit>().getCalendar(
                          CurrentTimeModel(englishDateTime: DateTime.now())
                              .nepaliDateTime
                              .year);
                      context.bloc<BottomMenuCubit>().toggleMenu();
                    },
                  );
                },
              ),
              FlatIconButton(
                firstChild: Icon(
                  Icons.info,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                secondChild: Text(
                  languageState == 0 ? 'About us' : 'हाम्रोबारे',
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                ),
                containerUse: true,
                onPressed: () {
                  context.bloc<BottomMenuCubit>().toggleMenu();
                  Navigator.of(context).push(PageRouteBuilder(
                    pageBuilder: (_, animation, __) => AboutScreen(
                      language: languageState,
                    ),
                    transitionDuration: Duration(milliseconds: 350),
                    transitionsBuilder: (_, animation, __, child) {
                      animation = CurvedAnimation(
                        curve: Curves.decelerate,
                        parent: animation,
                      );
                      return SlideTransition(
                        position: Tween(
                          begin: Offset(-1.0, 0.0),
                          end: Offset(0.0, 0.0),
                        ).animate(animation),
                        child: child,
                      );
                    },
                  ));
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
