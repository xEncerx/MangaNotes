import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:manga_notes/api/api.dart';
import 'package:manga_notes/repositories/repositories.dart';

part 'state.dart';

class MangaUpdaterCubit extends Cubit<MangaUpdaterState> {
  final _mangaApi = MangaApi();

  MangaUpdaterCubit() : super(MangaUpdaterInitial());

  Future<void> startUpdating(List<MangaData> mangaData) async {
    emit(MangaUpdateLoading(remainingTime: 0, progress: 0));

    int totalSteps = mangaData.length;
    int completedSteps = 0;
    double progress = 0;
    double remainingTime = 0;

    List<MangaData>? newData;
    for (var manga in mangaData) {
      if (manga.service == "remanga") {
        newData = await _mangaApi.searchRemanga(searchValue: manga.slug, bySlug: true);
      } else if (manga.service == "shikimori") {
        newData = await _mangaApi.searchShikimori(searchValue: manga.slug, bySlug: true);
      } else if (manga.service == "mangaOVH") {
        newData = await _mangaApi.searchMangaOVH(searchValue: manga.slug, bySlug: true);
      }

      if (newData == null) continue;

      MangaData updatedData = newData[0].copyWith(
        timestamp: manga.timestamp,
        clientUrl: manga.clientUrl,
        section: manga.section,
        id: manga.id,
        userId: manga.userId,
      );

      await GetIt.I<DataBase>().updateMangaDataRow(mangaData: updatedData);

      completedSteps++;
      progress = completedSteps / totalSteps;
      remainingTime = ((0.8 * (totalSteps - completedSteps)));

      emit(MangaUpdateLoading(remainingTime: remainingTime, progress: progress));
    }
    emit(MangaUpdateLoaded());
    await Hive.box("mangaCache").clear();
  }
}
