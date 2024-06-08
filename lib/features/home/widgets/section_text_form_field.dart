import 'package:flutter/material.dart';
import 'package:just_music/core/shared_widgets/icon_buttons.dart';
import 'package:just_music/core/utils/app_icon.dart';
import 'package:just_music/core/shared_widgets/custom_text_form_field.dart';
import 'package:just_music/core/styling/app_colors.dart';
import 'package:just_music/core/utils/app_strings.dart';

class SectionTextFormField extends StatelessWidget {
  const SectionTextFormField({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      hintText: AppStrings.searchByName,
      prefixIcon: CustomIconButton(
        onPressed: () {},
        icon: AppIcon.search,
        color: AppColor.white.withAlpha(120),
      ),
    );
  }
}
