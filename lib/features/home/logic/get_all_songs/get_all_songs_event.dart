part of 'get_all_songs_bloc.dart';

@immutable
sealed class GetAllSongsEvent {}

class TriggerGetAllSongsEvent extends GetAllSongsEvent {}
