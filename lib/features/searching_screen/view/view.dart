import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    return Scaffold(
      appBar: SearchingAppBar(
        controller: _controller,
        focusNode: _focusNode,
      ),
      body: BlocBuilder<SearchingHistoryBloc, SearchingHistoryState>(
        builder: (context, state) {
          if (state is SearchingException) {
            return ImagedNotify(
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
              return ImagedNotify(
                imagePath: Assets.imagesQuestion,
                title: "Хмм, ничего не найдено...",
                subTitle:
                    "Попробуй написать иначе, чтобы я смогла тебя понять ;)",
              );
            }

            return ListView.separated(
              itemCount: state.mangaListData.length,
              itemBuilder: (context, index) => MangaPreviewButton(
                mangaData: state.mangaListData[index],
              ),
              separatorBuilder: (context, _) => const SizedBox(height: 5),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
