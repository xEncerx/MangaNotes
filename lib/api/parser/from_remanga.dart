import 'dart:convert' as dc;

import 'package:manga_notes/api/api.dart';
import 'package:manga_notes/api/models/manga_data.dart';
import 'package:manga_notes/extension/extension.dart';

MangaData parseFromRemanga(Map<String, dynamic> json) {
  return MangaData(
    id: 1,
    userId: '???',
    uuid: dc.base64.encode(dc.utf8.encode("remanga|${json["id"]}")),
    slug: json["dir"],
    mangaName: json["main_name"],
    otherNames: json["secondary_name"],
    avgRating: json["avg_rating"] is double
        ? json["avg_rating"]
        : double.tryParse(json["avg_rating"]),
    views: json["total_views"],
    chapters: json["count_chapters"],
    coverImg: "https://api.remanga.org${json["img"]?.values.last}",
    description: (json["description"] as String?)?.removeTags(),
    mangaStatus: json["status"]["name"],
    year: json["issue_year"],
    genres:
        (json["genres"] ?? []).map((genre) => genre['name'] as String).toList(),
    clientUrl: "https://remanga.org/manga/${json["dir"]}",
    timestamp: DateTime.now(),
    section: "Не читаю",
  );
}
