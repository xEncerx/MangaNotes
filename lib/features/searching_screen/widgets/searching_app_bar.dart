import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manga_notes/features/features.dart';
import 'package:manga_notes/repositories/repositories.dart';

class SearchingAppBar extends StatefulWidget implements PreferredSizeWidget {
  final TextEditingController controller;

  const SearchingAppBar({super.key, required this.controller});

  @override
  State<SearchingAppBar> createState() => _SearchingAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _SearchingAppBarState extends State<SearchingAppBar> {
  final _focusNode = FocusNode();
  final _historyRepository = HistoryRepository();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppBar(
      automaticallyImplyLeading: false,
      surfaceTintColor: theme.scaffoldBackgroundColor,
      title: TextField(
        controller: widget.controller,
        autofocus: true,
        focusNode: _focusNode,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(top: 12),
          hintStyle: theme.textTheme.titleSmall,
          hintText: "Поиск манги...",
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: theme.primaryColor),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: theme.primaryColor),
          ),
          prefixIcon: IconButton(
            onPressed: () => _close(),
            icon: Icon(
              Icons.arrow_back,
              color: theme.hintColor,
            ),
          ),
          suffixIcon: IconButton(
            onPressed: () => _search(),
            icon: Icon(
              Icons.search,
              color: theme.hintColor,
            ),
          ),
        ),
      ),
    );
  }

  void _close() => AutoRouter.of(context).maybePop();

  Future<void> _search() async {
    final mangaName = widget.controller.text;
    if (mangaName.isEmpty) return;
    await _historyRepository.addValue(mangaName);
    _focusNode.unfocus();
    if (mounted) {
      BlocProvider.of<SearchingHistoryBloc>(context).add(
        LoadSearchingHistoryEvent(),
      );
      BlocProvider.of<SearchingHistoryBloc>(context).add(
        LoadSearchingMangaListEvent(mangaName: mangaName),
      );
    }
  }
}
