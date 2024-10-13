import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manga_notes/features/features.dart';
import 'package:manga_notes/router/router.dart';

@RoutePage()
class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) async {
          if (state is AuthLogInError) {
            showInfoSnackBar(
              context: context,
              text: "Username или password введены неверно!",
            );
          }
          if (state is AuthSignUpError) {
            showInfoSnackBar(
              context: context,
              text: "Аккаунт с таким username уже существует!",
            );
          }
          if (state is AuthFinished) {
            if (state.recoveryCode != null) {
              await showRecoveryCodeDialog(context, state.recoveryCode!);
            } else {
              showInfoSnackBar(context: context, text: state.text!);
            }
            if (context.mounted) {
              context.router.replace(const FavouriteRoute());
              BlocProvider.of<MangaListBloc>(context).add(LoadMangaListEvent());
            }
          }
        },
        child: LogInView(),
      ),
    );
  }
}
