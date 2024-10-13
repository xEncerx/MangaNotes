part of 'bloc.dart';

sealed class SearchingHistoryState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class SearchingInitial extends SearchingHistoryState {}

final class SearchingLoading extends SearchingHistoryState {}

final class SearchingException extends SearchingHistoryState {
  final Object exception;

  SearchingException({required this.exception});
  @override
  List<Object?> get props => super.props..add(exception);
}

final class SearchingHistoryLoaded extends SearchingHistoryState {
  final List<dynamic> historyList;

  SearchingHistoryLoaded({required this.historyList});

  @override
  List<Object?> get props => super.props..add(historyList);
}

final class SearchingMangaListLoaded extends SearchingHistoryState {
  final List<MangaData> mangaListData;

  SearchingMangaListLoaded({required this.mangaListData});

  @override
  List<Object?> get props => super.props..add(mangaListData);
}
