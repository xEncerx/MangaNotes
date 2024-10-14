part of 'manga_button_cubit.dart';

class MangaButtonState extends Equatable {
  final String style;
  bool get isCardStyle => style == "card";

  const MangaButtonState({this.style = "default"});

  @override
  List<Object> get props => [style];
}
