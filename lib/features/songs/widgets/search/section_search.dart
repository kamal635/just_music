import 'package:flutter/material.dart';
import 'package:just_music/core/helpers/navigation.dart';
import 'package:just_music/core/routes/string_route.dart';
import 'package:just_music/core/shared_widgets/custom_text_form_field.dart';
import 'package:just_music/core/shared_widgets/icon_buttons.dart';
import 'package:just_music/core/styling/app_colors.dart';
import 'package:just_music/core/utils/app_icon.dart';
import 'package:just_music/core/utils/app_strings.dart';

class SectionSearch extends StatefulWidget {
  const SectionSearch({super.key});

  @override
  State<SectionSearch> createState() => _SectionSearchState();
}

class _SectionSearchState extends State<SectionSearch> {
  bool _isFieldVisible = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 200), () {
      setState(() {
        _isFieldVisible = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TextField
    return AnimatedContainer(
      duration: const Duration(seconds: 1),
      curve: Curves.easeIn,
      transform: _isFieldVisible
          ? Matrix4.translationValues(0, 0, 0)
          : Matrix4.translationValues(0, -60, 0),
      child: CustomTextFormField(
        readOnly: true,
        onTap: () {
          // push to search view
          context.pushNamed(RouterName.listOfSongsView);
        },
        hintText: AppStrings.searchByName,

        // icon search
        prefixIcon: CustomIconButton(
          onPressed: () {
            // push to search view
            context.pushNamed(RouterName.listOfSongsView);
          },
          icon: AppIcon.search,
          color: AppColor.white.withAlpha(120),
        ),
      ),
    );
  }
}
