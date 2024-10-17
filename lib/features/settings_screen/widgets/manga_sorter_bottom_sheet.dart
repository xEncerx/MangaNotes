import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:manga_notes/features/features.dart';
import 'package:manga_notes/repositories/repositories.dart';

void showMangaBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    showDragHandle: true,
    builder: (context) => const _MangaBottomSheetContent(),
  );
}

class _MangaBottomSheetContent extends StatefulWidget {
  const _MangaBottomSheetContent();

  @override
  State<_MangaBottomSheetContent> createState() =>
      _MangaBottomSheetContentState();
}

class _MangaBottomSheetContentState extends State<_MangaBottomSheetContent> {
  final SettingsRepository _settings = GetIt.I<SettingsRepository>();
  late SorterMethod _selectedSorterMethod;

  @override
  void initState() {
    _selectedSorterMethod = _settings.getSorter();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20).copyWith(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Сортировка:",
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10),
          ...sorterOptions.map((option) => _buildSorterOption(
                label: option["label"] as String,
                sorterMethod: option["method"] as SorterMethod,
              )),
          const SizedBox(height: 15),
          SizedBox(
            width: double.infinity,
            height: 40,
            child: FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: theme.primaryColor,
              ),
              onPressed: _applySorting,
              child: const Text(
                "Сохранить",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSorterOption({
    required String label,
    required SorterMethod sorterMethod,
  }) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Radio<SorterMethod>(
          visualDensity: VisualDensity.compact,
          value: sorterMethod,
          groupValue: _selectedSorterMethod,
          activeColor: theme.primaryColor,
          onChanged: (SorterMethod? value) {
            if (value != null) {
              setState(() {
                _selectedSorterMethod = value;
              });
            }
          },
        ),
        Text(
          label,
          style: theme.textTheme.bodyLarge,
        ),
      ],
    );
  }

  Future<void> _applySorting() async {
    await _settings.setSorter(_selectedSorterMethod);
    if (mounted) {
      BlocProvider.of<MangaListBloc>(context).add(LoadMangaListEvent());
      Navigator.of(context).pop();
    }
  }
}
