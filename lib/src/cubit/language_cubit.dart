import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageCubit extends Cubit<int> {
  LanguageCubit() : super(0) {
    () async {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      int language = sharedPreferences.getInt('languageIndex') ?? 0;
      emit(language);
    }.call();
  }

  setLanguage(int n) {
    emit(n);
    saveOnPreference(n);
  }

  toggleLanguage() {
    if (state == 0) {
      emit(1);
      saveOnPreference(1);
    } else {
      emit(0);
      saveOnPreference(0);
    }
  }

  saveOnPreference(int n) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setInt('languageIndex', n);
  }
}
