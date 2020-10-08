import 'package:equatable/equatable.dart';

abstract class DownloadedYearState extends Equatable {
  final String error;
  final List<int> years;
  DownloadedYearState({
    this.years,
    this.error = '',
  });
  @override
  List<Object> get props => [error, years];
}

class DownloadedYearInitial extends DownloadedYearState {
  DownloadedYearInitial() : super();
}

class DownloadedYearError extends DownloadedYearState {
  final String error;
  DownloadedYearError({this.error}) : super(error: error);
}

class DownloadedYearLoaded extends DownloadedYearState {
  final List<int> years;
  DownloadedYearLoaded({this.years}) : super(error: '', years: years);
}

class DownloadedYearEmpty extends DownloadedYearState {
  DownloadedYearEmpty() : super();
}
