import 'package:flutter/material.dart';
import 'package:nepali_calendar/src/services/time_util.dart';

// ignore: must_be_immutable
class CalendarContainer extends StatelessWidget {
  final Map<String, dynamic> monthCalendar;

  CalendarContainer({
    Key key,
    @required this.monthCalendar,
  }) : super(key: key);

  int startingPoint;

  @override
  Widget build(BuildContext context) {
    startingPoint =
        CustomTimeUtil().dayToIndex(monthCalendar['monthData'][0]['day']);
    return Column(
      children: [
        AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text(CustomTimeUtil().indexToMonth(monthCalendar['month'])),
          centerTitle: true,
        ),
        Expanded(
          child: Container(
            child: Column(
              children: [
                // Top Day Row
                CalendarRow(
                  child: Row(
                    children: [
                      DateBox(
                        dayHeading: 'S',
                      ),
                      DateBox(
                        dayHeading: 'M',
                      ),
                      DateBox(
                        dayHeading: 'T',
                      ),
                      DateBox(
                        dayHeading: 'W',
                      ),
                      DateBox(
                        dayHeading: 'T',
                      ),
                      DateBox(
                        dayHeading: 'F',
                      ),
                      DateBox(
                        dayHeading: 'S',
                        dayHoliday: true,
                      ),
                    ],
                  ),
                ),
              ],
            ),
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
      constraints: BoxConstraints(
        minWidth: MediaQuery.of(context).size.width / 7,
        maxWidth: MediaQuery.of(context).size.width / 7,
      ),
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

class CalendarRow extends StatelessWidget {
  final Widget child;

  const CalendarRow({
    Key key,
    @required this.child,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      fit: FlexFit.tight,
      child: child,
    );
  }
}
