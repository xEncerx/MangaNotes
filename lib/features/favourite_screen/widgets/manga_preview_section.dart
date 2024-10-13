import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manga_notes/api/api.dart';
import 'package:manga_notes/features/features.dart';
import 'package:manga_notes/generated/assets.dart';

void _updateSections(BuildContext context) {
  BlocProvider.of<MangaListBloc>(context).add(LoadMangaListEvent());
}

class MangaReadSection extends StatelessWidget {
  const MangaReadSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MangaListBloc, MangaListState>(
      builder: (context, state) {
        if (state is MangaListLoaded) {
          return MangaSectionList(mangaListData: state.mangaListReadData);
        }
        if (state is MangaListException) {
          return ImagedNotify(
            imagePath: Assets.imagesQuestion,
            title: "Упс... Ошибочка",
            subTitle: "Проверьте подключение к интернету",
            actionWidget: OutlinedActionButton(
              label: "Обновить",
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              onTap: () => _updateSections(context),
            ),
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}

class MangaReadingSection extends StatelessWidget {
  const MangaReadingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MangaListBloc, MangaListState>(
      builder: (context, state) {
        if (state is MangaListLoaded) {
          return MangaSectionList(mangaListData: state.mangaListReadingData);
        }
        if (state is MangaListException) {
          return ImagedNotify(
            imagePath: Assets.imagesQuestion,
            title: "Упс... Ошибочка",
            subTitle: "Проверьте подключение к интернету",
            actionWidget: OutlinedActionButton(
              label: "Обновить",
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              onTap: () => _updateSections(context),
            ),
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}

class MangaPlannedSection extends StatelessWidget {
  const MangaPlannedSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MangaListBloc, MangaListState>(
      builder: (context, state) {
        if (state is MangaListLoaded) {
          return MangaSectionList(mangaListData: state.mangaListPlannedData);
        }
        if (state is MangaListException) {
          return ImagedNotify(
            imagePath: Assets.imagesQuestion,
            title: "Упс... Ошибочка",
            subTitle: "Проверьте подключение к интернету",
            actionWidget: OutlinedActionButton(
              label: "Обновить",
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              onTap: () => _updateSections(context),
            ),
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
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
        child: ListView.separated(
          itemCount: mangaListData.length,
          itemBuilder: (context, index) => MangaPreviewButton(
            mangaData: mangaListData[index],
          ),
          separatorBuilder: (context, _) => const SizedBox(height: 5),
        ),
      );
    } else {
      return ImagedNotify(
        imagePath: Assets.imagesEmpty,
        title: "Список манги пустует...",
        subTitle: "Найди мангу в поисковике и добавь к себе в коллекцию!",
      );
    }
  }
}
