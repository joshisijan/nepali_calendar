import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import './downloaded_year_state.dart';

class DownloadedYearCubit extends Cubit<DownloadedYearState> {
  DownloadedYearCubit() : super(null) {
    getYears();
  }

  getYears() async {
    try {
      emit(DownloadedYearInitial());
      Directory directory = await getApplicationDocumentsDirectory();
      List<int> years = [];
      directory
          .list(recursive: true, followLinks: false)
          .listen((FileSystemEntity entity) {
        if (extension(entity.path) == '.json') {
          years.add(int.parse(basename(entity.path).replaceAll('.json', '')));
        }
      });
      if (years.length <= 0) emit(DownloadedYearEmpty());
      emit(DownloadedYearLoaded(years: years));
    } catch (e) {
      emit(DownloadedYearError(error: 'An error occurred. Try again.'));
    }
  }

  removeYear(int year) async {
    Directory directory = await getApplicationDocumentsDirectory();
    await File(join(directory.path, '$year.json')).delete(recursive: true);
    getYears();
  }
}
