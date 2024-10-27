import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:manga_notes/api/api.dart';
import 'package:manga_notes/features/features.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        CustomRoute(page: HomeRoute.page, path: "/"),
        CustomRoute(page: FavouriteRoute.page, path: "/favourite"),
        AutoRoute(page: AuthRoute.page, path: "/auth"),
        CustomRoute(
          page: MangaInfoRoute.page,
          path: "/manga-info",
          opaque: false,
          durationInMilliseconds: 250,
          reverseDurationInMilliseconds: 250,
          transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
        ),
        CustomRoute(
          page: SearchingRoute.page,
          path: "/search",
          opaque: false,
          durationInMilliseconds: 0,
          reverseDurationInMilliseconds: 250,
          transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
        ),
        CustomRoute(
          page: SettingsRoute.page,
          path: "/settings",
          opaque: false,
          durationInMilliseconds: 0,
          reverseDurationInMilliseconds: 250,
          transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
        ),
      ];
}
