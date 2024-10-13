import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:manga_notes/api/api.dart';
import 'package:manga_notes/features/features.dart';
import 'package:manga_notes/ui/const.dart';

class MangaInfoAppBar extends StatelessWidget implements PreferredSizeWidget {
  final MangaData mangaData;
  const MangaInfoAppBar({super.key, required this.mangaData});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppBar(
      backgroundColor: theme.scaffoldBackgroundColor,
      surfaceTintColor: theme.scaffoldBackgroundColor,
      automaticallyImplyLeading: false,
      titleSpacing: 5,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconBoxButton(
            onTap: () => _close(context),
            icon: Icons.arrow_back,
          ),
          Flexible(
            child: Text(
              mangaData.service.capitalize(),
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: theme.primaryColor,
              ),
            ),
          ),
          IconBoxButton(
            onTap: () => _openDeleteDialog(context),
            icon: Icons.delete,
          ),
        ],
      ),
    );
  }

  void _close(BuildContext context) => AutoRouter.of(context).maybePop();
  Future<void> _openDeleteDialog(BuildContext context) async {
    if (mangaData.section == MangaNotesConst.notReadSection) {
      showInfoSnackBar(
        context: context,
        text: "Сначала добавь мангу в один из разделов!",
      );
      return;
    }
    if (context.mounted) {
      await showDeleteDialog(context, mangaData);
    }
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
