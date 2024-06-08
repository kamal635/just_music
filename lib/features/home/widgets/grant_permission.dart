import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_music/core/helpers/spacer.dart';
import 'package:just_music/core/shared_widgets/custom_elvated_button.dart';
import 'package:just_music/core/styling/app_fonts.dart';
import 'package:just_music/core/utils/app_strings.dart';
import 'package:just_music/features/home/logic/check_permission/check_permission_bloc.dart';

class GrantPermission extends StatelessWidget {
  const GrantPermission({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        spaceHeight(20),
        Text(
          AppStrings.allowPermission,
          style: AppFonts.bold_18,
        ),
        spaceHeight(20),
        Text(
          AppStrings.followingSteps,
          style: AppFonts.normal_10,
        ),
        spaceHeight(20),
        CustomElvatedButton(
            title: AppStrings.allow,
            isIcon: false,
            onPressed: () {
              context.read<CheckPermissionBloc>().add(StatusPermissionEvent());
            }),
      ],
    );
  }
}
