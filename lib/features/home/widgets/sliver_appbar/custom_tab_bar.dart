import 'package:flutter/material.dart';
import 'package:just_music/core/styling/colors.dart';
import 'package:just_music/core/styling/font.dart';

class CustomTabBar extends StatefulWidget {
  const CustomTabBar({super.key});

  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController =
        TabController(length: TabBarModel.tabBarList.length, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TabBar(
        physics: const BouncingScrollPhysics(),
        isScrollable: true,
        controller: _tabController,
        indicatorColor: AppColor.orange,
        labelColor: AppColor.orange,
        tabAlignment: TabAlignment.start,
        labelStyle: AppFonts.normal_14,
        tabs: [
          ...List.generate(TabBarModel.tabBarList.length, (index) {
            final titleTabBar = TabBarModel.tabBarList[index];
            return Tab(
              text: titleTabBar.title,
            );
          })
        ]);
  }
}

class TabBarModel {
  final String title;
  TabBarModel({required this.title});

  static List<TabBarModel> tabBarList = [
    TabBarModel(title: "Songs"),
    TabBarModel(title: "Albums"),
    TabBarModel(title: "Playlists"),
    TabBarModel(title: "Folders"),
    TabBarModel(title: "Favorits"),
  ];
}
