import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_music/core/helpers/spacer.dart';
import 'package:just_music/core/shared_widgets/background_linear.dart';
import 'package:just_music/features/home/widgets/list_view_card_song.dart';
import 'package:just_music/features/home/widgets/section_double_button.dart';
import 'package:just_music/features/home/widgets/section_text_form_field.dart';
import 'package:just_music/features/home/widgets/sliver_appbar/body_sliver_appbar.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BackgroundLinearGradiant(
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // Sliver AppBar
          const CustomSliverAppBar(),

          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(14.r),
              child: Column(children: [
                //Form Field
                const SectionTextFormField(),

                spaceHeight(10),

                // Double Button
                const SectionDoubleButton(),

                const ListViewCardSong(),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
