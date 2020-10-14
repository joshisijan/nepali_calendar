import 'package:flutter_bloc/flutter_bloc.dart';

class CalendarModeCubit extends Cubit<int> {
  CalendarModeCubit() : super(0);

  changeMode(int n) => emit(n);
}
