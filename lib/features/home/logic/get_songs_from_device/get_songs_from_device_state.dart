part of 'get_songs_from_device_bloc.dart';

enum GetSongsStatus { initial, loading, loaded, failure }

@immutable
class GetSongsFromDeviceState extends Equatable {
  final GetSongsStatus getSongsStatus;
  final List<SongModel>? songModel;
  final String? errorMessage;

  const GetSongsFromDeviceState({
    this.getSongsStatus = GetSongsStatus.initial,
    this.songModel,
    this.errorMessage,
  });

  GetSongsFromDeviceState copyWith({
    GetSongsStatus? getSongsStatus,
    List<SongModel>? songModel,
    String? errorMessage,
  }) {
    return GetSongsFromDeviceState(
      getSongsStatus: getSongsStatus ?? this.getSongsStatus,
      songModel: songModel ?? this.songModel,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [getSongsStatus, songModel, errorMessage];
}
