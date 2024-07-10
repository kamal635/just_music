import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:just_music/features/favorites/data/models/favorite_model.dart';
import 'package:just_music/features/favorites/data/repository/favorite_repo.dart';
import 'package:just_music/features/home/data/model/song.dart';

part 'favorite_songs_event.dart';
part 'favorite_songs_state.dart';

class FavoriteSongsBloc extends Bloc<FavoriteSongsEvent, FavoriteSongsState> {
  final FavoriteRepoImpl favoriteRepoImpl;

  FavoriteSongsBloc({required this.favoriteRepoImpl})
      : super(const FavoriteSongsState()) {
    on<LoadFavoriteSongs>(_onLoadFavoriteSongs); //Load

    on<AddSongToFavorite>(_onAddSongToFavorite); //Add

    on<RemoveSongFromFavorite>(_onRemoveSongFromFavorite); //Remove
  }

  ///**************Load Favorite Event*******************/
  ///***************************************************/
  void _onLoadFavoriteSongs(
    LoadFavoriteSongs event,
    Emitter<FavoriteSongsState> emit,
  ) async {
    emit(state.copyWith(favoriteSongsStatus: FavoriteSongsStatus.loading));

    try {
      Box box = await favoriteRepoImpl.openBox();
      List<Song> songFromLocal = favoriteRepoImpl.getSongs(box);

      emit(state.copyWith(
        favoriteSongsStatus: FavoriteSongsStatus.loaded,
        favoriteSong: FavoriteSong(favoriteSongs: songFromLocal),
      ));
    } catch (e) {
      emit(state.copyWith(
        favoriteSongsStatus: FavoriteSongsStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  ///****************Add Song Event*******************/
  ///***************************************************/
  void _onAddSongToFavorite(
    AddSongToFavorite event,
    Emitter<FavoriteSongsState> emit,
  ) async {
    emit(state.copyWith(favoriteSongsStatus: FavoriteSongsStatus.loading));

    try {
      Box box = await favoriteRepoImpl.openBox();
      favoriteRepoImpl.addSongToFavorite(box, event.song);

      // existing Favorite Song
      List<Song> existingFavorites = state.favoriteSong!.favoriteSongs;

      // Filter out duplicates (ensure song isn't already favorited)
      List<Song> filteredFavorites =
          existingFavorites.where((song) => event.song.id != song.id).toList();

      // Combine existing favorites with the new song
      List<Song> updatedFavorites = List.from(filteredFavorites)
        ..add(event.song);

      emit(state.copyWith(
          favoriteSongsStatus: FavoriteSongsStatus.loaded,
          favoriteSong: FavoriteSong(favoriteSongs: updatedFavorites)));
    } catch (e) {
      emit(state.copyWith(
        favoriteSongsStatus: FavoriteSongsStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  ///****************Remove Song Evnet*******************/
  ///***************************************************/
  void _onRemoveSongFromFavorite(
    RemoveSongFromFavorite event,
    Emitter<FavoriteSongsState> emit,
  ) async {
    emit(state.copyWith(favoriteSongsStatus: FavoriteSongsStatus.loading));

    try {
      Box box = await favoriteRepoImpl.openBox();
      favoriteRepoImpl.removeSongFromFavorite(box, event.song);

      // existing Favorite Song
      List<Song> existingFavorites = state.favoriteSong!.favoriteSongs;

      // Combine existing favorites with the new song
      List<Song> updatedFavorites = List.from(existingFavorites)
        ..remove(event.song);

      emit(state.copyWith(
          favoriteSongsStatus: FavoriteSongsStatus.loaded,
          favoriteSong: FavoriteSong(favoriteSongs: updatedFavorites)));
    } catch (e) {
      emit(state.copyWith(
        favoriteSongsStatus: FavoriteSongsStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }
}
