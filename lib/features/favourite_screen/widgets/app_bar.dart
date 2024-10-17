import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

class SearchingAppBarButton extends StatelessWidget
    implements PreferredSizeWidget {
  final TabBar? tabBar;
  final int barHeight;

  const SearchingAppBarButton({super.key, this.tabBar, this.barHeight = 0});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppBar(
      automaticallyImplyLeading: false,
      surfaceTintColor: theme.scaffoldBackgroundColor,
      bottom: tabBar,
      title: GestureDetector(
        onTap: () => _openSearchingScreen(context),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: theme.canvasColor,
          ),
          child: ListTile(
            visualDensity: VisualDensity.compact,
            leading: Icon(Icons.search, color: theme.hintColor),
            title: Text("Поиск манги...", style: theme.textTheme.titleSmall),
          ),
        ),
      ),
      actions: [
        IconButton(
          onPressed: () => _openSettingsScreen(context),
          icon: Icon(
            Icons.settings_outlined,
            color: theme.hintColor,
            size: 26,
          ),
        ),
        const SizedBox(width: 5),
        IconButton(
          onPressed: () => _openTalkerScreen(context),
          icon: Icon(
            Icons.monitor_heart_outlined,
            color: theme.hintColor,
            size: 26,
          ),
        ),
        const SizedBox(width: 5),
      ],
    );
  }

  void _openTalkerScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => TalkerScreen(
          talker: GetIt.I<Talker>(),
        ),
      ),
    );
  }

  void _openSearchingScreen(BuildContext context) =>
      AutoRouter.of(context).pushNamed("/search");

  void _openSettingsScreen(BuildContext context) =>
      AutoRouter.of(context).pushNamed("/settings");

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + barHeight);
}
