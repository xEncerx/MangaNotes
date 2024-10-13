import 'package:flutter/material.dart';

class OutlinedActionButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final EdgeInsets contentPadding;
  final Color? textColor;

  const OutlinedActionButton({
    super.key,
    required this.label,
    required this.onTap,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 12),
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        visualDensity: VisualDensity.compact,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: contentPadding,
        side: BorderSide(color: theme.hintColor.withOpacity(0.3)),
      ),
      child: Text(
        label,
        style: TextStyle(color: textColor ?? theme.primaryColor),
      ),
    );
  }
}
