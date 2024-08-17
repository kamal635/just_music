import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/styling/app_colors.dart';
import '../../../../core/styling/app_fonts.dart';
import '../../../albums/albums_view.dart';
import '../../../artists/artists_view.dart';
import '../../songs_view.dart';
import 'tab_bar_model.dart';

class TabBarSongsView extends StatefulWidget {
  const TabBarSongsView({super.key});

  @override
  State<TabBarSongsView> createState() => _TabBarSongsViewState();
}

class _TabBarSongsViewState extends State<TabBarSongsView>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late PageController _pageController;

  final List<Widget> _views = [
    const SongsView(),
    const ArtistsView(),
    const AlbumsView(),
  ];

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: TabBarSongsModel.listTabBar.length, vsync: this);
    _pageController = PageController();

    // Synchronize TabBar with PageView
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        _pageController.animateToPage(
          _tabController.index,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TabBar(
        // controller
        controller: _tabController,

        // properties color :
        labelColor: AppColor.white,
        indicatorColor: AppColor.lightBlue,
        unselectedLabelColor: AppColor.white.withAlpha(110),

        // font label
        labelStyle: AppFonts.bold_18,
        unselectedLabelStyle: AppFonts.medium_12,

        // Radius flashing when onTap
        splashBorderRadius: BorderRadius.circular(12.r),

        // List Tab
        tabs: List.generate(
          _tabController.length,
          (index) {
            return Tab(
              text: TabBarSongsModel.listTabBar[index].name,
            );
          },
        ),
      ),
      body: PageView.builder(
        itemCount: _tabController.length,
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _tabController.index = index;
          });
        },
        itemBuilder: (context, index) {
          return _views[index];
        },
      ),
    );
  }
}
