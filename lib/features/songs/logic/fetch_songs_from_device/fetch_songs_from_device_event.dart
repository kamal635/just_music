part of 'fetch_songs_from_device_bloc.dart';

@immutable
sealed class FetchSongsFromDeviceEvent extends Equatable {}

class LoadSongsFromDeviceEvent extends FetchSongsFromDeviceEvent {
  @override
  List<Object?> get props => [];
}
