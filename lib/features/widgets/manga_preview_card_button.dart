import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:manga_notes/api/api.dart';
import 'package:manga_notes/features/features.dart';
import 'package:manga_notes/router/router.dart';

class MangaPreviewCardButton extends StatelessWidget {
  final MangaData mangaData;

  const MangaPreviewCardButton({super.key, required this.mangaData});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () => _openInfoScreen(context),
      child: Stack(
        children: [
          Card(
            color: theme.cardColor,
            elevation: 1.5,
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Column(
                children: [
                  Flexible(
                    flex: 8,
                    child: MangaPreviewCover(
                      borderRadius: 10,
                      width: double.infinity,
                      coverUrl: mangaData.coverImg,
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: Center(
                      child: Text(
                        mangaData.mainName,
                        textAlign: TextAlign.center,
                        style: theme.textTheme.labelSmall?.copyWith(
                          fontSize: 12,
                        ),
                        maxLines: 2,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 15,
            child: _InfoBadge(value: mangaData.avgRating),
          ),
          Positioned(
            top: 35,
            child: _InfoBadge(value: mangaData.chapters),
          ),
        ],
      ),
    );
  }

  void _openInfoScreen(BuildContext context) {
    AutoRouter.of(context).push(MangaInfoRoute(mangaData: mangaData));
  }
}

class _InfoBadge extends StatelessWidget {
  final dynamic value;
  const _InfoBadge({required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 6),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        "${value ?? "???"}",
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
