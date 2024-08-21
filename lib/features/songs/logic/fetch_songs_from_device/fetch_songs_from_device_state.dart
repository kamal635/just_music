part of 'fetch_songs_from_device_bloc.dart';

enum FetchSongsStatus {
  initial,
  loading,
  loaded,
  failure,
}

class FetchSongsFromDeviceState extends Equatable {
  final FetchSongsStatus fetchSongsStatus;
  final List<Song> songs;
  final List<Song> fixedSongs;
  final String? errorMessage;

  const FetchSongsFromDeviceState({
    this.fetchSongsStatus = FetchSongsStatus.initial,
    this.songs = const [],
    this.fixedSongs = const [],
    this.errorMessage,
  });

  FetchSongsFromDeviceState copyWith({
    FetchSongsStatus? fetchSongsStatus,
    List<Song>? songs,
    List<Song>? fixedSongs,
    String? errorMessage,
  }) {
    return FetchSongsFromDeviceState(
      fetchSongsStatus: fetchSongsStatus ?? this.fetchSongsStatus,
      songs: songs ?? this.songs,
      fixedSongs: fixedSongs ?? this.fixedSongs,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props =>
      [fetchSongsStatus, songs, errorMessage, fixedSongs];
}
