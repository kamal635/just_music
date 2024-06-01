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

  CheckPermissionBloc({required OnAudioQuery onAudioQuery})
      : _onAudioQuery = onAudioQuery,
        super(const CheckPermissionState()) {
    on<StatusPermissionEvent>(_onTappedPermissionEvent);
  }

  void _onTappedPermissionEvent(
    StatusPermissionEvent event,
    Emitter<CheckPermissionState> emit,
  ) async {
    final hasPermission = await _onAudioQuery.checkAndRequest();

    if (hasPermission == true) {
      emit(state.copyWith(permissionStatus: PermissionStatus.granted));
    } else {
      emit(state.copyWith(permissionStatus: PermissionStatus.denied));
    }
  }
}
