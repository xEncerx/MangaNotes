part of 'bloc.dart';

sealed class SearchingHistoryEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

final class LoadSearchingHistory extends SearchingHistoryEvent {}

final class SearchManga extends SearchingHistoryEvent {
  final String mangaName;

  SearchManga({required this.mangaName});
  @override
  List<Object?> get props => super.props..add(mangaName);
}

final class ClearSearchingHistory extends SearchingHistoryEvent {}
