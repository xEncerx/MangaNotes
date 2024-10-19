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
  final history = GetIt.I<HistoryRepository>();
  final mangaApi = MangaApi();

  SearchingHistoryBloc() : super(SearchingInitial()) {
    on<LoadSearchingHistoryEvent>(
      (event, emit) async {
        if (state is! SearchingHistoryLoaded) {
          emit(SearchingLoading());
        }

        try {
          final historyList = await history.readAll();
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
          await history.clear();
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
          List<MangaData> mangaListData = await mangaApi.globalSearch(
            event.mangaName,
          );
          final dbMangas = await GetIt.I<DataBase>().selectAllManga();

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

          mangaListData = MangaSorter(mangaListData: mangaListData).sort(
            method: SorterMethod.byNameMatching,
            arg: event.mangaName,
          );

          emit(SearchingMangaListLoaded(mangaListData: mangaListData));
        } catch (ex, st) {
          emit(SearchingException(exception: ex));
          GetIt.I<Talker>().handle(ex, st);
        }
      },
    );
  }
}
