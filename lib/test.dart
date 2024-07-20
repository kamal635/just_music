// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:just_music/core/helpers/dependencey_injection.dart';
// import 'package:just_music/core/styling/app_colors.dart';
// import 'package:just_music/features/playlists/data/model/playlist_model.dart';
// import 'package:just_music/features/playlists/logic/playlist/playlist_bloc.dart';
// import 'package:just_music/features/songs/widgets/song_card.dart';
// import 'package:on_audio_query/on_audio_query.dart';

// class TestWidget extends StatefulWidget {
//   const TestWidget({super.key, required this.playlist});
//   final Playlist playlist;
//   @override
//   State<TestWidget> createState() => _TestWidgetState();
// }

// class _TestWidgetState extends State<TestWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => di<PlaylistBloc>()
//         ..add(LoadPlaylistSongs(playlistId: widget.playlist.id)),
//       child: Scaffold(
//         body: BlocBuilder<PlaylistBloc, PlaylistState>(
//           builder: (context, state) {
//             if (state.playlistStatus == PlaylistStatus.loading) {
//               return const Center(
//                 child: CircularProgressIndicator(),
//               );
//             }
//             return ListView.builder(
//               itemCount: state.songs?.length,
//               itemBuilder: (context, i) {
//                 return InkWell(
//                   onTap: () {
//                     print(state.songs?[i].id);
//                   },
//                   child: Text("${state.songs?[i].id}"),
//                 );
//               },
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
