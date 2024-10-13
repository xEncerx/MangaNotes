part of 'bloc.dart';

sealed class SearchingHistoryEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

final class LoadSearchingHistoryEvent extends SearchingHistoryEvent {}

final class LoadSearchingMangaListEvent extends SearchingHistoryEvent {
  final String mangaName;

  LoadSearchingMangaListEvent({required this.mangaName});
  @override
  List<Object?> get props => super.props..add(mangaName);
}

final class ClearHistoryEvent extends SearchingHistoryEvent {}
