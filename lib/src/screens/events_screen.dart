import 'package:flutter/material.dart';
import 'package:nepali_calendar/src/cubit/calendar_cubit.dart';
import 'package:nepali_calendar/src/models/time_model.dart';
import 'package:nepali_calendar/src/services/time_util.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

// ignore: must_be_immutable
class EventsScreen extends StatelessWidget {
  final int language;
  EventsScreen({Key key, @required this.language}) : super(key: key);
  List<Map<String, dynamic>> events = [];

  List<dynamic> yearData = [];

  int currentDayIndex = 0;

  ItemScrollController itemScrollController = ItemScrollController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalendarCubit, CalendarState>(
      cubit: CalendarCubit(),
      // ignore: missing_return
      builder: (context, calendarState) {
        if (calendarState is! CalendarLoaded)
          return Scaffold(
            backgroundColor: Theme.of(context).primaryColorDark,
            body: Center(
              child: CircularProgressIndicator(
                backgroundColor: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          );
        yearData = calendarState.calendar['coreData'][language]['data'];
        int tempCurrentDayIndex = 0;
        for (int i = 0; i < 12; i++) {
          for (int j = 0; j < yearData[i]['monthData'].length; j++) {
            if (yearData[i]['monthData'][j]['event'] != '') {
              bool isToday = false;
              if (i + 1 ==
                      CurrentTimeModel(englishDateTime: DateTime.now())
                          .nepaliDateTime
                          .month &&
                  j + 1 ==
                      CurrentTimeModel(englishDateTime: DateTime.now())
                          .nepaliDateTime
                          .day) {
                isToday = true;
                currentDayIndex = tempCurrentDayIndex;
              } else {
                tempCurrentDayIndex++;
              }
              events.add({
                'eventTitle': yearData[i]['monthData'][j]['event'],
                'eventDay': j + 1,
                'eventMonth': yearData[i]['monthName'],
                'eventYear': CurrentTimeModel(englishDateTime: DateTime.now())
                    .nepaliDateTime
                    .year,
                'isToday': isToday,
              });
            }
          }
        }
        return Scaffold(
          backgroundColor: Theme.of(context).primaryColorDark,
          appBar: AppBar(
            actions: [
              IconButton(
                icon: Icon(Icons.arrow_circle_up),
                onPressed: () {
                  itemScrollController.scrollTo(
                      index: 0, duration: Duration(seconds: 1));
                },
              ),
              IconButton(
                icon: Icon(Icons.arrow_circle_down),
                onPressed: () {
                  itemScrollController.scrollTo(
                      index: events.length, duration: Duration(seconds: 1));
                },
              ),
              SizedBox(
                width: 10.0,
              ),
            ],
            elevation: 0.0,
            title: Text(
              language == 0
                  ? CurrentTimeModel(englishDateTime: DateTime.now())
                      .nepaliDateTime
                      .year
                      .toString()
                  : CustomTimeUtil().englishToNepaliDate(
                      CurrentTimeModel(englishDateTime: DateTime.now())
                          .nepaliDateTime
                          .year),
              style: TextStyle(
                fontSize: 16.0,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
            backgroundColor: Theme.of(context).primaryColorDark,
            leading: IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          floatingActionButton: events.length > 0
              ? FlatButton.icon(
                  color: Theme.of(context).primaryColorLight,
                  label: Text(
                    'Goto today',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary),
                  ),
                  icon: Icon(
                    Icons.calendar_today,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                  onPressed: () {
                    itemScrollController.scrollTo(
                        index: currentDayIndex, duration: Duration(seconds: 1));
                  },
                )
              : SizedBox.shrink(),
          body: events.length > 0
              ? ScrollablePositionedList.builder(
                  itemScrollController: itemScrollController,
                  itemCount: events.length + 1,
                  itemBuilder: (context, index) {
                    if (index == events.length)
                      return SizedBox(
                        height: 100.0,
                      );
                    return EventTile(
                      event: events[index],
                      language: language,
                    );
                  },
                )
              : Center(
                  child: Text(
                    language == 0
                        ? 'No event to show for year ' +
                            CurrentTimeModel(englishDateTime: DateTime.now())
                                .nepaliDateTime
                                .year
                                .toString() +
                            '. Will be added soon.'
                        : CustomTimeUtil().englishToNepaliDate(CurrentTimeModel(
                                    englishDateTime: DateTime.now())
                                .nepaliDateTime
                                .year) +
                            ' बर्ष को लागी केहि छैन। चाँडै थपिने छ।',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                ),
        );
      },
    );
  }
}

class EventTile extends StatelessWidget {
  final Map<String, dynamic> event;
  final int language;

  const EventTile({
    Key key,
    @required this.event,
    @required this.language,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    String eventMonth = '';
    String eventDay = '';
    if (language == 0) {
      eventMonth = event['eventMonth'];
      eventDay = event['eventDay'].toString();
    } else {
      eventMonth = event['eventMonth'];
      eventDay = CustomTimeUtil().englishToNepaliDate(event['eventDay']);
    }
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 10.0,
      ),
      color: event['isToday']
          ? Theme.of(context).primaryColorLight
          : Colors.transparent,
      child: ListTile(
        dense: true,
        isThreeLine: true,
        leading: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(
                color: Theme.of(context).colorScheme.onPrimary.withAlpha(100),
                width: 5.0,
              ),
            ),
          ),
          child: Column(
            children: [
              Text(
                eventMonth,
                style: Theme.of(context).textTheme.caption.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                eventDay,
                style: Theme.of(context).textTheme.headline6.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
        ),
        subtitle: Text(
          event['eventTitle'],
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ),
    );
  }
}
