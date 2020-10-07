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

  setLanguage(int n) => emit(n);

  toggleLanguage() {
    if (state == 0) {
      emit(1);
    } else {
      emit(0);
    }
  }
}
