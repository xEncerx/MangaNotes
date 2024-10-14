import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart' show sha256;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:manga_notes/api/api.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:talker/talker.dart';

class DataBase {
  final getIt = GetIt.I;
  final _storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );
  String? _userId;

  SupabaseClient get _client => Supabase.instance.client;

  Future<void> initialize() async {
    await Supabase.initialize(
      url: dotenv.get("supaUrl"),
      anonKey: dotenv.get("anonKey"),
    );
    getIt<Talker>().info("Initialize Supabase");
  }

  Future<List<MangaData>?> selectAllManga() async {
    if (_userId == null) return null;

    final response =
        await _client.from("mangaData").select().eq("userId", _userId!);

    final mangaListData =
        response.map((item) => MangaData.fromDB(item)).toList();
    mangaListData.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    return mangaListData;
  }

  Future<void> changeSection(String uuid, String newSection) async {
    if (_userId == null) return;

    await _client
        .from("mangaData")
        .update({"section": newSection})
        .eq("uuid", uuid)
        .eq("userId", _userId!);
  }

  Future<void> deleteManga(String uuid) async {
    if (_userId == null) return;

    await _client
        .from("mangaData")
        .delete()
        .eq("uuid", uuid)
        .eq("userId", _userId!);
  }

  Future<void> updateMangaDataRow({required MangaData mangaData}) async {
    if (_userId == null) return;

    await _client
        .from("mangaData")
        .update(mangaData.toJson())
        .eq("uuid", mangaData.uuid)
        .eq("userId", _userId!);
  }

  Future<void> insertMangaData({
    required MangaData mangaData,
    required String section,
  }) async {
    if (_userId == null) return;

    final jsonManga =
        mangaData.copyWith(userId: _userId, section: section).toJson();
    jsonManga.remove("id");
    await _client.from("mangaData").insert(jsonManga);
  }

  Future<void> updateMangaData({
    required String uuid,
    required String column,
    required dynamic data,
  }) async {
    if (_userId == null) return;

    await _client
        .from("mangaData")
        .update({column: data, "timestamp": DateTime.now().toString()})
        .eq("uuid", uuid)
        .eq("userId", _userId!);
  }

  Future<bool> checkRecoveryCode({
    required String username,
    required String recoveryCode,
  }) async {
    final result = await _client.from("authorizations").select().match({
      "username": username,
      "recoveryCode": recoveryCode,
    }).count();
    return result.count == 1 ? true : false;
  }

  Future<void> updatePassword({
    required String username,
    required String password,
  }) async {
    final passwordBytes = utf8.encode(password);
    final passwordSHA256 = sha256.convert(passwordBytes).toString();

    await _client
        .from("authorizations")
        .update({"password": passwordSHA256}).eq("username", username);
  }

  Future<bool> logIn({
    required String username,
    required String password,
  }) async {
    final passwordBytes = utf8.encode(password);
    final passwordSHA256 = sha256.convert(passwordBytes).toString();

    final counter = await _client.from("authorizations").select().match({
      "username": username,
      "password": passwordSHA256,
    }).count();

    if (counter.count == 1) {
      _userId = username;
      await _storage.write(key: "username", value: username);
      return true;
    }
    return false;
  }

  Future<String?> signUp({
    required String username,
    required String password,
  }) async {
    final user = await _client
        .from("authorizations")
        .select()
        .eq("username", username)
        .count();
    if (user.count != 0) return null;

    final passwordBytes = utf8.encode(password);
    final passwordSHA256 = sha256.convert(passwordBytes).toString();
    final recoveryCode = (10000 + Random().nextInt(99999 - 10001)).toString();

    await _client.from("authorizations").insert({
      "username": username,
      "password": passwordSHA256,
      "recoveryCode": recoveryCode,
    });

    _userId = username;
    await _storage.write(key: "username", value: username);
    return recoveryCode;
  }

  Future<void> logOut() async {
    await _storage.delete(key: "username");
    _userId = null;
  }

  Future<bool> checkAuthorization() async {
    final username = await _storage.read(key: "username");
    if (username != null) {
      _userId = username;
      return true;
    }
    return false;
  }

  Future<void> dispose() async {
    await _client.dispose();
  }
}
