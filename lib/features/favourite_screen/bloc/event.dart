part of 'bloc.dart';

sealed class MangaListEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

final class LoadMangaListEvent extends MangaListEvent {
  final Completer? completer;

  LoadMangaListEvent({this.completer});

  @override
  List<Object?> get props => super.props..add(completer);
}

final class ResetMangaListEvent extends MangaListEvent {}
