import 'package:flutter/material.dart';
import 'package:just_music/features/home/widgets/home_view_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // bottomSheet: BottomSheet(onClosing: (){}, builder: (context){}),
      body: HomeViewBody(),
    );
  }
}
