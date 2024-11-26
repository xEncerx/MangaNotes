import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manga_notes/cubit/cubit.dart';
import 'package:manga_notes/features/features.dart';
import 'package:manga_notes/generated/assets.dart';
import 'package:manga_notes/ui/const.dart';

class SettingsBody extends StatelessWidget {
  const SettingsBody({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeCubit = context.watch<ThemeCubit>().state;
    final mangaButtonCubit = context.watch<MangaButtonCubit>().state;

    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: IntrinsicHeight(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Open Source",
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Это приложение и все относящиеся к нему сервисы являются 100% бесплатными и Open Source продуктами."
                    " Мы с огромным удовольствием примем любые ваши предложения и сообщения,"
                    " а также мы рады любому вашему участию в проекте!",
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontSize: 13,
                      overflow: TextOverflow.visible,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Row(
                    children: [
                      UrlOutlinedButton(
                        iconAsset: Assets.iconsGithub,
                        url: MangaNotesConst.projectGitHub,
                      ),
                      SizedBox(width: 10),
                      UrlOutlinedButton(
                        iconAsset: Assets.iconsTelegram,
                        url: MangaNotesConst.developerTG,
                      ),
                    ],
                  ),
                  SettingsSwitch(
                    value: themeCubit.isDark,
                    onChanged: (context, value) => _changeTheme(context, value),
                    icon: Icons.brush,
                    title: "Темная тема",
                  ),
                  SettingsSwitch(
                    value: mangaButtonCubit.isCardStyle,
                    onChanged: (context, value) => _changeMangaButtonStyle(
                      context,
                      value,
                    ),
                    icon: Icons.style_outlined,
                    title: "Кнопки в виде карточек",
                  ),
                  ListTile(
                    onTap: () => showMangaUpdaterBottomSheet(context),
                    contentPadding: const EdgeInsets.only(right: 13),
                    leading: const Icon(Icons.update),
                    title: const Text("Обновить всю мангу"),
                    trailing: Icon(
                      Icons.keyboard_arrow_down,
                      color: theme.primaryColor,
                      size: 32,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Spacer(),
                  const LogOutButton(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _changeMangaButtonStyle(BuildContext context, bool value) {
    BlocProvider.of<MangaButtonCubit>(context).setButtonStyle(value ? "card" : "default");
  }

  void _changeTheme(BuildContext context, bool value) {
    BlocProvider.of<ThemeCubit>(context).setTheme(value ? "dark" : "light");
  }
}
