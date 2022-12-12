import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_bar_state.dart';

class AppBarCubit extends Cubit<AppBarState> {
  AppBarCubit() : super(AppBarInitial());

  int carosulIndex = 0;

  void changeCarosulIndex(int index) {
    emit(AppBarInitial());
    carosulIndex = index;
    emit(AppBarChangeCaroselState());
  }
}
