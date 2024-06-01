import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_music/core/functions/flutter_toast.dart';
import 'package:just_music/core/helpers/dependencey_injection.dart';
import 'package:just_music/core/helpers/navigation.dart';
import 'package:just_music/core/helpers/spacer.dart';
import 'package:just_music/core/routes/string_route.dart';
import 'package:just_music/core/styling/colors.dart';
import 'package:just_music/core/styling/font.dart';
import 'package:just_music/features/home/logic/get_songs_from_device/get_songs_from_device_bloc.dart';
import 'package:just_music/features/home/widgets/card_song.dart';

class ListViewCardSong extends StatelessWidget {
  const ListViewCardSong({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          di<GetSongsFromDevice>()..add(TriggerGetSongsFromDeviceEvent()),
      child: BlocConsumer<GetSongsFromDevice, GetSongsFromDeviceState>(
        listener: (context, state) async {
          if (state.getSongsStatus == GetSongsStatus.failure) {
            await flutterToast(
                message: state.errorMessage ??
                    "Unexpected error..please try again later!");
          }
        },
        builder: (context, state) {
          // when list of songs is Empty
          if (state.songModel?.isEmpty ?? true) {
            return Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/music.png",
                    height: 60.h,
                  ),
                  spaceHeight(10),
                  Text(
                    "No items here yet.",
                    style: AppFonts.normal_12
                        .copyWith(color: AppColor.white.withAlpha(160)),
                  ),
                ],
              ),
            );
          }

          if (state.getSongsStatus == GetSongsStatus.loading) {
            return const CircularProgressIndicator();
          }

          if (state.getSongsStatus == GetSongsStatus.loaded) {
            return ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: state.songModel!.length,
                itemBuilder: (context, i) {
                  return InkWell(
                      onTap: () {
                        context.pushNamed(RouterName.detailsSongView);
                      },
                      child: CardSong(songModel: state.songModel![i]));
                });
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
