import 'package:bloc/bloc.dart';
import 'package:nepali_calendar/src/models/time_model.dart';

class TimerCubit extends Cubit<CurrentTimeModel> {
  TimerCubit() : super(CurrentTimeModel(englishDateTime: DateTime.now())) {
    getNewDateTime();
  }

  getNewDateTime() => emit(CurrentTimeModel(englishDateTime: DateTime.now()));
}
