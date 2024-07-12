import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_music/core/shared_widgets/icon_buttons.dart';
import 'package:just_music/core/utils/app_icon.dart';
import 'package:just_music/core/utils/app_images.dart';
import 'package:just_music/core/utils/app_strings.dart';
import 'package:just_music/features/albums/album_view.dart';
import 'package:just_music/features/favorites/favorite_view.dart';
import 'package:just_music/features/folders/folders_view.dart';
import 'package:just_music/features/songs/songs_view.dart';
import 'package:just_music/features/songs/logic/check_permission/check_permission_bloc.dart';
import 'package:just_music/features/songs/widgets/grant_permission.dart';
import 'package:just_music/features/songs/widgets/music_track/music_track_player.dart';
import 'package:just_music/features/playlists/playlist_view.dart';
import 'package:just_music/core/styling/app_colors.dart';
import 'package:just_music/core/styling/app_fonts.dart';

///** This page was created to navigate between pages in the tabbar
///* while only changing the body */
class ChangedView extends StatefulWidget {
  const ChangedView({super.key});

  @override
  State<ChangedView> createState() => _ChangedViewState();
}

class _ChangedViewState extends State<ChangedView>
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

  ///* List of views in the tabbar
  final List<Widget> _views = [
    const SongsView(),
    const AlbumView(),
    const PlayListView(),
    const FoldersView(),
    const FavoriteView(),
  ];

  ///* initial index always on home_view in list of views
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckPermissionBloc, CheckPermissionState>(
      builder: (context, state) {
        if (state.permissionStatus == PermissionStatuss.loading) {
          return Container(
              color: AppColor.primary,
              child: const Center(child: CircularProgressIndicator()));
        }
        if (state.permissionStatus == PermissionStatuss.denied) {
          return const GrantPermission();
        }
        if (state.permissionStatus == PermissionStatuss.granted) {
          return DefaultTabController(
            length: TabBarModel.tabBarList.length,
            child: Scaffold(
              floatingActionButton: const MusicTrackPlayer(),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              appBar: AppBar(
                backgroundColor: AppColor.primary,
                surfaceTintColor: AppColor.primary,

                //* Leading
                leading: Image.asset(
                  AppImages.logoWhite,
                ),
                leadingWidth: 80.w,

                //* Action
                actions: [
                  CustomIconButton(onPressed: () {}, icon: AppIcon.settings),
                ],

                bottom: TabBar(
                    onTap: (i) {
                      setState(() {
                        index = i;
                      });
                    },
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
                    ]),
              ),
              // Sliver AppBar
              body: _views[index],
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
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
    TabBarModel(title: AppStrings.favorites),
  ];
}
