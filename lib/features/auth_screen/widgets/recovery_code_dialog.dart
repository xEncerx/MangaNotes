import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:manga_notes/features/auth_screen/auth_screen.dart';

Future<void> showRecoveryCodeDialog(
  BuildContext context,
  String recoveryCode,
) async {
  final theme = Theme.of(context);

  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => AlertDialog(
      actionsAlignment: MainAxisAlignment.center,
      backgroundColor: theme.scaffoldBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      title: Text(
        "Код восстановления",
        style: theme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w500,
        ),
      ),
      content: Text(
        "Сохраните этот код, чтобы вы смогли восстановить доступ к аккаунту!"
        "\n\nКод: $recoveryCode",
        overflow: TextOverflow.visible,
      ),
      actions: [
        AuthFilledActionButton(
          onTap: () => _copyCode(context, recoveryCode),
          text: "Скопировать",
        )
      ],
    ),
  );
}

Future<void> _copyCode(BuildContext context, String value) async {
  await Clipboard.setData(ClipboardData(text: value));
  if (context.mounted) {
    Navigator.of(context).pop();
  }
}
