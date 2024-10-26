import 'dart:async';
import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manga_notes/api/api.dart';
import 'package:manga_notes/features/features.dart';
import 'package:manga_notes/ui/const.dart';

@RoutePage()
class MangaInfoScreen extends StatefulWidget {
  final MangaData mangaData;

  const MangaInfoScreen({super.key, required this.mangaData});

  @override
  State<MangaInfoScreen> createState() => _MangaInfoScreenState();
}

class _MangaInfoScreenState extends State<MangaInfoScreen> {
  final _bloc = MangaInfoBloc();

  @override
  Widget build(BuildContext context) {
    return SwipeableContent(
      child: Scaffold(
        appBar: MangaInfoAppBar(mangaData: widget.mangaData),
        body: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(
            dragDevices: {
              PointerDeviceKind.touch,
              PointerDeviceKind.trackpad,
              PointerDeviceKind.mouse,
            },
          ),
          child: RefreshIndicator(
            onRefresh: () => _updateMangaData(context),
            child: BlocConsumer<MangaInfoBloc, MangaInfoState>(
              bloc: _bloc,
              listener: (context, state) {
                if (state is MangaInfoException) {
                  showInfoSnackBar(
                    context: context,
                    text: "Не удалось обновить данные о манге",
                  );
                }
              },
              builder: (context, state) {
                if (state is MangaInfoLoaded) {
                  if (state.mangaData.section !=
                      MangaNotesConst.notReadSection) {
                    BlocProvider.of<MangaListBloc>(context).add(
                      LoadMangaListEvent(),
                    );
                  }
                  return TitleInfo(mangaData: state.mangaData);
                }
                if (state is MangaInfoInitial) {
                  return TitleInfo(mangaData: widget.mangaData);
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _updateMangaData(BuildContext context) async {
    final completer = Completer();
    _bloc.add(
      UpdateMangaInfoEvent(mangaData: widget.mangaData, completer: completer),
    );
    return completer.future;
  }
}
