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

class MangaInfoBloc extends Bloc<MangaInfoEvent, MangaInfoState> {
  final mangaApi = MangaApi();

  MangaInfoBloc() : super(MangaInfoInitial()) {
    on<ClearMangaInfoEvent>(
      (event, emit) {
        emit(MangaInfoInitial());
      },
    );

    on<UpdateMangaInfoEvent>(
      (event, emit) async {
        List<MangaData>? newMangaData;
        MangaData? mangaData;

        try {
          switch (event.mangaData.service) {
            case "remanga":
              newMangaData = await mangaApi.searchRemanga(
                searchValue: event.mangaData.slug,
                bySlug: true,
              );
            case "shikimori":
              newMangaData = await mangaApi.searchShikimori(
                searchValue: event.mangaData.slug,
                bySlug: true,
              );
            case "mangaOVH":
              newMangaData = await mangaApi.searchMangaOVH(
                searchValue: event.mangaData.slug,
                bySlug: true,
              );
            case _:
              emit(MangaInfoException());
              return;
          }

          if (newMangaData != null && newMangaData.isNotEmpty) {
            mangaData = newMangaData[0].copyWith(
              timestamp: event.mangaData.timestamp,
              clientUrl: event.mangaData.clientUrl,
              section: event.mangaData.section,
              id: event.mangaData.id,
              userId: event.mangaData.userId,
            );

            if (mangaData.section != MangaNotesConst.notReadSection) {
              await GetIt.I<DataBase>().updateMangaDataRow(
                mangaData: mangaData,
              );
            }
          }

          emit(MangaInfoLoaded(mangaData: mangaData ?? event.mangaData));
        } catch (ex, st) {
          emit(MangaInfoException(exception: ex));
          GetIt.I<Talker>().handle(ex, st);
        } finally {
          event.completer?.complete();
        }
      },
    );
  }
}
