import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CalendarModeCubit extends Cubit<int> {
  final bool isResetting;
  CalendarModeCubit({this.isResetting = false}) : super(0) {
    () async {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      int mode = preferences.getInt('calendarMode') ?? 0;
      changeMode(mode);
    }.call();
  }

  changeMode(int n) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setInt('calendarMode', n);
    emit(n);
  }
}
