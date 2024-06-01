part of 'get_songs_from_device_bloc.dart';

@immutable
sealed class GetSongsFromDeviceEvent {}

class TriggerGetSongsFromDeviceEvent extends GetSongsFromDeviceEvent {}
