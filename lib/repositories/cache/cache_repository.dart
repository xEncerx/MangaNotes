import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:talker/talker.dart';

class CacheManager {
  final _getIt = GetIt.I;
  final String boxName;
  late final Box _cacheBox;
  final Duration cacheDuration;

  CacheManager({
    this.cacheDuration = const Duration(minutes: 5),
    required this.boxName,
  }) : _cacheBox = Hive.box(boxName);

  // Метод для сохранения объекта в кэш
  Future<void> put(String key, dynamic value) async {
    final cacheData = {
      'value': value,
      'timestamp': DateTime.now().millisecondsSinceEpoch
    };
    await _cacheBox.put(key, cacheData);
    _getIt<Talker>().info("Put data into cache with key: $key");
  }

  // Метод для получения данных из кэша
  dynamic get(String key) {
    final cacheData = _cacheBox.get(key);

    if (cacheData != null) {
      final timestamp = cacheData['timestamp'] as int;
      final savedTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
      final currentTime = DateTime.now();

      if (currentTime.difference(savedTime) > cacheDuration) {
        _cacheBox.delete(key);
        _getIt<Talker>()
            .info("Timeout | Delete data from cache with key: $key");
        return null; // Время истекло, данные удалены
      }

      _getIt<Talker>().info("Return data from cache with key: $key");
      return Map<String, dynamic>.from(cacheData["value"]);
    }
    return null;
  }

  // Метод для очистки всего кэша
  Future<void> clearAll() async {
    _getIt<Talker>().info("Clear Box");
    await _cacheBox.clear();
  }
}
