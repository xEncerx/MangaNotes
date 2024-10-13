import 'package:flutter/material.dart';

class ImagedNotify extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subTitle;
  final Widget? actionWidget;

  const ImagedNotify({
    super.key,
    required this.imagePath,
    required this.title,
    required this.subTitle,
    this.actionWidget,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              imagePath,
              height: 300,
              fit: BoxFit.cover,
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              subTitle,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium
                  ?.copyWith(overflow: TextOverflow.visible),
            ),
            if (actionWidget != null) ...[
              const SizedBox(height: 10),
              actionWidget!,
            ],
          ],
        ),
      ),
    );
  }
}
