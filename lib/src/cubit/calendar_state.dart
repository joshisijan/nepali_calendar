part of 'calendar_cubit.dart';

abstract class CalendarState extends Equatable {
  final String error;
  final Map<String, dynamic> calendar;
  CalendarState({
    this.error = '',
    this.calendar,
  });
  @override
  List<Object> get props => [error, calendar];
}

class CalendarInitial extends CalendarState {
  CalendarInitial() : super(error: '');
}

class CalendarError extends CalendarState {
  final String error;
  CalendarError({this.error}) : super(error: error);
}

class CalendarLoaded extends CalendarState {
  final Map<String, dynamic> calendar;
  final bool hasUpdate;
  CalendarLoaded({this.calendar, this.hasUpdate = false})
      : super(error: '', calendar: calendar);
}

class CalendarFileError extends CalendarState {
  final String error;
  CalendarFileError({this.error}) : super(error: '');
}
