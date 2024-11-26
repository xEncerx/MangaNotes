import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:manga_notes/features/features.dart';
import 'package:manga_notes/repositories/repositories.dart';
import 'package:manga_notes/router/router.dart';

class LogOutButton extends StatelessWidget {
  const LogOutButton({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: FilledButton(
          style: FilledButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 0,
            backgroundColor: theme.hintColor.withOpacity(0.3),
            overlayColor: theme.hintColor,
          ),
          onPressed: () => _logOut(context),
          child: Text("Выйти из аккаунта", style: theme.textTheme.titleMedium),
        ),
      ),
    );
  }

  Future<void> _logOut(BuildContext context) async {
    await GetIt.I<DataBase>().logOut();
    if (context.mounted) {
      context.read<MangaListBloc>().add(ResetMangaListEvent());
      context.router.replace(const AuthRoute());
    }
  }
}
