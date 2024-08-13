import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_music/core/helpers/spacer.dart';
import 'package:just_music/core/shared_widgets/custom_icon_buttons.dart';
import 'package:just_music/core/shared_widgets/custom_loading.dart';
import 'package:just_music/core/utils/app_icon.dart';
import 'package:just_music/core/utils/app_strings.dart';
import 'package:just_music/features/changed_view/logic/nav_bottom_bar/nav_bottom_bar_bloc.dart';
import 'package:just_music/features/home/home_view.dart';
import 'package:just_music/features/songs/logic/check_permission/check_permission_bloc.dart';
import 'package:just_music/features/songs/widgets/tab_bar/tab_bar_songs.dart';
import 'package:just_music/features/songs/widgets/grant_permission.dart';
import 'package:just_music/features/songs/widgets/music_track/music_track_player.dart';
import 'package:just_music/features/playlists/playlist_view.dart';
import 'package:just_music/core/styling/app_colors.dart';
import 'package:just_music/features/changed_view/widgets/search/section_search.dart';

///** This page was created to navigate between pages in the bottomNavigationBar
///* while only changing the body */
class ChangedView extends StatefulWidget {
  const ChangedView({super.key});

  @override
  State<ChangedView> createState() => _ChangedViewState();
}

class _ChangedViewState extends State<ChangedView>
    with SingleTickerProviderStateMixin {
  final List<Widget> _views = [
    const HomeView(),
    const TabBarSongsView(),
    const PlayListView(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckPermissionBloc, CheckPermissionState>(
      builder: (context, state) {
        if (state.permissionStatus == PermissionStatuss.loading) {
          return _buildLoadingScreen();
        }
        if (state.permissionStatus == PermissionStatuss.denied) {
          return const GrantPermission();
        }
        if (state.permissionStatus == PermissionStatuss.granted) {
          return _buildMainScreen();
        } else {
          return const SizedBox();
        }
      },
    );
  }

  //***** Loading */
  Widget _buildLoadingScreen() {
    return Container(
      color: AppColor.primary,
      child: const CustomLoading(),
    );
  }

  //***** Body changed view */
  Widget _buildMainScreen() {
    return BlocBuilder<NavBottomBarBloc, NavBottomBarState>(
      builder: (context, state) {
        return Scaffold(
          floatingActionButton: const MusicTrackPlayer(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          bottomNavigationBar: _buildCustomBottomNavigationBar(),
          appBar: AppBar(
            title: const SectionSearch(), // Search box

            toolbarHeight: 60.h,
            backgroundColor: AppColor.primary,
            surfaceTintColor: AppColor.primary,

            actions: [
              CustomIconButton(
                  onPressed: _onSettingsPressed, icon: AppIcon.settings),
            ],
          ),
          body: _views[state.currentPage],
        );
      },
    );
  }

  //***** Bottom Nav Bar */
  Widget _buildCustomBottomNavigationBar() {
    return BlocBuilder<NavBottomBarBloc, NavBottomBarState>(
      builder: (context, state) {
        return Container(
          height: 50.h,
          decoration: BoxDecoration(
            color: AppColor.navBottomBar,
            boxShadow: [
              BoxShadow(
                color: AppColor.black.withOpacity(0.1),
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
            border: const Border(bottom: BorderSide(width: 0.3)),
          ),
          child: Material(
            color: Colors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(
                _views.length,
                (index) {
                  bool isSelected = state.currentPage == index;
                  Color color = isSelected
                      ? AppColor.lightBlue
                      : AppColor.white.withAlpha(110);
                  return InkResponse(
                    onTap: () {
                      context
                          .read<NavBottomBarBloc>()
                          .add(ChangedCurrentPageEvent(index: index));
                    },
                    splashFactory: InkRipple.splashFactory,
                    radius: 60,
                    splashColor: AppColor.white.withAlpha(40),
                    highlightColor: Colors.transparent,
                    child: Container(
                        height: double.infinity,
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              _getIconForIndex(index, isSelected),
                              color: color,
                              size: 18,
                            ),
                            spaceHeight(2),
                            Text(
                              _getLabelForIndex(index),
                              style: TextStyle(color: color),
                            ),
                          ],
                        )),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  //***** Icons */
  IconData _getIconForIndex(int index, bool isSelected) {
    switch (index) {
      case 0:
        return AppIcon.home;
      case 1:
        return AppIcon.disc;
      case 2:
        return isSelected ? AppIcon.playlistFilled : AppIcon.playlist;
      default:
        return AppIcon.home;
    }
  }

  //**** Label Icon Nav bar */
  String _getLabelForIndex(int index) {
    switch (index) {
      case 0:
        return AppStrings.home;
      case 1:
        return AppStrings.songs;
      case 2:
        return AppStrings.playlist;
      default:
        return AppStrings.home;
    }
  }

  //*** Icon Settings in appbar */
  void _onSettingsPressed() {
    // Handle settings button pressed
  }
}
