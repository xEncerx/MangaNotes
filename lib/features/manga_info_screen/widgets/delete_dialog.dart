import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:manga_notes/api/api.dart';
import 'package:manga_notes/features/features.dart';
import 'package:manga_notes/repositories/repositories.dart';

Future<void> showDeleteDialog(
  BuildContext context,
  MangaData mangaData,
) async {
  final theme = Theme.of(context);
  return await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: theme.scaffoldBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      title: Text(
        "Подтверждение",
        style: theme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w500,
        ),
      ),
      content: const Text(
        "Вы действительно хотите удалить эту мангу?",
        overflow: TextOverflow.visible,
      ),
      actions: [
        OutlinedActionButton(
          label: "Отмена",
          onTap: () => _closeWindow(context),
        ),
        OutlinedActionButton(
          label: "Удалить",
          onTap: () => _deleteManga(context, mangaData.uuid),
          textColor: theme.primaryColor.withOpacity(0.7),
        ),
      ],
      actionsAlignment: MainAxisAlignment.center,
    ),
  );
}

void _closeWindow(BuildContext context) => Navigator.of(context).pop();
Future<void> _deleteManga(BuildContext context, String uuid) async {
  await GetIt.I<DataBase>().deleteManga(uuid);
  if (context.mounted) {
    BlocProvider.of<MangaListBloc>(context).add(LoadMangaListEvent());
    Navigator.of(context).pop();
    AutoRouter.of(context).maybePop();
  }
}
