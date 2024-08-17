import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/model/album.dart';
import '../../data/repo/fetch_albums.dart';

part 'albums_event.dart';
part 'albums_state.dart';

class AlbumsBloc extends Bloc<AlbumsEvent, AlbumsState> {
  final FetchAlbumsRepo fetchAlbumsRepo;

  AlbumsBloc({required this.fetchAlbumsRepo}) : super(const AlbumsState()) {
    on<LoadAlbumsEvent>(_onLoadAlbumsEvent);
  }

  void _onLoadAlbumsEvent(
    LoadAlbumsEvent event,
    Emitter<AlbumsState> emit,
  ) async {
    emit(state.copyWith(albumsStatus: AlbumsStatus.loading));
    try {
      final listAlbum = await fetchAlbumsRepo.fetchAlbums();
      emit(
          state.copyWith(albumsStatus: AlbumsStatus.loaded, albums: listAlbum));
    } catch (e) {
      emit(state.copyWith(albumsStatus: AlbumsStatus.failure));
    }
  }
}
