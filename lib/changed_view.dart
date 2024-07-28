import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_music/core/helpers/spacer.dart';
import 'package:just_music/core/shared_widgets/custom_icon_buttons.dart';
import 'package:just_music/core/shared_widgets/custom_loading.dart';
import 'package:just_music/core/styling/app_fonts.dart';
import 'package:just_music/core/utils/app_icon.dart';
import 'package:just_music/core/utils/app_images.dart';
import 'package:just_music/core/utils/app_strings.dart';
import 'package:just_music/features/favorites/favorite_view.dart';
import 'package:just_music/features/songs/songs_view.dart';
import 'package:just_music/features/songs/logic/check_permission/check_permission_bloc.dart';
import 'package:just_music/features/songs/widgets/grant_permission.dart';
import 'package:just_music/features/songs/widgets/music_track/music_track_player.dart';
import 'package:just_music/features/playlists/playlist_view.dart';
import 'package:just_music/core/styling/app_colors.dart';

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
    const SongsView(),
    const PlayListView(),
    const FavoriteView(),
  ];

  int _currentIndex = 0;

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
    return Scaffold(
      floatingActionButton: const MusicTrackPlayer(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      bottomNavigationBar: _buildCustomBottomNavigationBar(),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          _getTitleAppbarForIndex(_currentIndex),
          style: AppFonts.bold_18,
        ),
        toolbarHeight: 60.h,
        backgroundColor: AppColor.primary,
        surfaceTintColor: AppColor.primary,
        leadingWidth: 100,
        leading: Image.asset(
          AppImages.mainLogo,
        ),
        actions: [
          CustomIconButton(
              onPressed: _onSettingsPressed, icon: AppIcon.settings),
        ],
      ),
      body: _views[_currentIndex],
    );
  }

  //***** Bottom Nav Bar */
  Widget _buildCustomBottomNavigationBar() {
    return Container(
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
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 6.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(_views.length, (index) {
            bool isSelected = _currentIndex == index;
            Color color =
                isSelected ? AppColor.lightBlue : AppColor.white.withAlpha(110);
            return InkWell(
                onTap: () => _onTabTapped(index),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      _getIconForIndex(index, isSelected),
                      color: color,
                      size: 18.h,
                    ),
                    spaceHeight(2),
                    Text(
                      _getLabelForIndex(index),
                      style: AppFonts.normal_10.copyWith(color: color),
                    ),
                  ],
                ));
          }),
        ),
      ),
    );
  }

  //***** Icons */
  IconData _getIconForIndex(int index, bool isSelected) {
    switch (index) {
      case 0:
        return AppIcon.disc;
      case 1:
        return isSelected ? AppIcon.playlistFilled : AppIcon.playlist;
      case 2:
        return isSelected ? AppIcon.favoriteFilled : AppIcon.favoriteBorder;
      default:
        return AppIcon.disc;
    }
  }

  //**** Label Icon Nav bar */
  String _getLabelForIndex(int index) {
    switch (index) {
      case 0:
        return AppStrings.songs;
      case 1:
        return AppStrings.playlist;
      case 2:
        return AppStrings.favorite;
      default:
        return AppStrings.songs;
    }
  }

  //**** Title Appbar */
  String _getTitleAppbarForIndex(int index) {
    switch (index) {
      case 0:
        return AppStrings.songs;
      case 1:
        return AppStrings.playlist;
      case 2:
        return AppStrings.favorite;
      default:
        return AppStrings.songs;
    }
  }

  //**** on tapped nav bar */
  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  //*** Icon Settings in appbar */
  void _onSettingsPressed() {
    // Handle settings button pressed
  }
}
