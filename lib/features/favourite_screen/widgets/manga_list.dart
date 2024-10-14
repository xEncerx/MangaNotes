import 'package:flutter/material.dart';
import 'package:manga_notes/api/api.dart';
import 'package:manga_notes/features/features.dart';

class MangaList extends StatelessWidget {
  final List<MangaData> mangaListData;
  const MangaList({super.key, required this.mangaListData});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: mangaListData.length,
      itemBuilder: (context, index) => MangaPreviewButton(
        mangaData: mangaListData[index],
      ),
      separatorBuilder: (context, _) => const SizedBox(height: 5),
    );
  }
}
