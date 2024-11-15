import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manga_notes/features/features.dart';

void showMangaUpdaterBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    isScrollControlled: true,
    showDragHandle: true,
    isDismissible: false,
    builder: (context) => const MangaUpdaterView(),
  );
}

class MangaUpdaterView extends StatelessWidget {
  const MangaUpdaterView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MangaUpdaterCubit(),
      child: const MangaUpdaterContent(),
    );
  }
}
