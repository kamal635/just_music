import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/helpers/navigation.dart';
import '../../../../core/routes/string_route.dart';
import '../../../../core/shared_widgets/custom_icon_buttons.dart';
import '../../../../core/shared_widgets/custom_text_form_field.dart';
import '../../../../core/styling/app_colors.dart';
import '../../../../core/constant/app_icon.dart';
import '../../../../core/constant/app_strings.dart';

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
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        _isFieldVisible = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TextField
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeIn,
      transform: _isFieldVisible
          ? Matrix4.translationValues(0, 0, 0)
          : Matrix4.translationValues(0, -70.h, 0),
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
