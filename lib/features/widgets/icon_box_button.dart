import 'package:flutter/material.dart';

class IconBoxButton extends StatelessWidget {
  final VoidCallback onTap;
  final IconData icon;

  const IconBoxButton({super.key, required this.onTap, required this.icon});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return IconButton(
      icon: Icon(
        icon,
        color: theme.hintColor,
      ),
      style: IconButton.styleFrom(
        backgroundColor: theme.canvasColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      onPressed: () => onTap.call(),
    );
  }
}
