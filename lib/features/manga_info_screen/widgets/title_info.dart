import 'package:flutter/material.dart';
import 'package:manga_notes/api/api.dart';
import 'package:manga_notes/features/features.dart';

class TitleInfo extends StatelessWidget {
  final MangaData mangaData;

  const TitleInfo({super.key, required this.mangaData});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      children: [
        Center(
          child: MangaPreviewCover(
            coverUrl: mangaData.coverImg,
            width: 350,
            height: 480,
          ),
        ),
        const SizedBox(height: 10),
        MangaTitle(
          mainName: mangaData.mainName,
          altName: mangaData.otherNames,
        ),
        const Divider(),
        Align(
          alignment: Alignment.centerLeft,
          child: SectionButton(mangaData: mangaData),
        ),
        const SizedBox(height: 8),
        ReadingMenu(mangaData: mangaData),
        const Divider(),
        CopiedText(
          text: "Дата выпуска: ${mangaData.year} г.",
          copyText: mangaData.year?.toString(),
          prefixIcon: Icons.event_note,
          style: theme.textTheme.labelSmall,
          iconSize: 20,
        ),
        CopiedText(
          text: "Рейтинг: ${mangaData.avgRating}",
          copyText: mangaData.avgRating?.toString(),
          prefixIcon: Icons.star,
          style: theme.textTheme.labelSmall,
          iconSize: 20,
        ),
        CopiedText(
          text: "Глав: ${mangaData.chapters}",
          copyText: mangaData.chapters?.toString(),
          prefixIcon: Icons.menu_book_rounded,
          style: theme.textTheme.labelSmall,
          iconSize: 20,
        ),
        CopiedText(
          text: "Статус: ${mangaData.mangaStatus}",
          copyText: mangaData.mangaStatus,
          prefixIcon: Icons.access_time_outlined,
          style: theme.textTheme.labelSmall,
          iconSize: 20,
        ),
        CopiedText(
          text: "Жанры: ${mangaData.genres?.join(", ")}",
          copyText: mangaData.genres?.join(", "),
          prefixIcon: Icons.tag,
          style: theme.textTheme.labelSmall?.copyWith(
            overflow: TextOverflow.visible,
          ),
          iconSize: 20,
        ),
        CopiedText(
          text:
              "Описание:\n${mangaData.description ?? "Описания нету. Обновите страницу и оно появится ;)"}",
          copyText: mangaData.description,
          prefixIcon: Icons.article_outlined,
          style: theme.textTheme.labelSmall?.copyWith(
            overflow: TextOverflow.visible,
          ),
          iconSize: 20,
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
