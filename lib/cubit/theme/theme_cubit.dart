import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:manga_notes/repositories/repositories.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  final settings = GetIt.I<SettingsRepository>();

  ThemeCubit() : super(const ThemeState()) {
    checkSelectedTheme();
  }

  Future<void> setTheme(String newTheme) async {
    emit(ThemeState(theme: newTheme));
    await settings.setTheme(newTheme);
  }

  void checkSelectedTheme() {
    final theme = settings.getTheme();
    emit(ThemeState(theme: theme));
  }
}
