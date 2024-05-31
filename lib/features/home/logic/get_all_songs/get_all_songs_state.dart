part of 'get_all_songs_bloc.dart';

enum GetSongsStatus { initial, loading, loaded, failure }

@immutable
class GetAllSongsState extends Equatable {
  final GetSongsStatus getSongsStatus;
  final List<SongModel>? songModel;
  final String? errorMessage;

  const GetAllSongsState({
    this.getSongsStatus = GetSongsStatus.initial,
    this.songModel,
    this.errorMessage,
  });

  GetAllSongsState copyWith({
    GetSongsStatus? getSongsStatus,
    List<SongModel>? songModel,
    String? errorMessage,
  }) {
    return GetAllSongsState(
      getSongsStatus: getSongsStatus ?? this.getSongsStatus,
      songModel: songModel ?? this.songModel,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [getSongsStatus, songModel, errorMessage];
}
