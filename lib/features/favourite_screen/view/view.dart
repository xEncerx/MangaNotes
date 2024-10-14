import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manga_notes/features/features.dart';
import 'package:manga_notes/ui/const.dart';

final mangaTabBar = TabBar(
  isScrollable: true,
  indicatorSize: TabBarIndicatorSize.tab,
  dividerColor: Colors.transparent,
  indicator: UnderlineTabIndicator(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(color: Color(0xFFF4AA7E), width: 3),
  ),
  tabAlignment: TabAlignment.center,
  splashBorderRadius: BorderRadius.circular(5),
  tabs: [
    const Tab(
      text: MangaNotesConst.readSection,
    ),
    const Tab(
      text: MangaNotesConst.readingSection,
    ),
    const Tab(
      text: MangaNotesConst.plannedSection,
    ),
  ],
);

@RoutePage()
class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  void initState() {
    BlocProvider.of<MangaListBloc>(context).add(LoadMangaListEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 1,
      child: Scaffold(
        appBar: SearchingAppBarButton(
          tabBar: mangaTabBar,
          barHeight: 50,
        ),
        body: const MangaTabBarView(),
      ),
    );
  }
}
