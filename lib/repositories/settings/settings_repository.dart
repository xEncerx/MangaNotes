import 'package:shared_preferences/shared_preferences.dart';

class SettingsRepository {
  final SharedPreferences prefs;

  SettingsRepository({required this.prefs});

  String getTheme() => prefs.getString("theme") ?? "dark";

  Future<void> setTheme(String newTheme) async {
    await prefs.setString("theme", newTheme);
  }
}
