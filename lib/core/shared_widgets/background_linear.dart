import 'package:flutter/material.dart';
import 'package:just_music/core/styling/app_colors.dart';

class BackgroundLinearGradiant extends StatelessWidget {
  const BackgroundLinearGradiant({super.key, this.child});
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            AppColor.primary,
            AppColor.secondary,
          ],
        ),
      ),
      child: child,
    );
  }
}
