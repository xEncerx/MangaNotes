import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:manga_notes/repositories/repositories.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talker/talker.dart';
import 'package:talker_bloc_logger/talker_bloc_logger.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:window_manager/window_manager.dart';

import 'ui/ui.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");

  final talker = Talker();
  final dio = Dio();
  final prefs = await SharedPreferences.getInstance();
  final settings = SettingsRepository(prefs: prefs);

  dio.interceptors.add(
    TalkerDioLogger(
      talker: talker,
      settings: const TalkerDioLoggerSettings(
        printResponseData: false,
      ),
    ),
  );
  Bloc.observer = TalkerBlocObserver(
    talker: talker,
    settings: const TalkerBlocLoggerSettings(
      printEventFullData: false,
      printStateFullData: false,
    ),
  );

  GetIt.I.registerSingleton<Dio>(dio);
  GetIt.I.registerSingleton<Talker>(talker);
  GetIt.I.registerSingleton<SettingsRepository>(settings);

  await _initDatabase();
  await _initHive();

  if (defaultTargetPlatform == TargetPlatform.windows ||
      defaultTargetPlatform == TargetPlatform.linux ||
      defaultTargetPlatform == TargetPlatform.macOS) {
    await _setWindowSize();
  }

  runApp(const MangaNotesApp());
}

Future<void> _initHive() async {
  await Hive.initFlutter();
  await Hive.openBox("mangaCache");
  await Hive.openBox("searchHistory");
  await Hive.box("mangaCache").clear();
  final history = HistoryRepository();
  GetIt.I.registerSingleton<HistoryRepository>(history);
  GetIt.I<Talker>().info("Initialize Hive DataBase");
}

Future<void> _initDatabase() async {
  final db = DataBase();
  await db.initialize();
  GetIt.I.registerSingleton<DataBase>(db);
}

Future<void> _setWindowSize() async {
  await windowManager.ensureInitialized();
  WindowOptions windowOptions = const WindowOptions(
    title: "MangaNotes",
    size: Size(460, 780),
    minimumSize: Size(250, 300),
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
  });
}
