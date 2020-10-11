import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeCubit extends Cubit<int> {
  ThemeCubit() : super(0) {
    () async {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      int themeIndex = preferences.getInt('themeIndex') ?? 0;
      setTheme(themeIndex);
    }.call();
  }

  setTheme(int n) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setInt('themeIndex', n);
    emit(n);
  }
}
