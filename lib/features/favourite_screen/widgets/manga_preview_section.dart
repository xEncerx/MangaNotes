import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manga_notes/api/api.dart';
import 'package:manga_notes/cubit/cubit.dart';
import 'package:manga_notes/features/features.dart';
import 'package:manga_notes/generated/assets.dart';

class MangaTabBarView extends StatelessWidget {
  const MangaTabBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MangaListBloc, MangaListState>(
      builder: (context, state) {
        if (state is MangaListLoaded) {
          return TabBarView(
            children: [
              MangaSectionList(mangaListData: state.mangaListReadData),
              MangaSectionList(mangaListData: state.mangaListReadingData),
              MangaSectionList(mangaListData: state.mangaListPlannedData),
            ],
          );
        }
        if (state is MangaListException) {
          return ImagedNotify(
            imagePath: Assets.imagesQuestion,
            title: "Упс... Ошибочка",
            subTitle: "Проверьте подключение к интернету",
            actionWidget: OutlinedActionButton(
              label: "Обновить",
              contentPadding: const EdgeInsets.symmetric(horizontal: 20),
              onTap: () => _updateSections(context),
            ),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  void _updateSections(BuildContext context) {
    BlocProvider.of<MangaListBloc>(context).add(LoadMangaListEvent());
  }
}

class MangaSectionList extends StatelessWidget {
  final List<MangaData> mangaListData;

  const MangaSectionList({super.key, required this.mangaListData});

  @override
  Widget build(BuildContext context) {
    if (mangaListData.isNotEmpty) {
      return ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
          dragDevices: {
            PointerDeviceKind.touch,
            PointerDeviceKind.mouse,
          },
        ),
        child: BlocBuilder<MangaButtonCubit, MangaButtonState>(
          builder: (context, state) {
            return state.isCardStyle
                ? MangaCardList(mangaListData: mangaListData)
                : MangaList(mangaListData: mangaListData);
          },
        ),
      );
    } else {
      return const ImagedNotify(
        imagePath: Assets.imagesEmpty,
        title: "Список манги пустует...",
        subTitle: "Найди мангу в поисковике и добавь к себе в коллекцию!",
      );
    }
  }
}
