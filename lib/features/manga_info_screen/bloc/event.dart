part of 'bloc.dart';

sealed class MangaInfoEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

final class UpdateMangaInfoEvent extends MangaInfoEvent {
  final Completer? completer;
  final MangaData mangaData;

  UpdateMangaInfoEvent({required this.mangaData, this.completer});

  @override
  List<Object?> get props => super.props..addAll([mangaData, completer]);
}

final class ClearMangaInfoEvent extends MangaInfoEvent {}
