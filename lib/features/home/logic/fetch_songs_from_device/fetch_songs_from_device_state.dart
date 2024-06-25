part of 'fetch_songs_from_device_bloc.dart';

enum FetchSongsStatus { initial, loading, loaded, failure }

@immutable
class FetchSongsFromDeviceState extends Equatable {
  final FetchSongsStatus fetchSongsStatus;
  final List<Song>? songModel;
  final String? errorMessage;

  const FetchSongsFromDeviceState({
    this.fetchSongsStatus = FetchSongsStatus.initial,
    this.songModel,
    this.errorMessage,
  });

  FetchSongsFromDeviceState copyWith({
    FetchSongsStatus? fetchSongsStatus,
    List<Song>? songModel,
    String? errorMessage,
  }) {
    return FetchSongsFromDeviceState(
      fetchSongsStatus: fetchSongsStatus ?? this.fetchSongsStatus,
      songModel: songModel ?? this.songModel,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [fetchSongsStatus, songModel, errorMessage];
}
