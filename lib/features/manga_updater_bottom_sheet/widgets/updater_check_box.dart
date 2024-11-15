import 'package:flutter/material.dart';

class MangaUpdaterCheckBox extends StatelessWidget {
  final String text;
  final bool value;
  final Function(bool) onChanged;

  const MangaUpdaterCheckBox({
    super.key,
    required this.text,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: value,
          onChanged: (v) => onChanged(v!),
          visualDensity: VisualDensity.compact,
        ),
        const SizedBox(width: 5),
        Text(
          text,
          style: Theme.of(context).textTheme.labelSmall,
        ),
      ],
    );
  }
}
