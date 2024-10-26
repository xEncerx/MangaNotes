import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manga_notes/cubit/cubit.dart';
import 'package:manga_notes/features/features.dart';
import 'package:manga_notes/generated/assets.dart';

@RoutePage()
class SearchingScreen extends StatefulWidget {
  const SearchingScreen({super.key});

  @override
  State<SearchingScreen> createState() => _SearchingScreenState();
}

class _SearchingScreenState extends State<SearchingScreen> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void initState() {
    BlocProvider.of<SearchingHistoryBloc>(context).add(
      LoadSearchingHistoryEvent(),
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SwipeableContent(
      child: Scaffold(
        appBar: SearchingAppBar(
          controller: _controller,
          focusNode: _focusNode,
        ),
        body: BlocBuilder<SearchingHistoryBloc, SearchingHistoryState>(
          builder: (context, state) {
            if (state is SearchingException) {
              return const ImagedNotify(
                imagePath: Assets.imagesQuestion,
                title: "Упс... Ошибочка",
                subTitle: "Проверьте подключение к интернету",
              );
            }
            if (state is SearchingHistoryLoaded) {
              return HistoryList(
                historyList: state.historyList,
                controller: _controller,
                focusNode: _focusNode,
              );
            }
            if (state is SearchingMangaListLoaded) {
              if (state.mangaListData.isEmpty) {
                return const ImagedNotify(
                  imagePath: Assets.imagesQuestion,
                  title: "Хмм, ничего не найдено...",
                  subTitle:
                      "Попробуй написать иначе, чтобы я смогла тебя понять ;)",
                );
              }

              final mangaListData = state.mangaListData;
              return BlocBuilder<MangaButtonCubit, MangaButtonState>(
                builder: (context, state) {
                  return state.isCardStyle
                      ? MangaCardList(mangaListData: mangaListData)
                      : MangaList(mangaListData: mangaListData);
                },
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
