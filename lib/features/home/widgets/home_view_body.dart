import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_music/core/helpers/spacer.dart';
import 'package:just_music/core/shared_widgets/background_linear.dart';
import 'package:just_music/features/home/logic/check_permission/check_permission_bloc.dart';
import 'package:just_music/features/home/widgets/grant_permission.dart';
import 'package:just_music/features/home/widgets/list_view_card_song.dart';
import 'package:just_music/features/home/widgets/section_double_button.dart';
import 'package:just_music/features/home/widgets/section_text_form_field.dart';
import 'package:just_music/features/home/widgets/sliver_appbar/body_sliver_appbar.dart';
import 'package:on_audio_query/on_audio_query.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BackgroundLinearGradiant(
      child: BlocProvider(
        create: (context) => CheckPermissionBloc(onAudioQuery: OnAudioQuery())
          ..add(TappedPermissionEvent()),
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // Sliver AppBar
            const CustomSliverAppBar(),

            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: EdgeInsets.all(14.r),
                child: BlocBuilder<CheckPermissionBloc, CheckPermissionState>(
                  builder: (context, state) {
                    if (state.permissionStatus == PermissionStatus.denied) {
                      return const GrantPermission();
                    }

                    if (state.permissionStatus == PermissionStatus.granted) {
                      return Column(children: [
                        //Form Field
                        const SectionTextFormField(),

                        spaceHeight(10),

                        // Double Button
                        const SectionDoubleButton(),

                        const ListViewCardSong(),
                      ]);
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
