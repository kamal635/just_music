import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:just_music/core/helpers/navigation.dart';
import 'package:just_music/core/helpers/spacer.dart';
import 'package:just_music/core/routes/string_route.dart';
import 'package:just_music/core/styling/colors.dart';
import 'package:just_music/core/styling/font.dart';
import 'package:just_music/features/home/data/repository/get_all_songs_repo.dart';
import 'package:just_music/features/home/logic/ger_all_songs/get_all_songs_bloc.dart';
import 'package:just_music/features/home/widgets/card_song.dart';
import 'package:on_audio_query/on_audio_query.dart';

class ListViewCardSong extends StatelessWidget {
  const ListViewCardSong({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetAllSongsBloc(
          getAllSongsRepoImpl: GetAllSongsRepoImpl(audioQuery: OnAudioQuery()))
        ..add(TriggerGetAllSongsEvent()),
      child: BlocConsumer<GetAllSongsBloc, GetAllSongsState>(
        listener: (context, state) async {
          if (state.getSongsStatus == GetSongsStatus.failure) {
            await Fluttertoast.showToast(
                msg: state.errorMessage ??
                    "Unexpected error..please try again later!",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 2,
                backgroundColor: Colors.orange,
                textColor: Colors.white,
                fontSize: 14.sp);
          }
        },
        builder: (context, state) {
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

class AnimatedErrorWidget extends StatefulWidget {
  final String errorMessage;

  const AnimatedErrorWidget(this.errorMessage, {super.key});

  @override
  State<AnimatedErrorWidget> createState() => _AnimatedErrorWidgetState();
}

class _AnimatedErrorWidgetState extends State<AnimatedErrorWidget>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 500),
  )..repeat(reverse: true);

  late final Animation<double> _scaleAnimation =
      Tween<double>(begin: 1.0, end: 0.8).animate(_controller);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Animated error icon with subtle shake effect
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) => Transform.rotate(
                angle: _scaleAnimation.value * 0.1, // Adjust rotation amount
                child: child,
              ),
              child: const Icon(Icons.error_outline,
                  size: 40.0, color: Colors.red),
            ),
            Text(
              widget.errorMessage,
              style: const TextStyle(color: Colors.red, fontSize: 16.0),
            ),
            // Optional: Add a retry button or other action (customize behavior)
            ElevatedButton(
              onPressed: () {
                // Handle retry logic or other action (e.g., navigate to help page)
                // BlocProvider.of<YourBloc>(context).add(FetchDataEvent());
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}
