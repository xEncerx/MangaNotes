import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:manga_notes/repositories/repositories.dart';

part 'manga_button_state.dart';

class MangaButtonCubit extends Cubit<MangaButtonState> {
  final settings = GetIt.I<SettingsRepository>();

  MangaButtonCubit() : super(const MangaButtonState()) {
    checkSelectedButtonStyle();
  }

  Future<void> setButtonStyle(String newStyle) async {
    emit(MangaButtonState(style: newStyle));
    await settings.setButtonStyle(newStyle);
  }

  void checkSelectedButtonStyle() {
    final buttonStyle = settings.getButtonStyle();
    emit(MangaButtonState(style: buttonStyle));
  }
}
