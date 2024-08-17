import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/helpers/navigation.dart';
import '../../../../../core/routes/string_route.dart';
import '../../../../../core/shared_widgets/custom_elvated_button.dart';
import '../../../../../core/constant/app_icon.dart';
import '../../../../../core/constant/app_strings.dart';
import '../../../data/model/playlist_model.dart';

class ButtonMiddleContentPlaylist extends StatelessWidget {
  const ButtonMiddleContentPlaylist({super.key, required this.playlist});
  final Playlist playlist;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomElevatedButton(
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
