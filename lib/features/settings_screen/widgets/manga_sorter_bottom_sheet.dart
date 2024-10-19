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
    isScrollControlled: true,
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
  late SorterMethod _sorterMethod;
  late SorterOrder _sorterOrder;

  @override
  void initState() {
    final sorterData = _settings.getSorter();
    _sorterMethod = sorterData.sorterMethod;
    _sorterOrder = sorterData.sorterOrder;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20).copyWith(bottom: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Сортировка",
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10),
          ...sorterOptions.map(
            (i) => _buildSorterMethodOption(
              label: i.label,
              sorterMethod: i.sorterMethod,
            ),
          ),
          const Divider(),
          _buildSorterOrderOption(
            label: "По убыванию",
            sorterOrder: SorterOrder.asc,
          ),
          _buildSorterOrderOption(
            label: "По возрастанию",
            sorterOrder: SorterOrder.desc,
          ),
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

  Widget _buildSorterOrderOption({
    required String label,
    required SorterOrder sorterOrder,
  }) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Radio<SorterOrder>(
          visualDensity: VisualDensity.compact,
          value: sorterOrder,
          groupValue: _sorterOrder,
          activeColor: theme.primaryColor,
          onChanged: (SorterOrder? value) {
            if (value != null) {
              setState(() {
                _sorterOrder = value;
              });
            }
          },
        ),
        _buildSorterLabel(label: label),
      ],
    );
  }

  Widget _buildSorterMethodOption({
    required String label,
    required SorterMethod sorterMethod,
  }) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Radio<SorterMethod>(
          visualDensity: VisualDensity.compact,
          value: sorterMethod,
          groupValue: _sorterMethod,
          activeColor: theme.primaryColor,
          onChanged: (SorterMethod? value) {
            if (value != null) {
              setState(() {
                _sorterMethod = value;
              });
            }
          },
        ),
        _buildSorterLabel(label: label),
      ],
    );
  }

  Widget _buildSorterLabel({required String label}) {
    return Flexible(
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelSmall,
      ),
    );
  }

  Future<void> _applySorting() async {
    await _settings.setSorter(_sorterMethod, _sorterOrder);
    if (mounted) {
      BlocProvider.of<MangaListBloc>(context).add(LoadMangaListEvent());
      Navigator.of(context).pop();
    }
  }
}
