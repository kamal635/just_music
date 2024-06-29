import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_music/core/helpers/dependencey_injection.dart';
import 'package:just_music/core/utils/app_icon.dart';
import 'package:just_music/core/shared_widgets/custom_elvated_button.dart';
import 'package:just_music/core/utils/app_strings.dart';
import 'package:just_music/features/home/logic/audio_player/audio_player_bloc.dart';
import 'package:just_music/features/home/logic/fetch_songs_from_device/fetch_songs_from_device_bloc.dart';

class SectionDoubleButton extends StatelessWidget {
  const SectionDoubleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          di<FetchSongsFromDeviceBloc>()..add(LoadSongsFromDeviceEvent()),
      child: BlocBuilder<FetchSongsFromDeviceBloc, FetchSongsFromDeviceState>(
        builder: (context, state) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomElvatedButton(
                icon: AppIcon.play,
                titleWithIcon: AppStrings.playAll,
                onPressed: () {
                  state.songModel!.isEmpty
                      ? null
                      : context.read<AudioPlayerBloc>().add(SetAudioEvent(
                          songs: state.songModel ?? [], index: 0));
                },
              ),
              CustomElvatedButton(
                icon: AppIcon.shuffle,
                titleWithIcon: AppStrings.shuffle,
                onPressed: () {},
              ),
            ],
          );
        },
      ),
    );
  }
}
