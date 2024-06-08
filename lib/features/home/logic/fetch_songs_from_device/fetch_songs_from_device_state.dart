part of 'fetch_songs_from_device_bloc.dart';

enum GetSongsStatus { initial, loading, loaded, failure }

@immutable
class FetchSongsFromDeviceState extends Equatable {
  final GetSongsStatus getSongsStatus;
  final List<Song>? songModel;
  final String? errorMessage;

  const FetchSongsFromDeviceState({
    this.getSongsStatus = GetSongsStatus.initial,
    this.songModel,
    this.errorMessage,
  });

  FetchSongsFromDeviceState copyWith({
    GetSongsStatus? getSongsStatus,
    List<Song>? songModel,
    String? errorMessage,
  }) {
    return FetchSongsFromDeviceState(
      getSongsStatus: getSongsStatus ?? this.getSongsStatus,
      songModel: songModel ?? this.songModel,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [getSongsStatus, songModel, errorMessage];
}
