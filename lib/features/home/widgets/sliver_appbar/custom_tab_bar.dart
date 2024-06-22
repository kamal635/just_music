import 'package:flutter/material.dart';
import 'package:just_music/core/styling/app_colors.dart';
import 'package:just_music/core/styling/app_fonts.dart';
import 'package:just_music/core/utils/app_strings.dart';

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
        indicatorColor: AppColor.white,
        labelColor: AppColor.white,
        unselectedLabelColor: AppColor.white.withAlpha(120),
        tabAlignment: TabAlignment.start,
        labelStyle: AppFonts.normal_12,
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
    TabBarModel(title: AppStrings.songs),
    TabBarModel(title: AppStrings.albums),
    TabBarModel(title: AppStrings.playlists),
    TabBarModel(title: AppStrings.folders),
    TabBarModel(title: AppStrings.favorits),
  ];
}
