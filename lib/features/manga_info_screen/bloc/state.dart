part of 'bloc.dart';

sealed class MangaInfoState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class MangaInfoInitial extends MangaInfoState {}

final class MangaInfoLoading extends MangaInfoState {}

final class MangaInfoLoaded extends MangaInfoState {
  final MangaData mangaData;

  MangaInfoLoaded({required this.mangaData});

  @override
  List<Object?> get props => [super.props..add(mangaData)];
}

final class MangaInfoException extends MangaInfoState {
  final Object? exception;

  MangaInfoException({this.exception});

  @override
  List<Object?> get props => super.props..add(exception);
}
