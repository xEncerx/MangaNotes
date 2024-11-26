import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:manga_notes/api/api.dart';
import 'package:manga_notes/features/features.dart';
import 'package:manga_notes/repositories/repositories.dart';
import 'package:manga_notes/ui/ui.dart';

class MangaUpdaterContent extends StatefulWidget {
  const MangaUpdaterContent({super.key});

  @override
  State<MangaUpdaterContent> createState() => _MangaUpdaterContentState();
}

class _MangaUpdaterContentState extends State<MangaUpdaterContent> {
  bool _isReadSection = false;
  bool _isReadingSection = true;
  bool _isPlannedSection = true;
  late Future<List<MangaData>?> mangaListData;

  @override
  void initState() {
    mangaListData = GetIt.I<DataBase>().selectAllManga();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15).copyWith(bottom: 5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitle("Обновление всей манги"),
          const SizedBox(height: 5),
          _buildDescription(),
          const SizedBox(height: 5),
          _buildTitle("Разделы:"),
          const SizedBox(height: 5),
          MangaUpdaterCheckBox(
            text: MangaNotesConst.readSection,
            value: _isReadSection,
            onChanged: (v) => setState(() => _isReadSection = v),
          ),
          MangaUpdaterCheckBox(
            text: MangaNotesConst.readingSection,
            value: _isReadingSection,
            onChanged: (v) => setState(() => _isReadingSection = v),
          ),
          MangaUpdaterCheckBox(
            text: MangaNotesConst.plannedSection,
            value: _isPlannedSection,
            onChanged: (v) => setState(() => _isPlannedSection = v),
          ),
          const SizedBox(height: 5),
          BlocBuilder<MangaUpdaterCubit, MangaUpdaterState>(
            builder: (context, state) {
              if (state is MangaUpdateLoading) {
                return _buildLoadingBar(state.progress, state.remainingTime);
              } else if (state is MangaUpdateLoaded) {
                BlocProvider.of<MangaListBloc>(context).add(LoadMangaListEvent());
                return _buildLoadedText();
              }
              return _buildUpdateButton();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTitle(String text) {
    return Text(
      text,
      style: Theme.of(context).textTheme.titleMedium,
    );
  }

  Widget _buildDescription() {
    return const Text(
      "Вы можете обновить всю информацию о манге в один клик."
      " Просто выберите нужный раздел и нажмите обновить."
      " Это может занять некоторое время.",
      overflow: TextOverflow.visible,
    );
  }

  Widget _buildLoadedText() {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.check),
          const SizedBox(width: 8),
          Text(
            "Обновление завершено!",
            style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildFilledButton(List<MangaData>? mangaListData) {
    final theme = Theme.of(context);

    return Center(
      child: SizedBox(
        width: 200,
        height: 40,
        child: FilledButton(
          style: FilledButton.styleFrom(
            backgroundColor: theme.primaryColor.withOpacity(0.9),
          ),
          onPressed: () {
            var mangaData = _getSelectedMangaList(mangaListData);
            if (mangaData.isEmpty) return;
            context.read<MangaUpdaterCubit>().startUpdating(mangaData);
          },
          child: Text("Обновить", style: theme.textTheme.titleMedium),
        ),
      ),
    );
  }

  Widget _buildUpdateButton() {
    return FutureBuilder(
      future: mangaListData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Center(
            child: Column(
              children: [
                _buildFilledButton(snapshot.data),
                Text(_calculateEndTime(snapshot.data)),
              ],
            ),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _buildLoadingBar(double progress, double remainingTime) {
    return BlocBuilder<MangaUpdaterCubit, MangaUpdaterState>(
      builder: (context, state) {
        return Column(
          children: [
            LinearProgressIndicator(value: progress),
            Text("Оставшееся время: ${remainingTime.toStringAsFixed(2)} сек."),
          ],
        );
      },
    );
  }

  String _calculateEndTime(List<MangaData>? mangaListData) {
    if (mangaListData == null) return "~ 0 сек.";

    double endTime = _getSelectedMangaList(mangaListData).length * 0.35;
    return "~ ${endTime.toStringAsFixed(1)} сек. | ${mangaListData.length} шт.";
  }

  List<MangaData> _getSelectedMangaList(List<MangaData>? mangaListData) {
    if (mangaListData == null) return [];

    final selectedSections = <String>{
      if (_isReadSection) MangaNotesConst.readSection,
      if (_isReadingSection) MangaNotesConst.readingSection,
      if (_isPlannedSection) MangaNotesConst.plannedSection,
    };

    return mangaListData.where((manga) => selectedSections.contains(manga.section)).toList();
  }
}
