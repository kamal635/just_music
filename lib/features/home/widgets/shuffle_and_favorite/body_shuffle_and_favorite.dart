import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/helpers/navigation.dart';
import '../../../../core/helpers/spacer.dart';
import '../../../../core/routes/string_route.dart';
import 'custom_card_shuffle_and_favorite_home_view.dart';
import '../../../songs/logic/audio_player/audio_player_bloc.dart';
import '../../../songs/logic/fetch_songs_from_device/fetch_songs_from_device_bloc.dart';

class BodyShuffleAndFavoriteHomeView extends StatelessWidget {
  const BodyShuffleAndFavoriteHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.only(right: 14.w),
        child: Row(
          children: [
            //* Favorite
            CustomCardShuffleAndFavoriteHomeView(
              isFavorite: true,
              onTap: () {
                context.pushNamed(RouterName.favoriteView);
              },
            ),

            spaceWidth(10),

            //* Shuffle
            BlocBuilder<FetchSongsFromDeviceBloc, FetchSongsFromDeviceState>(
              builder: (context, state) {
                return CustomCardShuffleAndFavoriteHomeView(
                  isFavorite: false,
                  onTap: () {
                    context
                        .read<AudioPlayerBloc>()
                        .add(SetAudioEvent(songs: state.songs, index: 0));

                    context.read<AudioPlayerBloc>().add(
                        const ShuffleModeAudioEvent(
                            shuffleMode: AudioServiceShuffleMode.all));
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
