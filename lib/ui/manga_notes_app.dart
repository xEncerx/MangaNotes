import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manga_notes/cubit/theme/theme_cubit.dart';
import 'package:manga_notes/router/router.dart';

import '../features/features.dart';
import 'theme/theme.dart';

class MangaNotesApp extends StatefulWidget {
  const MangaNotesApp({super.key});

  @override
  State<MangaNotesApp> createState() => _MangaNotesAppState();
}

class _MangaNotesAppState extends State<MangaNotesApp> {
  final _router = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => MangaListBloc()),
        BlocProvider(create: (context) => AuthBloc()),
        BlocProvider(create: (context) => SearchingHistoryBloc()),
        BlocProvider(create: (context) => ThemeCubit()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return MaterialApp.router(
            title: "MangaNotes",
            debugShowCheckedModeBanner: false,
            theme: state.theme == "dark" ? darkTheme : lightTheme,
            routerConfig: _router.config(),
          );
        },
      ),
    );
  }
}
