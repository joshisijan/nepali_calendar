import 'package:bloc/bloc.dart';

class BottomMenuCubit extends Cubit<bool> {
  BottomMenuCubit() : super(false);

  toggleMenu() => emit(!state);
}
