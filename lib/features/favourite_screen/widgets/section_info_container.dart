import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:manga_notes/api/api.dart';
import 'package:manga_notes/features/features.dart';
import 'package:manga_notes/router/router.dart';

class SectionInfoContainer extends StatelessWidget {
  final List<MangaData> mangaListData;

  const SectionInfoContainer({super.key, required this.mangaListData});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "${mangaListData.length} всего",
            style: theme.textTheme.titleSmall?.copyWith(fontSize: 15),
          ),
          _FilledButton(
            padding: const EdgeInsets.all(10),
            onTap: () => showSorterMethodBottomSheet(context),
            child: Row(
              children: [
                Icon(
                  Icons.sort_rounded,
                  color: theme.hintColor,
                ),
                const SizedBox(width: 5),
                Text(
                  "Сортировка",
                  style: theme.textTheme.titleSmall?.copyWith(fontSize: 14),
                ),
              ],
            ),
          ),
          _FilledButton(
            onTap: () => _openInfoScreen(context),
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Icon(
              Icons.shuffle,
              color: theme.hintColor,
            ),
          ),
        ],
      ),
    );
  }

  void _openInfoScreen(BuildContext context) {
    final int mangaIndex = Random().nextInt(mangaListData.length);

    AutoRouter.of(context).push(
      MangaInfoRoute(mangaData: mangaListData[mangaIndex]),
    );
  }
}

class _FilledButton extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final VoidCallback onTap;

  const _FilledButton({
    required this.child,
    required this.onTap,
    required this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return FilledButton(
      onPressed: () => onTap.call(),
      style: FilledButton.styleFrom(
        visualDensity: VisualDensity.compact,
        elevation: 0,
        backgroundColor: theme.canvasColor,
        padding: padding,
        overlayColor: theme.hintColor,
      ),
      child: child,
    );
  }
}
