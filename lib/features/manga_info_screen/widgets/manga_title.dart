import 'package:flutter/material.dart';
import 'package:manga_notes/features/features.dart';

class MangaTitle extends StatelessWidget {
  final String mainName;
  final String? altName;

  const MangaTitle({super.key, required this.mainName, required this.altName});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () => _openBottomSheet(context),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Transform.translate(
            offset: const Offset(0, 4),
            child: Icon(
              Icons.info_outline,
              size: 20,
              color: Colors.grey,
            ),
          ),
          Expanded(
            child: Text(
              mainName,
              maxLines: 2,
              textAlign: TextAlign.center,
              style: theme.textTheme.titleMedium,
            ),
          ),
        ],
      ),
    );
  }

  void _openBottomSheet(BuildContext context) {
    final theme = Theme.of(context);

    showModalBottomSheet(
      backgroundColor: theme.scaffoldBackgroundColor,
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20).copyWith(top: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Container(
                  width: 35,
                  height: 4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: theme.hintColor.withOpacity(0.5),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              CopiedText(
                text: "Название",
                copyText: mainName,
                suffixIcon: Icons.copy,
              ),
              Text(mainName, overflow: TextOverflow.visible),
              const Divider(),
              CopiedText(
                text: "Альтернативное название",
                copyText: altName,
                suffixIcon: Icons.copy,
              ),
              Text(
                altName ?? "Альтернативного названия нету(",
                overflow: TextOverflow.visible,
              ),
              const SizedBox(height: 20),
              _CloseButton(),
              const SizedBox(height: 10)
            ],
          ),
        );
      },
    );
  }
}

class _CloseButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 40,
      child: FilledButton(
        style: FilledButton.styleFrom(
          backgroundColor: Theme.of(context).primaryColor,
        ),
        onPressed: () => _close(context),
        child: Text(
          "Закрыть",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  void _close(BuildContext context) => Navigator.of(context).pop();
}
