import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_music/core/functions/flutter_toast.dart';
import 'package:just_music/core/helpers/dependencey_injection.dart';
import 'package:just_music/core/shared_widgets/image_empty_list.dart';
import 'package:just_music/core/shared_widgets/list_view_songs.dart';
import 'package:just_music/core/utils/app_images.dart';
import 'package:just_music/core/utils/app_strings.dart';
import 'package:just_music/features/home/logic/fetch_songs_from_device/fetch_songs_from_device_bloc.dart';

class ListViewSongCard extends StatelessWidget {
  const ListViewSongCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          di<FetchSongsFromDeviceBloc>()..add(LoadSongsFromDeviceEvent()),
      child: BlocConsumer<FetchSongsFromDeviceBloc, FetchSongsFromDeviceState>(
        listener: (context, state) async {
          if (state.fetchSongsStatus == FetchSongsStatus.failure) {
            await flutterToast(
                message: state.errorMessage ?? AppStrings.unexpectedError);
          }
        },
        builder: (context, state) {
          final songs = state.songs;

          if (state.fetchSongsStatus == FetchSongsStatus.loading ||
              state.fetchSongsStatus == FetchSongsStatus.initial) {
            return SizedBox(
                height: MediaQuery.of(context).size.height / 1.8,
                child: const Center(child: CircularProgressIndicator()));
          }

          if (state.fetchSongsStatus == FetchSongsStatus.loaded) {
            //* when list of songs is Empty
            if (songs == null || songs.isEmpty) {
              return const ImageEmptyList(image: AppImages.image2);
            }
            return ListViewBuilderSongs(songs: songs);
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
