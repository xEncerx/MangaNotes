import 'package:flutter/material.dart';
import 'package:manga_notes/api/api.dart';
import 'package:manga_notes/features/features.dart';

class MangaCardList extends StatelessWidget {
  final List<MangaData> mangaListData;
  const MangaCardList({super.key, required this.mangaListData});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: GridView.builder(
        itemCount: mangaListData.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
          childAspectRatio: 0.62,
        ),
        itemBuilder: (context, index) =>
            MangaPreviewCardButton(mangaData: mangaListData[index]),
      ),
    );
  }
}
