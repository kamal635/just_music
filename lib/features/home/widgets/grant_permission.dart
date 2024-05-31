import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_music/core/helpers/spacer.dart';
import 'package:just_music/core/shared_widgets/custom_elvated_button.dart';
import 'package:just_music/core/styling/font.dart';
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
          "Allow this app to access files to discover music on your device",
          style: AppFonts.bold_20,
        ),
        spaceHeight(20),
        Text(
          "You can grant this permission in Settings > Apps > Permissions > Files and media > Music",
          style: AppFonts.normal_12,
        ),
        spaceHeight(20),
        CustomElvatedButton(
            title: " Allow ",
            isIcon: false,
            onPressed: () {
              context.read<CheckPermissionBloc>().add(TappedPermissionEvent());
            }),
      ],
    );
  }
}
