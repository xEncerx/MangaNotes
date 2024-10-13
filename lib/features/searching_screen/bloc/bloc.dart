import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:manga_notes/api/api.dart';
import 'package:manga_notes/repositories/repositories.dart';
import 'package:talker/talker.dart';

part 'event.dart';
part 'state.dart';

class SearchingHistoryBloc
    extends Bloc<SearchingHistoryEvent, SearchingHistoryState> {
  final historyRepository = HistoryRepository();
  final mangaApi = MangaApi();

  SearchingHistoryBloc() : super(SearchingInitial()) {
    on<LoadSearchingHistoryEvent>(
      (event, emit) async {
        if (state is! SearchingHistoryLoaded) {
          emit(SearchingLoading());
        }

        try {
          final historyList = await historyRepository.readAll();
          emit(SearchingHistoryLoaded(historyList: historyList));
        } catch (ex, st) {
          emit(SearchingException(exception: ex));
          GetIt.I<Talker>().handle(ex, st);
        }
      },
    );
    on<ClearHistoryEvent>(
      (event, emit) async {
        try {
          await historyRepository.clear();
          emit(SearchingHistoryLoaded(historyList: []));
        } catch (ex, st) {
          emit(SearchingException(exception: ex));
          GetIt.I<Talker>().handle(ex, st);
        }
      },
    );
    on<LoadSearchingMangaListEvent>(
      (event, emit) async {
        if (state is! SearchingMangaListLoaded) {
          emit(SearchingLoading());
        }

        try {
          // TODO: Sort by naming
          final dbMangas = await GetIt.I<DataBase>().selectAllManga();
          List<MangaData> mangaListData = await mangaApi.globalSearch(
            event.mangaName,
          );

          // Копируем существующий данные. Если манга уже есть в БД
          if (dbMangas != null && dbMangas.isNotEmpty) {
            final Map<String, MangaData> dbMangaSections = {
              for (var dbManga in dbMangas) dbManga.uuid: dbManga
            };
            mangaListData = mangaListData.map((apiManga) {
              final dbMangaData = dbMangaSections[apiManga.uuid];
              return apiManga.copyWith(
                timestamp: dbMangaData?.timestamp,
                clientUrl: dbMangaData?.clientUrl,
                section: dbMangaData?.section,
                id: dbMangaData?.id,
                userId: dbMangaData?.userId,
                description: dbMangaData?.description,
              );
            }).toList();
          }

          mangaListData.sort((a, b) {
            // Сравниваем названия манг по схожести с искомым названием
            final aSimilarity = compareMangaTitles(
              a.mainName.toLowerCase(),
              event.mangaName.toLowerCase(),
            );
            final bSimilarity = compareMangaTitles(
              b.mainName.toLowerCase(),
              event.mangaName.toLowerCase(),
            );

            // Чем больше совпадение, тем выше манга в списке
            return bSimilarity.compareTo(aSimilarity);
          });

          emit(SearchingMangaListLoaded(mangaListData: mangaListData));
        } catch (ex, st) {
          emit(SearchingException(exception: ex));
          GetIt.I<Talker>().handle(ex, st);
        }
      },
    );
  }
}

int compareMangaTitles(String mangaName, String searchName) {
  int minLength = min(mangaName.length, searchName.length);
  for (int i = 0; i < minLength; i++) {
    if (mangaName[i] != searchName[i]) {
      return i; // Количество совпадающих символов
    }
  }
  return minLength; // Если совпадают полностью
}
