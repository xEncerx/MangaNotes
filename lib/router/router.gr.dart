// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'router.dart';

/// generated route for
/// [AuthScreen]
class AuthRoute extends PageRouteInfo<void> {
  const AuthRoute({List<PageRouteInfo>? children})
      : super(
          AuthRoute.name,
          initialChildren: children,
        );

  static const String name = 'AuthRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AuthScreen();
    },
  );
}

/// generated route for
/// [FavouriteScreen]
class FavouriteRoute extends PageRouteInfo<void> {
  const FavouriteRoute({List<PageRouteInfo>? children})
      : super(
          FavouriteRoute.name,
          initialChildren: children,
        );

  static const String name = 'FavouriteRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const FavouriteScreen();
    },
  );
}

/// generated route for
/// [HomeScreen]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const HomeScreen();
    },
  );
}

/// generated route for
/// [MangaInfoScreen]
class MangaInfoRoute extends PageRouteInfo<MangaInfoRouteArgs> {
  MangaInfoRoute({
    Key? key,
    required MangaData mangaData,
    List<PageRouteInfo>? children,
  }) : super(
          MangaInfoRoute.name,
          args: MangaInfoRouteArgs(
            key: key,
            mangaData: mangaData,
          ),
          initialChildren: children,
        );

  static const String name = 'MangaInfoRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<MangaInfoRouteArgs>();
      return MangaInfoScreen(
        key: args.key,
        mangaData: args.mangaData,
      );
    },
  );
}

class MangaInfoRouteArgs {
  const MangaInfoRouteArgs({
    this.key,
    required this.mangaData,
  });

  final Key? key;

  final MangaData mangaData;

  @override
  String toString() {
    return 'MangaInfoRouteArgs{key: $key, mangaData: $mangaData}';
  }
}

/// generated route for
/// [SearchingScreen]
class SearchingRoute extends PageRouteInfo<void> {
  const SearchingRoute({List<PageRouteInfo>? children})
      : super(
          SearchingRoute.name,
          initialChildren: children,
        );

  static const String name = 'SearchingRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SearchingScreen();
    },
  );
}

/// generated route for
/// [SettingsScreen]
class SettingsRoute extends PageRouteInfo<void> {
  const SettingsRoute({List<PageRouteInfo>? children})
      : super(
          SettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SettingsScreen();
    },
  );
}
