import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manga_notes/features/features.dart';

Future<void> showRecoverDialog(BuildContext context) async {
  return showDialog(
      context: context, builder: (context) => const RecoveryDialog());
}

class RecoveryDialog extends StatefulWidget {
  const RecoveryDialog({super.key});

  @override
  State<RecoveryDialog> createState() => _RecoveryDialogState();
}

class _RecoveryDialogState extends State<RecoveryDialog> {
  final formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final recoveryCodeController = TextEditingController();
  final newPasswordController = TextEditingController();
  final _bloc = RecoveryPasswordBloc();

  @override
  void dispose() {
    usernameController.dispose();
    recoveryCodeController.dispose();
    newPasswordController.dispose();
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AlertDialog(
      actionsAlignment: MainAxisAlignment.center,
      backgroundColor: theme.scaffoldBackgroundColor,
      title: Text(
        "Восстановление пароля",
        style: theme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w500,
        ),
      ),
      content: _RecoveryTextFields(
        bloc: _bloc,
        usernameController: usernameController,
        recoveryCodeController: recoveryCodeController,
        newPasswordController: newPasswordController,
        formKey: formKey,
      ),
      actions: [
        _RecoveryButton(
          bloc: _bloc,
          usernameController: usernameController,
          recoveryCodeController: recoveryCodeController,
          newPasswordController: newPasswordController,
          formKey: formKey,
        ),
      ],
    );
  }
}

class _RecoveryButton extends StatelessWidget {
  final TextEditingController usernameController;
  final TextEditingController recoveryCodeController;
  final TextEditingController newPasswordController;
  final GlobalKey<FormState> formKey;
  final RecoveryPasswordBloc bloc;

  const _RecoveryButton({
    required this.bloc,
    required this.formKey,
    required this.usernameController,
    required this.recoveryCodeController,
    required this.newPasswordController,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RecoveryPasswordBloc, RecoveryPasswordState>(
      bloc: bloc,
      listener: (context, state) {
        if (state is IncorrectRecoveryCode) {
          showInfoSnackBar(context: context, text: "Данные введены неверно!");
        }
        if (state is NewPasswordUpdated) {
          Navigator.of(context).pop();
          showInfoSnackBar(
            context: context,
            text: "Пароль был успешно изменен",
          );
        }
      },
      builder: (context, state) {
        if (state is CheckRecoveryCodeStateLoading ||
            state is NewPasswordLoading) {
          return const SizedBox(
            width: 30,
            height: 30,
            child: CircularProgressIndicator(),
          );
        }
        if (state is CheckRecoveryCodeStateLoaded) {
          return AuthFilledActionButton(
            text: "Сохранить",
            onTap: () => _saveNewPassword(context),
          );
        }

        return AuthFilledActionButton(
          text: "Восстановить",
          onTap: () => _recoverPassword(context),
        );
      },
    );
  }

  void _recoverPassword(BuildContext context) {
    if (formKey.currentState!.validate()) {
      bloc.add(
        CheckRecoveryCodeEvent(
          username: usernameController.text,
          code: recoveryCodeController.text,
        ),
      );
    }
  }

  void _saveNewPassword(BuildContext context) {
    if (formKey.currentState!.validate()) {
      bloc.add(SaveNewPasswordEvent(
        username: usernameController.text,
        newPassword: newPasswordController.text,
      ));
    }
  }
}

class _RecoveryTextFields extends StatelessWidget {
  final RecoveryPasswordBloc bloc;
  final TextEditingController usernameController;
  final TextEditingController recoveryCodeController;
  final TextEditingController newPasswordController;
  final GlobalKey<FormState> formKey;

  const _RecoveryTextFields({
    required this.bloc,
    required this.usernameController,
    required this.recoveryCodeController,
    required this.newPasswordController,
    required this.formKey,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecoveryPasswordBloc, RecoveryPasswordState>(
      bloc: bloc,
      builder: (context, state) {
        if (state is CheckRecoveryCodeStateLoaded ||
            state is NewPasswordLoading ||
            state is NewPasswordUpdated) {
          return Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("Введите новый пароль"),
                AuthTextField(
                  key: UniqueKey(),
                  controller: newPasswordController,
                  isPasswordField: true,
                  labelText: "Новый пароль",
                ),
              ],
            ),
          );
        }

        return Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Введите username и код восстановления",
                overflow: TextOverflow.visible,
              ),
              AuthTextField(
                controller: usernameController,
                labelText: "Username",
              ),
              AuthTextField(
                controller: recoveryCodeController,
                labelText: "Код восстановления",
              ),
            ],
          ),
        );
      },
    );
  }
}
