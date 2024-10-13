import 'package:flutter/material.dart';
import 'package:manga_notes/api/api.dart';
import 'package:manga_notes/features/features.dart';

class SectionButton extends StatefulWidget {
  final MangaData mangaData;

  const SectionButton({super.key, required this.mangaData});

  @override
  State<SectionButton> createState() => _SectionButtonState();
}

class _SectionButtonState extends State<SectionButton> {
  late String section;

  @override
  void initState() {
    section = widget.mangaData.section;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        visualDensity: VisualDensity.compact,
        padding: EdgeInsets.symmetric(horizontal: 15),
        side: BorderSide(
          color: theme.hintColor.withOpacity(0.5),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: () => _openSectionEditor(),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(section),
          const SizedBox(width: 5),
          Icon(Icons.keyboard_arrow_down),
        ],
      ),
    );
  }

  Future<void> _openSectionEditor() async {
    String? newSection = await showSectionEditor(
      context,
      widget.mangaData.copyWith(section: section),
    );
    if (newSection != null && section != newSection && mounted) {
      setState(() => section = newSection);
    }
  }
}
