import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:manga_notes/api/api.dart';
import 'package:manga_notes/repositories/repositories.dart';
import 'package:talker/talker.dart';

class MangaApi {
  final _cache = CacheManager(boxName: "mangaCache");
  final getIt = GetIt.I;

  static const String remangaBaseUrl = "https://api.remanga.org/api";
  static const String shikimoriBaseUrl = "https://shikimori.one/api/graphql";
  static const String mangaOVHBaseUrl = "https://manga.ovh";

  Future<Map<String, dynamic>?> _searchResponse({
    required String apiUrl,
    required String cacheKey,
    String apiMethod = "GET",
    Map? queryData,
  }) async {
    final cacheData = _cache.get(cacheKey);

    if (cacheData != null) return cacheData;

    try {
      final response = await getIt<Dio>().fetch(
        RequestOptions(
          path: apiUrl,
          method: apiMethod,
          data: queryData,
        ),
      );

      if (response.statusCode != 200) {
        getIt<Talker>()
            .error("Response error | Status code: ${response.statusCode}");
        return null;
      }

      var data = response.data;
      if (data is List) {
        data = {'data': data} as Map<String, dynamic>;
      }

      await _cache.put(cacheKey, data);
      return data;
    } catch (e, st) {
      getIt<Talker>().handle(e, st);
      return null;
    }
  }

  Future<List<MangaData>?> searchRemanga({
    required String searchValue,
    int limit = 1,
    bool bySlug = false,
  }) async {
    final url = !bySlug
        ? "$remangaBaseUrl/search/?query=$searchValue/&count=$limit"
        : "$remangaBaseUrl/titles/$searchValue";
    final cacheKey = "remanga:$searchValue";
    final response = await _searchResponse(apiUrl: url, cacheKey: cacheKey);

    if (response != null) {
      if (bySlug) {
        if (response['msg'] == "Тайтл не найден") {
          return null;
        }
        return [
          MangaData.fromRemanga(response['content'].cast<String, dynamic>())
        ];
      } else {
        final List content = response['content'] ?? [];
        return content
            .map((item) => MangaData.fromRemanga(item.cast<String, dynamic>()))
            .toList();
      }
    }

    return null;
  }

  Future<List<MangaData>?> searchShikimori({
    required String searchValue,
    int limit = 1,
    bool bySlug = false,
  }) async {
    final searchBy = double.tryParse(searchValue) == null
        ? 'search: "$searchValue"'
        : 'ids: "$searchValue"';
    final query = '''
  {
    mangas($searchBy, limit: $limit) {
      id
      name
      russian
      score
      description
      status
      chapters
      airedOn { year }
      poster { originalUrl }
      genres { name russian }
    }
  }
  ''';

    final cacheKey = "shikimori:$searchBy";
    final response = await _searchResponse(
      apiUrl: shikimoriBaseUrl,
      cacheKey: cacheKey,
      apiMethod: "POST",
      queryData: {"query": query},
    );

    if (response != null) {
      final mangas = response["data"]["mangas"] as List;
      if (mangas.isEmpty) {
        return null;
      }

      if (bySlug) {
        return [MangaData.fromShikimori(mangas[0])];
      } else {
        return mangas
            .map(
                (item) => MangaData.fromShikimori(item.cast<String, dynamic>()))
            .toList();
      }
    }

    return null;
  }

  Future<List<MangaData>?> searchMangaOVH({
    required String searchValue,
    int limit = 1,
    bool bySlug = false,
  }) async {
    final url = bySlug
        ? "$mangaOVHBaseUrl/content/$searchValue?_data=routes%2Freader%2Fbook%2F%24slug%2Findex"
        : "$mangaOVHBaseUrl/yamiko/v2/books?search=$searchValue&type=COMIC";
    final cacheKey = "mangaOVH:$searchValue";
    final response = await _searchResponse(apiUrl: url, cacheKey: cacheKey);
    if (response != null) {
      if (bySlug) {
        return [
          MangaData.fromMangaOVH(response['book'].cast<String, dynamic>()),
        ];
      } else {
        final data = response["data"] as List<dynamic>;
        return data
            .map((item) => MangaData.fromMangaOVH(item.cast<String, dynamic>()))
            .toList();
      }
    }

    return null;
  }

  Future<List<MangaData>> globalSearch(String mangaName) async {
    final remangaList = await searchRemanga(
          searchValue: mangaName,
          limit: 15,
        ) ??
        [];
    final shikimoriList = await searchShikimori(
          searchValue: mangaName,
          limit: 15,
        ) ??
        [];
    final mangaOVHList = await searchMangaOVH(
          searchValue: mangaName,
          limit: 15,
        ) ??
        [];
    final mangaListData = remangaList + shikimoriList + mangaOVHList;
    return mangaListData;
  }
}
