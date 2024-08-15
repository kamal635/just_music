import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/model/artists.dart';
import '../../data/repo/fetch_artists.dart';

part 'artists_event.dart';
part 'artists_state.dart';

class ArtistsBloc extends Bloc<ArtistsEvent, ArtistsState> {
  final FetchArtistsRepoImpl fetchArtistsRepoImpl;

  ArtistsBloc({required this.fetchArtistsRepoImpl})
      : super(const ArtistsState()) {
    on<LoadArtistEvent>(_onLoadArtistEvent);
  }

  void _onLoadArtistEvent(
    LoadArtistEvent event,
    Emitter<ArtistsState> emit,
  ) async {
    emit(state.copyWith(artistsStatus: ArtistsStatus.loading));
    try {
      final listArtist = await fetchArtistsRepoImpl.fetchArtists();
      emit(state.copyWith(
          artistsStatus: ArtistsStatus.loaded, artists: listArtist));
    } catch (e) {
      emit(state.copyWith(artistsStatus: ArtistsStatus.failure));
    }
  }
}
