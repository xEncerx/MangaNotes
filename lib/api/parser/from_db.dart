import 'package:manga_notes/api/api.dart';
import 'package:manga_notes/extension/extension.dart';

MangaData parseFromDB(Map<String, dynamic> json) {
  return MangaData(
    id: json["id"],
    userId: json["userId"],
    uuid: json["uuid"],
    slug: json["slug"],
    mangaName: json["mangaName"],
    otherNames: json["otherNames"],
    avgRating: (json["avgRating"] is int)
        ? json["avgRating"].toDouble()
        : json["avgRating"],
    views: json["views"],
    chapters: json["chapters"],
    coverImg: json["coverImg"],
    description: (json["description"] as String?)?.removeTags(),
    mangaStatus: json["mangaStatus"],
    year: json["year"],
    genres: parseStringToList(json["genres"]),
    timestamp: DateTime.parse(json["timestamp"]),
    section: json["section"],
    clientUrl: json["clientUrl"],
  );
}

List<String?> parseStringToList(String? input) {
  if (input == null) return [];

  String cleanedInput = input.substring(1, input.length - 1);
  List<String> list = cleanedInput.split(',').map((item) {
    return item.trim().replaceAll("'", "");
  }).toList();

  return list;
}
