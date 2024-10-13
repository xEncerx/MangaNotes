import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:manga_notes/api/api.dart';
import 'package:manga_notes/features/features.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: HomeRoute.page, path: "/"),
        AutoRoute(page: FavouriteRoute.page, path: "/favourite"),
        AutoRoute(page: AuthRoute.page, path: "/auth"),
        AutoRoute(page: SearchingRoute.page, path: "/search"),
        AutoRoute(page: MangaInfoRoute.page, path: "/manga-info"),
        AutoRoute(page: SettingsRoute.page, path: "/settings"),
      ];
}
