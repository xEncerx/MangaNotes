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

  FilterMethod getFilter() {
    int? filterIndex = prefs.getInt("filterIndex");
    if (filterIndex != null &&
        filterIndex >= 0 &&
        filterIndex <= FilterMethod.values.length) {
      return FilterMethod.values[filterIndex];
    }
    return FilterMethod.byTimeDesc;
  }

  Future<void> setFilter(FilterMethod filterMethod) async {
    await prefs.setInt("filterIndex", filterMethod.index);
  }
}
