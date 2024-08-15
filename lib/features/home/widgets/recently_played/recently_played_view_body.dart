import '../../../../core/shared_widgets/custom_songs_view.dart';
import '../../../../core/constant/app_strings.dart';
import '../../../songs/data/model/song.dart';

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
