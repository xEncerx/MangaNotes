import 'package:hive_flutter/hive_flutter.dart';

class HistoryRepository {
  final _box = Hive.box("searchHistory");

  Future<void> addValue(String value) async {
    final prevData = await readAll();
    await _box.put("history", {value, ...prevData}.toList());
  }

  Future<List<dynamic>> readAll() async {
    final List<dynamic> data = _box.get("history", defaultValue: []);
    return data;
  }

  Future<void> clear() async {
    await _box.delete("history");
  }
}
