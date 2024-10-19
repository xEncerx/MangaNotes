import 'package:manga_notes/repositories/repositories.dart';
import 'package:manga_notes/ui/const.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsRepository {
  final SharedPreferences prefs;

  SettingsRepository({required this.prefs});

  String getTheme() => prefs.getString(SettingKeysConst.themeKey) ?? "dark";
  Future<void> setTheme(String newTheme) async {
    await prefs.setString(SettingKeysConst.themeKey, newTheme);
  }

  String getButtonStyle() =>
      prefs.getString(SettingKeysConst.buttonStyleKey) ?? "default";
  Future<void> setButtonStyle(String style) async {
    await prefs.setString(SettingKeysConst.buttonStyleKey, style);
  }

  SorterSettings getSorter() {
    int? sorterIndex = prefs.getInt(SettingKeysConst.sortedIndexKey);
    int? sorterOrder = prefs.getInt(SettingKeysConst.sorterOrderKey);

    return SorterSettings(
      sorterMethod: SorterMethod.values[sorterIndex ?? 2],
      sorterOrder: SorterOrder.values[sorterOrder ?? 0],
    );
  }

  Future<void> setSorter(
    SorterMethod sorterMethod,
    SorterOrder sorterOrder,
  ) async {
    await prefs.setInt(SettingKeysConst.sortedIndexKey, sorterMethod.index);
    await prefs.setInt(SettingKeysConst.sorterOrderKey, sorterOrder.index);
  }
}
