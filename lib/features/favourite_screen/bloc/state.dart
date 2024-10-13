part of 'bloc.dart';

sealed class MangaListState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class MangaListInitial extends MangaListState {}

final class MangaListLoading extends MangaListState {}

final class MangaListLoaded extends MangaListState {
  final List<MangaData> mangaListReadData;
  final List<MangaData> mangaListReadingData;
  final List<MangaData> mangaListPlannedData;

  MangaListLoaded({
    required this.mangaListReadData,
    required this.mangaListReadingData,
    required this.mangaListPlannedData,
  });

  @override
  List<Object?> get props => super.props
    ..addAll([
      mangaListReadData,
      mangaListReadingData,
      mangaListPlannedData,
    ]);
}

final class MangaListException extends MangaListState {
  final Object exception;

  MangaListException({required this.exception});
  @override
  List<Object?> get props => super.props..add(exception);
}
