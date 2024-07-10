import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:on_audio_query/on_audio_query.dart';
part 'check_permission_event.dart';
part 'check_permission_state.dart';

// BlocProvider instance in :
// lib\features\home\widgets\home_view_body.dart
class CheckPermissionBloc
    extends Bloc<CheckPermissionEvent, CheckPermissionState> {
  final OnAudioQuery _onAudioQuery;

  CheckPermissionBloc({
    required OnAudioQuery onAudioQuery,
  })  : _onAudioQuery = onAudioQuery,
        super(const CheckPermissionState()) {
    on<StatusPermissionEvent>(_onTappedPermissionEvent);
  }

  void _onTappedPermissionEvent(
    StatusPermissionEvent event,
    Emitter<CheckPermissionState> emit,
  ) async {
    emit(state.copyWith(permissionStatus: PermissionStatuss.loading));

    // Request permissions for photos and media
    final hasMediaPermission = await _onAudioQuery.checkAndRequest();

    if (hasMediaPermission) {
      // If hasMediaPermission == true (granted) , emit this
      emit(state.copyWith(permissionStatus: PermissionStatuss.granted));
    } else {
      // If hasMediaPermission == false (denied) , emit this
      emit(state.copyWith(permissionStatus: PermissionStatuss.denied));
    }
  }
}
