import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_music/core/helpers/spacer.dart';
import 'package:just_music/features/home/widgets/most_played/body_most_played.dart';
import 'package:just_music/features/home/widgets/recently_played/body_recently_played.dart';
import 'package:just_music/features/home/widgets/shuffle_and_favorite/body_shuffle_and_favorite.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 14.w),
      child: CustomScrollView(
        slivers: [
          sliverPadding(10),

          //  Shuffle And Favorite
          const BodyShuffleAndFavoriteHomeView(),

          sliverPadding(30),

          // Recently Played
          const RecentlyPlayed(),

          sliverPadding(30),

          // Most Played
          const MostPlayed(),
        ],
      ),
    );
  }
}
