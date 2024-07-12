part of 'fetch_songs_from_device_bloc.dart';

@immutable
sealed class FetchSongsFromDeviceEvent {}

class LoadSongsFromDeviceEvent extends FetchSongsFromDeviceEvent {}
