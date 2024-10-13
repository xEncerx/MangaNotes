part of 'theme_cubit.dart';

class ThemeState extends Equatable {
  final String theme;
  bool get isDark => theme == "dark";

  const ThemeState({this.theme = "dark"});

  @override
  List<Object> get props => [theme];
}
