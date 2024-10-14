import 'package:flutter/material.dart';

class AuthFilledActionButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;

  const AuthFilledActionButton({
    super.key,
    required this.onTap,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return FilledButton(
      onPressed: () => onTap.call(),
      style: FilledButton.styleFrom(
        backgroundColor: theme.primaryColor,
      ),
      child: Transform.translate(
        offset: const Offset(0, -1),
        child: Text(
          text,
          style: const TextStyle(
            color: Color(0xFF121212),
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}

class AuthTextActionButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;

  const AuthTextActionButton({
    super.key,
    required this.onTap,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextButton(
      onPressed: () => onTap.call(),
      child: Text(
        text,
        style: TextStyle(
          color: theme.primaryColor,
        ),
      ),
    );
  }
}
