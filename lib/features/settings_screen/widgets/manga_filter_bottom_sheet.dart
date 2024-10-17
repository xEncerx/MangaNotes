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
  late FilterMethod _selectedFilterMethod;

  @override
  void initState() {
    _selectedFilterMethod = _settings.getFilter();
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
            "Фильтрация:",
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          ...filterOptions.map((option) => _buildFilterOption(
                label: option["label"] as String,
                filterMethod: option["method"] as FilterMethod,
              )),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: theme.primaryColor,
              ),
              onPressed: _applyFilter,
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

  Widget _buildFilterOption({
    required String label,
    required FilterMethod filterMethod,
  }) {
    return Row(
      children: [
        Radio<FilterMethod>(
          visualDensity: VisualDensity.compact,
          value: filterMethod,
          groupValue: _selectedFilterMethod,
          onChanged: (FilterMethod? value) {
            if (value != null) {
              setState(() {
                _selectedFilterMethod = value;
              });
            }
          },
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }

  Future<void> _applyFilter() async {
    await _settings.setFilter(_selectedFilterMethod);
    if (mounted) {
      BlocProvider.of<MangaListBloc>(context).add(LoadMangaListEvent());
      Navigator.of(context).pop();
    }
  }
}
