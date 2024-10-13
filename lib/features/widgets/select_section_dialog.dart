import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:manga_notes/api/api.dart';
import 'package:manga_notes/features/features.dart';
import 'package:manga_notes/repositories/repositories.dart';
import 'package:manga_notes/ui/const.dart';

enum ClientSection { notReading, read, reading, planned }

Future<String?> showSectionEditor(
  BuildContext context,
  MangaData mangaData,
) async {
  final theme = Theme.of(context);
  var section = stringToClientSection(mangaData.section);

  return await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: theme.scaffoldBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      title: Text(
        "Выберите статус:",
        style: theme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w500,
        ),
      ),
      content: StatefulBuilder(
        builder: (context, StateSetter setState) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SectionRadioTile(
                label: MangaNotesConst.notReadSection,
                value: ClientSection.notReading,
                groupValue: section,
                onChanged: (value) => setState(() => section = value!),
              ),
              SectionRadioTile(
                label: MangaNotesConst.readSection,
                value: ClientSection.read,
                groupValue: section,
                onChanged: (value) => setState(() => section = value!),
              ),
              SectionRadioTile(
                label: MangaNotesConst.readingSection,
                value: ClientSection.reading,
                groupValue: section,
                onChanged: (value) => setState(() => section = value!),
              ),
              SectionRadioTile(
                label: MangaNotesConst.plannedSection,
                value: ClientSection.planned,
                groupValue: section,
                onChanged: (value) => setState(() => section = value!),
              ),
            ],
          );
        },
      ),
      actions: [
        OutlinedActionButton(
          label: "Отмена",
          onTap: () => _closeWindow(context, null),
        ),
        OutlinedActionButton(
          label: "Сохранить",
          onTap: () => _saveData(
            context,
            mangaData: mangaData,
            newSection: stringFromSection(section),
            currentSection: mangaData.section,
          ),
        ),
      ],
      actionsAlignment: MainAxisAlignment.center,
    ),
  );
}

void _closeWindow(BuildContext context, String? selectedSection) {
  Navigator.of(context).pop(selectedSection);
}

Future<void> _saveData(
  BuildContext context, {
  required MangaData mangaData,
  required String newSection,
  required String currentSection,
}) async {
  if (newSection == currentSection) {
    _closeWindow(context, newSection);
    return;
  } else {
    if (currentSection == MangaNotesConst.notReadSection) {
      await GetIt.I<DataBase>().insertMangaData(
        mangaData: mangaData,
        section: newSection,
      );
    } else {
      await GetIt.I<DataBase>().changeSection(mangaData.uuid, newSection);
    }

    if (context.mounted) {
      _closeWindow(context, newSection);
      BlocProvider.of<MangaListBloc>(context).add(LoadMangaListEvent());
      showInfoSnackBar(
        context: context,
        text: 'Манга перенесена из "$currentSection" в "$newSection"',
      );
    }
  }
}

class SectionRadioTile extends StatelessWidget {
  final String label;
  final ClientSection value;
  final ClientSection groupValue;
  final ValueChanged<ClientSection?> onChanged;

  const SectionRadioTile({
    super.key,
    required this.label,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () => onChanged.call(value),
      child: Row(
        children: [
          Radio<ClientSection>(
            value: value,
            groupValue: groupValue,
            onChanged: onChanged,
          ),
          const SizedBox(width: 10),
          Flexible(
            child: Transform.translate(
              offset: const Offset(0, -2),
              child: Text(
                label,
                style: theme.textTheme.labelLarge,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

ClientSection stringToClientSection(String section) {
  switch (section) {
    case MangaNotesConst.notReadSection:
      return ClientSection.notReading;
    case MangaNotesConst.readSection:
      return ClientSection.read;
    case MangaNotesConst.readingSection:
      return ClientSection.reading;
    case MangaNotesConst.plannedSection:
      return ClientSection.planned;
    default:
      return ClientSection.notReading;
  }
}

String stringFromSection(ClientSection section) {
  switch (section) {
    case ClientSection.notReading:
      return MangaNotesConst.notReadSection;
    case ClientSection.read:
      return MangaNotesConst.readSection;
    case ClientSection.reading:
      return MangaNotesConst.readingSection;
    case ClientSection.planned:
      return MangaNotesConst.plannedSection;
  }
}
