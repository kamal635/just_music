part of 'fetch_songs_from_device_bloc.dart';

enum FetchSongsStatus { initial, loading, loadingMore, loaded, failure, empty }

class FetchSongsFromDeviceState extends Equatable {
  final FetchSongsStatus fetchSongsStatus;
  final List<Song> songs;
  final String? errorMessage;

  const FetchSongsFromDeviceState({
    this.fetchSongsStatus = FetchSongsStatus.initial,
    this.songs = const [],
    this.errorMessage,
  });

  FetchSongsFromDeviceState copyWith({
    FetchSongsStatus? fetchSongsStatus,
    List<Song>? songs,
    int? lastLoadedSongId,
    bool? hasMoreSongs,
    String? errorMessage,
  }) {
    return FetchSongsFromDeviceState(
      fetchSongsStatus: fetchSongsStatus ?? this.fetchSongsStatus,
      songs: songs ?? this.songs,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [fetchSongsStatus, songs, errorMessage];
}
