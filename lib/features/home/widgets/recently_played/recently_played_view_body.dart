import 'package:just_music/core/shared_widgets/custom_songs_view.dart';
import 'package:just_music/core/utils/app_strings.dart';
import 'package:just_music/features/songs/data/model/song.dart';

class RecentlyPlayedViewBody extends CustomSongsView {
  const RecentlyPlayedViewBody({
    super.key,
    required List<Song> songs,
  }) : super(
          songs: songs,
          title: AppStrings.recentlyPlayed,
          subTitle: AppStrings.recentlyPlayedSongs,
        );
}
