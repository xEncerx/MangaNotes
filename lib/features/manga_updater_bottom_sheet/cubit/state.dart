part of 'cubit.dart';

sealed class MangaUpdaterState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class MangaUpdaterInitial extends MangaUpdaterState {}

final class MangaUpdateLoading extends MangaUpdaterState {
  final double progress;
  final double remainingTime;

  MangaUpdateLoading({required this.remainingTime, required this.progress});

  @override
  List<Object?> get props => super.props..addAll([remainingTime, progress]);
}

final class MangaUpdateLoaded extends MangaUpdaterState {}
