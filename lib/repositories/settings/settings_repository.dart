import 'package:manga_notes/repositories/repositories.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsRepository {
  final SharedPreferences prefs;

  SettingsRepository({required this.prefs});

  String getTheme() => prefs.getString("theme") ?? "dark";
  Future<void> setTheme(String newTheme) async {
    await prefs.setString("theme", newTheme);
  }

  String getButtonStyle() => prefs.getString("buttonStyle") ?? "default";
  Future<void> setButtonStyle(String style) async {
    await prefs.setString("buttonStyle", style);
  }

  SorterMethod getSorter() {
    int? sorterIndex = prefs.getInt("sorterIndex");
    if (sorterIndex != null &&
        sorterIndex >= 0 &&
        sorterIndex <= SorterMethod.values.length) {
      return SorterMethod.values[sorterIndex];
    }
    return SorterMethod.byTimeDesc;
  }

  Future<void> setSorter(SorterMethod sorterMethod) async {
    await prefs.setInt("sorterIndex", sorterMethod.index);
  }
}
