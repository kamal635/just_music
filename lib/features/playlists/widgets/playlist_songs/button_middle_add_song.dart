import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_music/core/helpers/navigation.dart';
import 'package:just_music/core/routes/string_route.dart';
import 'package:just_music/core/shared_widgets/custom_elvated_button.dart';
import 'package:just_music/core/utils/app_icon.dart';
import 'package:just_music/core/utils/app_strings.dart';
import 'package:just_music/features/playlists/data/model/playlist_model.dart';

class ButtonMiddleAddSong extends StatelessWidget {
  const ButtonMiddleAddSong({super.key, required this.playlist});
  final Playlist playlist;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomElvatedButton(
          widthButton: 140.w,
          onPressed: () async {
            context.pushNamed(RouterName.addSongsToPlayListsBody,
                arguments: {"playlist": playlist});
          },
          titleWithIcon: AppStrings.addSongs,
          icon: AppIcon.add,
          isIcon: true,
        ),
      ],
    );
  }
}
