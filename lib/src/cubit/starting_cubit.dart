import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StartingCubit extends Cubit<bool> {
  StartingCubit() : super(null) {
    getStartingPage();
  }

  getStartingPage() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool firstOrNot = preferences.getBool('firstOrNot') ?? false;
    if (firstOrNot == true) {
      emit(true);
    } else {
      emit(false);
    }
  }
}
