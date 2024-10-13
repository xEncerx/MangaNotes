import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:manga_notes/api/api.dart';
import 'package:manga_notes/features/features.dart';
import 'package:manga_notes/router/router.dart';

class MangaPreviewTitle extends StatelessWidget {
  final MangaData mangaData;
  const MangaPreviewTitle({super.key, required this.mangaData});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            mangaData.mainName,
            style: theme.textTheme.titleMedium,
            maxLines: 2,
          ),
        ),
        IconButton(
          onPressed: () => _openSectionEditor(context),
          style: IconButton.styleFrom(
            foregroundColor: theme.hintColor,
            iconSize: 28,
          ),
          icon: const Icon(Icons.more_vert),
        )
      ],
    );
  }

  Future<void> _openSectionEditor(BuildContext context) async {
    await showSectionEditor(context, mangaData);
  }
}

class MangaPreviewSubTitle extends StatelessWidget {
  final String? description;
  final double? avgRating;
  final int? chapters;

  const MangaPreviewSubTitle({
    super.key,
    required this.description,
    required this.avgRating,
    required this.chapters,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${chapters ?? "???"} гл • ${avgRating ?? "???"} ★",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(
          height: 10,
        ),
        if (description != null)
          Text(
            description!,
            style: Theme.of(context).textTheme.bodySmall,
            maxLines: 4,
          ),
      ],
    );
  }
}

class MangaPreviewButton extends StatelessWidget {
  final MangaData mangaData;

  const MangaPreviewButton({super.key, required this.mangaData});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _openInfoScreen(context),
      child: SizedBox(
        width: double.infinity,
        height: 170,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Row(
            children: [
              MangaPreviewCover(coverUrl: mangaData.coverImg),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, bottom: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MangaPreviewTitle(mangaData: mangaData),
                      MangaPreviewSubTitle(
                        description: mangaData.description,
                        avgRating: mangaData.avgRating,
                        chapters: mangaData.chapters,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _openInfoScreen(BuildContext context) {
    AutoRouter.of(context).push(MangaInfoRoute(mangaData: mangaData));
  }
}
