import 'dart:math';

import 'package:manga_notes/api/api.dart';

part 'filter_model.dart';

class MangaFilter {
  final List<MangaData> mangaListData;
  MangaFilter({required this.mangaListData});

  List<MangaData> filter({required FilterMethod method, String? arg}) {
    switch (method) {
      case FilterMethod.byName:
        return _nameFilter(arg);
      case FilterMethod.byTimeAsc:
        return _timeFilter();
      case FilterMethod.byTimeDesc:
        return _timeFilter().reversed.toList();
      case FilterMethod.byChaptersAsc:
        return _chaptersFilter();
      case FilterMethod.byChaptersDesc:
        return _chaptersFilter().reversed.toList();
      case FilterMethod.byRatingAsc:
        return _ratingFilter();
      case FilterMethod.byRatingDesc:
        return _ratingFilter().reversed.toList();
    }
  }

  List<MangaData> _timeFilter() {
    return List.from(mangaListData)
      ..sort(
        (a, b) => a.timestamp.compareTo(b.timestamp),
      );
  }

  List<MangaData> _chaptersFilter() {
    return List.from(mangaListData)
      ..sort(
        (a, b) => (a.chapters ?? 0).compareTo(b.chapters ?? 0),
      );
  }

  List<MangaData> _ratingFilter() {
    return List.from(mangaListData)
      ..sort(
        (a, b) => (a.avgRating ?? 0).compareTo(b.avgRating ?? 0),
      );
  }

  List<MangaData> _nameFilter(String? arg) {
    if (arg == null || arg.isEmpty) return mangaListData;
    final query = arg.toLowerCase();

    // Отфильтруем список и отсортируем по степени совпадения
    final filteredList = mangaListData
        .where((manga) =>
            similarityRatio(manga.mainName.toLowerCase(), query) > 0.3)
        .toList();

    // Сортируем по убыванию схожести
    filteredList.sort((a, b) {
      final similarityA = similarityRatio(a.mainName.toLowerCase(), query);
      final similarityB = similarityRatio(b.mainName.toLowerCase(), query);
      return similarityB.compareTo(similarityA);
    });

    return filteredList;
  }

  double similarityRatio(String s1, String s2) {
    final int levenshteinDistance = _levenshtein(s1, s2);
    final int maxLength = max(s1.length, s2.length);

    if (maxLength == 0) return 1;

    // Процент совпадения
    return (1 - levenshteinDistance / maxLength);
  }

  int _levenshtein(String s1, String s2) {
    int len1 = s1.length;
    int len2 = s2.length;

    List<List<int>> dp =
        List.generate(len1 + 1, (i) => List.filled(len2 + 1, 0));

    for (int i = 0; i <= len1; i++) {
      dp[i][0] = i;
    }
    for (int j = 0; j <= len2; j++) {
      dp[0][j] = j;
    }

    for (int i = 1; i <= len1; i++) {
      for (int j = 1; j <= len2; j++) {
        if (s1[i - 1] == s2[j - 1]) {
          dp[i][j] = dp[i - 1][j - 1];
        } else {
          dp[i][j] = 1 +
              [dp[i - 1][j], dp[i][j - 1], dp[i - 1][j - 1]]
                  .reduce((a, b) => a < b ? a : b);
        }
      }
    }

    return dp[len1][len2];
  }
}
