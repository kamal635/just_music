import 'package:flutter/material.dart';
import 'package:just_music/core/styling/icons.dart';
import 'package:just_music/core/shared_widgets/custom_text_form_field.dart';
import 'package:just_music/core/styling/colors.dart';

class SectionTextFormField extends StatelessWidget {
  const SectionTextFormField({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      hintText: "Search by Name",
      prefixIcon: IconButton(
        color: AppColor.white.withAlpha(120),
        onPressed: () {},
        icon: const Icon(
          AppIcon.search,
        ),
      ),
    );
  }
}
