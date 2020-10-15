import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nepali_calendar/src/models/time_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
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
        // checking for update
        int change = 0;
        try {
          var response = await _getResponse(year.toString());
          if (response != null && response?.statusCode == 200) {
            String body = response.body;
            change = body.compareTo(data);
          }
        } catch (e) {}
        // emmiting based on update checked value
        if (change != 0) {
          emit(CalendarLoaded(calendar: jsonData, hasUpdate: true));
        } else {
          emit(CalendarLoaded(calendar: jsonData));
        }
      } else {
        emit(CalendarError(error: 'An error occurred. Try Again.'));
      }
    } on FileSystemException {
      emit(CalendarFileError(error: 'Calendar not Downloaded.'));
    } catch (e) {
      emit(CalendarError(error: 'An error occurred. Try Again.'));
    }
  }

  _getResponse(String year) async {
    try {
      var response = await http.get(
          'https://joshisijan.github.io/calendar_scrapper/data/years/$year.json');
      return response;
    } catch (e) {
      return null;
    }
  }
}
