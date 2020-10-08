import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nepali_calendar/src/models/time_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
part 'calendar_state.dart';

class CalendarCubit extends Cubit<CalendarState> {
  CalendarCubit() : super(CalendarInitial()) {
    getCalendar(CurrentTimeModel(englishDateTime: DateTime.now())
        .getNepaliDate(DateTime.now())
        .year);
  }

  getCalendar(int year) async {
    try {
      emit(CalendarInitial());
      Directory directory = await getApplicationDocumentsDirectory();
      String data =
          await File(join(directory.path, '$year.json')).readAsString();
      if (data != null && data != '') {
        Map<String, dynamic> jsonData = jsonDecode(data);
        emit(CalendarLoaded(calendar: jsonData));
      } else {
        emit(CalendarError(error: 'An error occurred. Try Again.'));
      }
    } on FileSystemException {
      emit(CalendarFileError(error: 'Calendar not Downloaded.'));
    } catch (e) {
      emit(CalendarError(error: 'An error occurred. Try Again.'));
    }
  }
}
