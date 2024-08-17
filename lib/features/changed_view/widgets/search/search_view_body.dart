import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/helpers/spacer.dart';
import 'list_of_songs_search.dart';
import 'text_field_and_text_button.dart';

class SearchViewBody extends StatelessWidget {
  const SearchViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        child: Column(
          children: [
            spaceHeight(34),

            // TextField And TextButton
            const TextFormFieldAndTextButton(),

            spaceHeight(15),

            // List Of Songs
            const Expanded(child: ListOfSongsSearch()),
          ],
        ),
      ),
    );
  }
}
