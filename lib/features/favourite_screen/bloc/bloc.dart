import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:manga_notes/api/api.dart';
import 'package:manga_notes/repositories/repositories.dart';
import 'package:manga_notes/ui/const.dart';
import 'package:talker/talker.dart';

part 'event.dart';
part 'state.dart';

class MangaListBloc extends Bloc<MangaListEvent, MangaListState> {
  final settings = GetIt.I<SettingsRepository>();

  MangaListBloc() : super(MangaListInitial()) {
    on<LoadMangaListEvent>(
      (event, emit) async {
        if (state is! MangaListLoaded) emit(MangaListLoading());

        try {
          var mangaListData = await GetIt.I<DataBase>().selectAllManga();

          if (mangaListData != null && mangaListData.isNotEmpty) {
            final sortedData = settings.getSorter();

            mangaListData = MangaSorter(mangaListData: mangaListData).sort(
              method: sortedData.sorterMethod,
              sorterOrder: sortedData.sorterOrder,
            );
          }

          final readManga = mangaListData
              ?.where((manga) => manga.section == MangaNotesConst.readSection)
              .toList();
          var readingManga = mangaListData
              ?.where(
                  (manga) => manga.section == MangaNotesConst.readingSection)
              .toList();
          final plannedManga = mangaListData
              ?.where(
                  (manga) => manga.section == MangaNotesConst.plannedSection)
              .toList();

          emit(MangaListLoaded(
            mangaListReadData: readManga ?? [],
            mangaListReadingData: readingManga ?? [],
            mangaListPlannedData: plannedManga ?? [],
          ));
        } catch (ex, st) {
          emit(MangaListException(exception: ex));
          GetIt.I<Talker>().handle(ex, st);
        } finally {
          event.completer?.complete();
        }
      },
    );

    on<ResetMangaListEvent>((event, emit) {
      emit(MangaListInitial());
    });
  }
}
