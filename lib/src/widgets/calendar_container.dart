import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CalendarContainer extends StatelessWidget {
  final Map<String, dynamic> monthCalendar;

  CalendarContainer({
    Key key,
    @required this.monthCalendar,
  }) : super(key: key);

  int startingPoint;
  List<dynamic> monthData;
  @override
  Widget build(BuildContext context) {
    startingPoint = monthCalendar['monthData'][0]['index'];
    monthData = monthCalendar['monthData'];
    return Column(
      children: [
        AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text(monthCalendar['monthName']),
          centerTitle: true,
        ),
        Expanded(
          child: Container(
            child: Text('sija'),
          ),
        ),
      ],
    );
  }
}

class DateBox extends StatelessWidget {
  final String dayHeading;
  final bool dayHoliday;
  const DateBox({
    Key key,
    this.dayHeading,
    this.dayHoliday = false,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
          border: Border.all(
        color: Theme.of(context).colorScheme.onPrimary,
      )),
      child: Text(
        dayHeading,
        style: Theme.of(context).textTheme.bodyText1.copyWith(
              color: !dayHoliday
                  ? Theme.of(context).colorScheme.onPrimary
                  : Theme.of(context).errorColor,
            ),
      ),
    );
  }
}
