part of 'fetch_songs_from_device_bloc.dart';

@immutable
sealed class FetchSongsFromDeviceEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadSongsFromDeviceEvent extends FetchSongsFromDeviceEvent {}

class LoadFixedSongsFromDeviceEvent extends FetchSongsFromDeviceEvent {}
