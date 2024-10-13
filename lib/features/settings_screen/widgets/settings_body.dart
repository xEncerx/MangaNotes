import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:manga_notes/cubit/theme/theme_cubit.dart';
import 'package:manga_notes/features/features.dart';
import 'package:manga_notes/repositories/repositories.dart';
import 'package:manga_notes/router/router.dart';
import 'package:manga_notes/ui/const.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsBody extends StatelessWidget {
  const SettingsBody({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cubitTheme = BlocProvider.of<ThemeCubit>(context).state;

    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20),
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
                  Row(
                    children: [
                      _UrlOutlinedButton(
                        icon: SvgPicture.asset(
                          "assets/icons/github.svg",
                          colorFilter: ColorFilter.mode(
                            theme.primaryColor,
                            BlendMode.srcIn,
                          ),
                        ),
                        url: MangaNotesConst.projectGitHub,
                      ),
                      const SizedBox(width: 10),
                      _UrlOutlinedButton(
                        icon: SvgPicture.asset(
                          "assets/icons/telegram.svg",
                          colorFilter: ColorFilter.mode(
                            theme.primaryColor,
                            BlendMode.srcIn,
                          ),
                        ),
                        url: MangaNotesConst.developerTG,
                      ),
                    ],
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(Icons.brush),
                    title: Text("Темная тема"),
                    trailing: Switch(
                      value: cubitTheme.isDark ? true : false,
                      onChanged: (value) => _changeTheme(context, value),
                    ),
                  ),
                  ImagedNotify(
                    imagePath: "assets/images/sign_up.png",
                    title: "Тут могла бы быть ваша реклама",
                    subTitle: "Но пока тут я :З",
                  ),
                  const SizedBox(height: 20),
                  const Spacer(),
                  const _LogOutButton(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _changeTheme(BuildContext context, bool value) {
    BlocProvider.of<ThemeCubit>(context).setTheme(value ? "dark" : "light");
  }
}

class _UrlOutlinedButton extends StatelessWidget {
  final Widget icon;
  final String? url;

  const _UrlOutlinedButton({required this.icon, this.url});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      height: 35,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: Theme.of(context).hintColor.withOpacity(0.6)),
        ),
        onPressed: () => _openUrl(),
        child: icon,
      ),
    );
  }

  Future<void> _openUrl() async {
    final uri = Uri.parse(url ?? "");
    if (await canLaunchUrl(uri)) {
      // TODO: launch url in system browser
      await launchUrl(uri);
    }
  }
}

class _LogOutButton extends StatelessWidget {
  const _LogOutButton();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            backgroundColor: theme.hintColor.withOpacity(0.3),
            overlayColor: theme.hintColor,
          ),
          onPressed: () => _logOut(context),
          child: Text("Выйти из аккаунта", style: theme.textTheme.titleMedium),
        ),
      ),
    );
  }

  Future<void> _logOut(BuildContext context) async {
    await GetIt.I<DataBase>().logOut();
    if (context.mounted) {
      BlocProvider.of<MangaListBloc>(context).add(ResetMangaListEvent());
      AutoRouter.of(context).replace(AuthRoute());
    }
  }
}
