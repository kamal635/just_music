import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/helpers/navigation.dart';
import '../../../../core/shared_widgets/custom_text_form_field.dart';
import '../../../../core/styling/app_colors.dart';
import '../../../../core/styling/app_fonts.dart';
import '../../../../core/constant/app_strings.dart';
import '../../logic/search_songs/search_songs_bloc.dart';

class TextFormFieldAndTextButton extends StatelessWidget {
  const TextFormFieldAndTextButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        //TextFormField
        Expanded(
          child: CustomTextFormField(
            onChanged: (value) {
              context.read<SearchSongsBloc>().add(SearchEvent(query: value));
            },
            autofocus: true,
            hintText: AppStrings.searchByName,
          ),
        ),

        // TextButton
        TextButton(
            onPressed: () {
              // add event reset to clear list of songs
              // when push to it again
              context.read<SearchSongsBloc>().add(ResetSearchEvent());

              // pop when press on songs
              context.pop();
            },
            child: Text(
              AppStrings.cancel,
              style: AppFonts.normal_14.copyWith(color: AppColor.white),
            ))
      ],
    );
  }
}
