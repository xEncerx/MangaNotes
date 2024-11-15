import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../parser/parser.dart';

class MangaData extends Equatable {
  final int id;
  final String userId;
  final String uuid;

  final String? mangaName;
  final String? otherNames;
  final String slug;
  final double? avgRating;
  final int? views;
  final int? chapters;
  final String? coverImg;
  final String? description;
  final String? mangaStatus;
  final List<dynamic>? genres;
  final int? year;

  final String? clientUrl;
  final DateTime timestamp;
  final String section;

  const MangaData({
    required this.id,
    required this.userId,
    required this.uuid,
    required this.slug,
    required this.mangaName,
    required this.otherNames,
    required this.avgRating,
    required this.views,
    required this.chapters,
    required this.coverImg,
    required this.description,
    required this.mangaStatus,
    required this.year,
    required this.genres,
    required this.clientUrl,
    required this.timestamp,
    required this.section,
  });

  String get service => utf8.decode(base64.decode(uuid)).split("|")[0];
  String get mainName => mangaName ?? otherNames ?? "???";

  factory MangaData.fromRemanga(Map<String, dynamic> json) => parseFromRemanga(json);
  factory MangaData.fromShikimori(Map<String, dynamic> json) => parseFromShikimori(json);
  factory MangaData.fromMangaOVH(Map<String, dynamic> json) => parseFromMangaOVH(json);
  factory MangaData.fromDB(Map<String, dynamic> json) => parseFromDB(json);

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "uuid": uuid,
        "slug": slug,
        "mangaName": mangaName,
        "otherNames": otherNames,
        "avgRating": avgRating,
        "views": views,
        "chapters": chapters,
        "coverImg": coverImg,
        "description": description,
        "mangaStatus": mangaStatus,
        "year": year,
        "genres": genres,
        "clientUrl": clientUrl,
        "timestamp": timestamp.toString(),
        "section": section,
      };

  MangaData copyWith({
    int? id,
    String? userId,
    String? uuid,
    String? mangaName,
    String? otherNames,
    String? slug,
    double? avgRating,
    int? views,
    int? chapters,
    String? coverImg,
    String? description,
    String? mangaStatus,
    List<dynamic>? genres,
    int? year,
    String? clientUrl,
    DateTime? timestamp,
    String? section,
  }) {
    return MangaData(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      uuid: uuid ?? this.uuid,
      mangaName: mangaName ?? this.mangaName,
      otherNames: otherNames ?? this.otherNames,
      slug: slug ?? this.slug,
      avgRating: avgRating ?? this.avgRating,
      views: views ?? this.views,
      chapters: chapters ?? this.chapters,
      coverImg: coverImg ?? this.coverImg,
      description: description ?? this.description,
      mangaStatus: mangaStatus ?? this.mangaStatus,
      genres: genres ?? this.genres,
      year: year ?? this.year,
      clientUrl: clientUrl ?? this.clientUrl,
      timestamp: timestamp ?? this.timestamp,
      section: section ?? this.section,
    );
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        uuid,
        slug,
        mangaName,
        otherNames,
        avgRating,
        views,
        chapters,
        coverImg,
        description,
        mangaStatus,
        year,
        genres,
        clientUrl,
        timestamp,
        section,
      ];
}
