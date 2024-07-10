part of 'favorite_songs_bloc.dart';

enum FavoriteSongsStatus {
  initial,
  loading,
  loaded,
  failure,
}

class FavoriteSongsState extends Equatable {
  final FavoriteSong? favoriteSong;
  final FavoriteSongsStatus favoriteSongsStatus;
  final String? errorMessage;
  const FavoriteSongsState({
    this.favoriteSong,
    this.favoriteSongsStatus = FavoriteSongsStatus.loaded,
    this.errorMessage,
  });

  FavoriteSongsState copyWith({
    FavoriteSong? favoriteSong,
    FavoriteSongsStatus? favoriteSongsStatus,
    String? errorMessage,
  }) {
    return FavoriteSongsState(
        favoriteSong: favoriteSong ?? this.favoriteSong,
        favoriteSongsStatus: favoriteSongsStatus ?? this.favoriteSongsStatus,
        errorMessage: errorMessage ?? this.errorMessage);
  }

  @override
  List<Object?> get props => [favoriteSong, favoriteSongsStatus, errorMessage];
}
