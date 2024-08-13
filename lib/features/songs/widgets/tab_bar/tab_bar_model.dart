import 'package:just_music/core/utils/app_strings.dart';

class TabBarSongsModel {
  final String name;

  TabBarSongsModel({required this.name});

  static List<TabBarSongsModel> listTabBar = [
    TabBarSongsModel(name: AppStrings.songs),
    TabBarSongsModel(name: AppStrings.artists),
    TabBarSongsModel(name: AppStrings.albums),
  ];
}
