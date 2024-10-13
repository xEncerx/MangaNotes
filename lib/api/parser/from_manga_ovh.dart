import 'dart:convert' as dc;

import 'package:manga_notes/api/api.dart';
import 'package:manga_notes/api/parser/parser.dart';

MangaData parseFromMangaOVH(Map<String, dynamic> json) {
  return MangaData(
    id: 1,
    userId: '???',
    uuid: dc.base64.encode(dc.utf8.encode("mangaOVH|${json["id"]}")),
    slug: json["slug"],
    mangaName: json["name"]["ru"],
    otherNames: json["name"]["en"],
    avgRating: double.tryParse(json["averageRating"].toStringAsFixed(2)),
    views: json["viewsCount"],
    chapters: json["chaptersCount"],
    coverImg: json["poster"],
    description: (json["description"] as String?)?.removeTags(),
    mangaStatus: json["status"],
    year: json["year"],
    genres: (json["labels"] ?? []).map((genre) => genre["name"] ?? "").toList(),
    clientUrl: "https://manga.ovh/content/${json["slug"]}",
    timestamp: DateTime.now(),
    section: "Не читаю",
  );
}
