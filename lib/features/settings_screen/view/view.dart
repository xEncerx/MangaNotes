import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:manga_notes/features/features.dart';

@RoutePage()
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SwipeableContent(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          surfaceTintColor: theme.scaffoldBackgroundColor,
          titleSpacing: 5,
          title: Stack(
            children: [
              IconBoxButton(
                onTap: () => _close(context),
                icon: Icons.arrow_back,
              ),
              Center(
                child: Transform.translate(
                  offset: const Offset(0, 5),
                  child: Text(
                    "Настройки",
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: theme.primaryColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: const SettingsBody(),
      ),
    );
  }

  void _close(BuildContext context) => AutoRouter.of(context).maybePop();
}
