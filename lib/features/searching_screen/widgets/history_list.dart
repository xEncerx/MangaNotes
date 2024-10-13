import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manga_notes/features/features.dart';
import 'package:manga_notes/generated/assets.dart';

class HistoryList extends StatelessWidget {
  final TextEditingController controller;
  final List<dynamic> historyList;
  final FocusNode focusNode;

  const HistoryList({
    super.key,
    required this.historyList,
    required this.controller,
    required this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    if (historyList.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            HistoryActions(),
            Expanded(
              child: ListView.builder(
                itemCount: historyList.length,
                itemBuilder: (context, index) => HistoryCard(
                  text: historyList[index],
                  controller: controller,
                  focusNode: focusNode,
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return ImagedNotify(
        imagePath: Assets.imagesEmpty,
        title: "История пуста!",
        subTitle: "Начинай искать мангу и здесь что-то появится",
      );
    }
  }
}

class HistoryCard extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final String text;
  const HistoryCard({
    super.key,
    required this.text,
    required this.controller,
    required this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      onTap: () => _search(context),
      contentPadding: EdgeInsets.zero,
      leading: Icon(
        Icons.access_time,
        color: theme.hintColor,
      ),
      title: Transform.translate(
        offset: const Offset(0, -2),
        child: Text(
          text,
          style: theme.textTheme.bodyMedium,
        ),
      ),
    );
  }

  void _search(BuildContext context) {
    controller.text = text;
    focusNode.unfocus();
    BlocProvider.of<SearchingHistoryBloc>(context).add(
      LoadSearchingMangaListEvent(mangaName: text),
    );
  }
}

class HistoryActions extends StatelessWidget {
  const HistoryActions({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(
            "ИСТОРИЯ ПОИСКА:",
            style: TextStyle(
              fontSize: 11,
              overflow: TextOverflow.ellipsis,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        TextButton(
          onPressed: () => _clearHistory(context),
          child: Transform.translate(
            offset: const Offset(0, -1),
            child: Text(
              "Очистить всё",
              style: theme.textTheme.titleSmall!
                  .copyWith(fontWeight: FontWeight.w500, fontSize: 13),
            ),
          ),
        ),
      ],
    );
  }

  void _clearHistory(BuildContext context) {
    BlocProvider.of<SearchingHistoryBloc>(context).add(
      ClearHistoryEvent(),
    );
  }
}
