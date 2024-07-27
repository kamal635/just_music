import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_music/core/helpers/spacer.dart';
import 'package:just_music/core/shared_widgets/icon_buttons.dart';
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
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

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

  Widget _buildLoadingScreen() {
    return Container(
      color: AppColor.primary,
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildMainScreen() {
    return Scaffold(
      floatingActionButton: const MusicTrackPlayer(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      bottomNavigationBar: _buildCustomBottomNavigationBar(),
      appBar: AppBar(
        toolbarHeight: 60.h,
        backgroundColor: AppColor.primary,
        surfaceTintColor: AppColor.primary,
        leadingWidth: 100,
        leading: Image.asset(
          AppImages.logoWhite,
        ),
        actions: [
          CustomIconButton(
              onPressed: _onSettingsPressed, icon: AppIcon.settings),
        ],
      ),
      body: _views[_currentIndex],
    );
  }

  Widget _buildCustomBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.navBottomBar,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(18.r),
          topRight: Radius.circular(18.r),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(_views.length, (index) {
            bool isSelected = _currentIndex == index;
            return InkWell(
              onTap: () => _onTabTapped(index),
              child: AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  double size =
                      isSelected ? 18.h + (5.h * _animation.value) : 18.h;
                  Color color = isSelected
                      ? AppColor.blue
                      : AppColor.white.withAlpha(110);
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        _getIconForIndex(index),
                        color: color,
                        size: size,
                      ),
                      spaceHeight(5),
                      Text(
                        _getLabelForIndex(index),
                        style: AppFonts.medium_12.copyWith(color: color),
                      ),
                    ],
                  );
                },
              ),
            );
          }),
        ),
      ),
    );
  }

  IconData _getIconForIndex(int index) {
    switch (index) {
      case 0:
        return AppIcon.home;
      case 1:
        return AppIcon.playlist;
      case 2:
        return AppIcon.favoriteFilled;
      default:
        return AppIcon.home;
    }
  }

  String _getLabelForIndex(int index) {
    switch (index) {
      case 0:
        return AppStrings.home;
      case 1:
        return AppStrings.playlist;
      case 2:
        return AppStrings.favorite;
      default:
        return AppStrings.home;
    }
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      _animationController.reset();
      _animationController.forward();
    });
  }

  void _onSettingsPressed() {
    // Handle settings button pressed
  }
}
