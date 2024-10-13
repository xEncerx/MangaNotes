import 'dart:convert' as dc;

import 'package:manga_notes/api/api.dart';
import 'package:manga_notes/api/parser/parser.dart';

MangaData parseFromShikimori(Map<String, dynamic> json) {
  return MangaData(
    id: 1,
    userId: '???',
    uuid: dc.base64.encode(dc.utf8.encode("shikimori|${json["id"]}")),
    slug: json["id"],
    mangaName: json["russian"],
    otherNames: json["name"],
    avgRating: json["score"],
    views: 0,
    chapters: json["chapters"],
    coverImg: json["poster"]["originalUrl"],
    description: (json["description"] as String?)?.removeTags(),
    mangaStatus: json["status"],
    year: json["airedOn"]["year"],
    genres:
        (json["genres"] ?? []).map((genre) => genre["russian"] ?? "").toList(),
    clientUrl: "https://shikimori.one/mangas/${json["id"]}",
    timestamp: DateTime.now(),
    section: "Не читаю",
  );
}
