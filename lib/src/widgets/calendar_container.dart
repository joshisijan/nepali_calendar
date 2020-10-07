import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nepali_calendar/src/cubit/language_cubit.dart';
import 'package:nepali_calendar/src/services/time_util.dart';

class CalendarContainer extends StatefulWidget {
  final List<dynamic> yearCalendar;
  final int year;
  final int month;
  final int day;

  CalendarContainer({
    Key key,
    @required this.yearCalendar,
    @required this.year,
    @required this.month,
    @required this.day,
  }) : super(key: key);

  @override
  _CalendarContainerState createState() => _CalendarContainerState();
}

class _CalendarContainerState extends State<CalendarContainer> {
  PageController pageController;

  @override
  void initState() {
    pageController = PageController(
      initialPage: widget.month - 1,
    );
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: pageController,
      children: List.generate(12, (index) {
        return CalendarMonth(
          monthData: widget.yearCalendar[index],
          month: widget.month,
          day: widget.day,
          year: widget.year,
          today: widget.month == index + 1 ? true : false,
        );
      }),
    );
  }
}

class CalendarMonth extends StatelessWidget {
  final Map<String, dynamic> monthData;
  final int year;
  final int month;
  final int day;
  final bool today;
  const CalendarMonth({
    Key key,
    @required this.monthData,
    @required this.year,
    @required this.month,
    @required this.day,
    this.today = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageCubit, int>(
      builder: (context, languageState) {
        return Column(
          children: [
            AppBar(
              title: Column(
                children: [
                  languageState == 0
                      ? Text(
                          monthData['monthName'] + ' | ' + year.toString(),
                          style: TextStyle(
                            fontSize: 16.5,
                          ),
                        )
                      : Text(
                          monthData['monthName'] +
                              ' | ' +
                              CustomTimeUtil().englishToNepaliDate(year),
                          style: TextStyle(
                            fontSize: 16.5,
                          ),
                        ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    'Swipe to change month',
                    style: Theme.of(context).textTheme.overline.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                  ),
                ],
              ),
              centerTitle: true,
            ),
            today
                ? Container(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          'Today',
                          style: Theme.of(context).textTheme.headline6.copyWith(
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        languageState == 0
                            ? Text(
                                year.toString() +
                                    ', ' +
                                    monthData['monthName'] +
                                    ' ' +
                                    day.toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary,
                                    ),
                              )
                            : Text(
                                CustomTimeUtil().englishToNepaliDate(year) +
                                    ', ' +
                                    monthData['monthName'] +
                                    ' ' +
                                    CustomTimeUtil().englishToNepaliDate(day),
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary,
                                    ),
                              ),
                        Text(
                          monthData['monthData'][month - 1]['tithi'],
                          style: Theme.of(context).textTheme.overline.copyWith(
                              color: Theme.of(context).colorScheme.onPrimary,
                              fontSize: languageState == 0
                                  ? Theme.of(context)
                                          .textTheme
                                          .overline
                                          .fontSize +
                                      1.0
                                  : Theme.of(context)
                                          .textTheme
                                          .overline
                                          .fontSize +
                                      2.0),
                        ),
                        Text(
                          languageState == 0
                              ? monthData['monthData'][month - 1]['day']
                                  .toString()
                                  .toUpperCase()
                              : CustomTimeUtil()
                                  .englishToNepaliDay(
                                      monthData['monthData'][month - 1]['day'])
                                  .toUpperCase(),
                          style: Theme.of(context).textTheme.overline.copyWith(
                              color: Theme.of(context).colorScheme.secondary,
                              fontSize: languageState == 0
                                  ? Theme.of(context)
                                          .textTheme
                                          .overline
                                          .fontSize +
                                      1.0
                                  : Theme.of(context)
                                          .textTheme
                                          .overline
                                          .fontSize +
                                      4.0),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        monthData['monthData'][day - 1]['event'] != ''
                            ? Container(
                                padding: EdgeInsets.symmetric(horizontal: 20.0),
                                child: Text(
                                  monthData['monthData'][day - 1]['event'],
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      .copyWith(
                                        color: Theme.of(context).errorColor,
                                      ),
                                ),
                              )
                            : SizedBox.shrink(),
                        SizedBox(
                          height: 20.0,
                        ),
                      ],
                    ),
                  )
                : SizedBox(height: 20.0),
            Expanded(
              child: Container(
                padding:
                    EdgeInsets.only(bottom: MediaQuery.of(context).padding.top),
                child: Column(
                  children: [
                        Flexible(
                          flex: 1,
                          child: Row(
                            children: [
                              DateBox(
                                centerDate: languageState == 0 ? 'S' : 'आ',
                              ),
                              DateBox(
                                centerDate: languageState == 0 ? 'M' : 'सो',
                              ),
                              DateBox(
                                centerDate: languageState == 0 ? 'T' : 'मं',
                              ),
                              DateBox(
                                centerDate: languageState == 0 ? 'W' : 'बु',
                              ),
                              DateBox(
                                centerDate: languageState == 0 ? 'T' : 'बि',
                              ),
                              DateBox(
                                centerDate: languageState == 0 ? 'F' : 'शु',
                              ),
                              DateBox(
                                centerDate: languageState == 0 ? 'S' : 'श',
                                isHoliday: true,
                              ),
                            ],
                          ),
                        ),
                      ] +
                      List.generate(6, (indexUp) {
                        int startingPoint = monthData['monthData'][0]['index'];
                        int totalDays = monthData['monthData'].length;
                        return Flexible(
                          flex: 1,
                          child: Row(
                            children: List.generate(7, (indexDown) {
                              int actualIndexUp = indexDown + indexUp * 7;
                              if (actualIndexUp < startingPoint ||
                                  actualIndexUp - startingPoint >= totalDays) {
                                return DateBox();
                              }
                              return DateBox(
                                centerDate: monthData['monthData']
                                    [actualIndexUp - startingPoint]['nepali'],
                                isActive: monthData['month'] == month &&
                                        CustomTimeUtil().nepaliToEnglishDate(
                                                monthData['monthData'][
                                                        actualIndexUp -
                                                            startingPoint]
                                                    ['nepali']) ==
                                            day
                                    ? true
                                    : false,
                                isHoliday: monthData['monthData']
                                    [actualIndexUp - startingPoint]['holiday'],
                                tithi: monthData['monthData']
                                    [actualIndexUp - startingPoint]['tithi'],
                                language: languageState,
                                onTap: () {
                                  showTodayEvent(
                                    context: context,
                                    year: year,
                                    language: languageState,
                                    monthName: monthData['monthName'],
                                    dayDetail: monthData['monthData']
                                        [actualIndexUp - startingPoint],
                                  );
                                },
                              );
                            }),
                          ),
                        );
                      }),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  showTodayEvent(
      {BuildContext context,
      String monthName,
      int year,
      int language,
      Map<String, dynamic> dayDetail}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).primaryColorDark,
          actions: [
            IconButton(
              icon: Icon(
                Icons.close,
                color: Theme.of(context).errorColor,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
          content: Container(
            height: MediaQuery.of(context).size.width * 0.5,
            child: ListView(
              children: [
                language == 0
                    ? Text(
                        year.toString() +
                            ', ' +
                            monthName +
                            ' ' +
                            dayDetail['nepali'],
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary),
                      )
                    : Text(
                        CustomTimeUtil().englishToNepaliDate(year) +
                            ', ' +
                            monthName +
                            ' ' +
                            dayDetail['nepali'],
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary),
                      ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  language == 0
                      ? dayDetail['day']
                      : CustomTimeUtil().englishToNepaliDay(dayDetail['day']),
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.secondary),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  dayDetail['tithi'],
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  dayDetail['event'],
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.secondary),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class DateBox extends StatelessWidget {
  final String centerDate;
  final String tithi;
  final bool isHoliday;
  final bool isActive;
  final int language;
  final Function onTap;
  const DateBox({
    Key key,
    this.centerDate,
    this.isHoliday = false,
    this.isActive = false,
    this.tithi,
    this.language,
    this.onTap,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
              color: Theme.of(context).colorScheme.onPrimary.withAlpha(50)),
        ),
        width: MediaQuery.of(context).size.width / 7,
        height: double.maxFinite,
        padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 3.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: isActive ? EdgeInsets.all(5.0) : EdgeInsets.zero,
              decoration: BoxDecoration(
                color: isActive
                    ? Theme.of(context).colorScheme.secondary
                    : Colors.transparent,
                borderRadius: isActive ? BorderRadius.circular(20.0) : null,
              ),
              child: Text(
                centerDate ?? '',
                style: TextStyle(
                  color: isHoliday
                      ? Theme.of(context).errorColor
                      : Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ),
            Container(
              height: Theme.of(context).textTheme.overline.fontSize,
              child: Text(
                tithi ?? '',
                style: Theme.of(context).textTheme.overline.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                      letterSpacing: 0.0,
                      fontSize: language == 0
                          ? Theme.of(context).textTheme.overline.fontSize - 2.0
                          : Theme.of(context).textTheme.overline.fontSize,
                    ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
