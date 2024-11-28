import 'package:flutter/material.dart';
import 'package:manga_notes/features/features.dart';

void showMangaUpdaterBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    isScrollControlled: true,
    showDragHandle: true,
    isDismissible: false,
    builder: (context) => const MangaUpdaterContent(),
  );
}
