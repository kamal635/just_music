import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_music/core/helpers/dependencey_injection.dart';
import 'package:just_music/core/helpers/spacer.dart';
import 'package:just_music/features/home/logic/check_permission/check_permission_bloc.dart';
import 'package:just_music/features/home/widgets/grant_permission.dart';
import 'package:just_music/features/home/widgets/list_view_song_card.dart';
import 'package:just_music/features/home/widgets/section_double_button.dart';
import 'package:just_music/features/home/widgets/section_text_form_field.dart';
import 'package:just_music/features/home/widgets/sliver_appbar/body_sliver_appbar.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          di<CheckPermissionBloc>()..add(StatusPermissionEvent()),
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // Sliver AppBar
          const CustomSliverAppBar(),

          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(14.r),
              child: BlocBuilder<CheckPermissionBloc, CheckPermissionState>(
                builder: (context, state) {
                  if (state.permissionStatus == PermissionStatuss.initial) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state.permissionStatus == PermissionStatuss.denied) {
                    return const GrantPermission();
                  }

                  if (state.permissionStatus == PermissionStatuss.granted) {
                    return Column(children: [
                      //Form Field
                      const SectionTextFormField(),

                      spaceHeight(10),

                      // Double Button
                      const SectionDoubleButton(),

                      spaceHeight(10),

                      const ListViewSongCard(),

                      spaceHeight(110),
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
    );
  }
}
