part of 'check_permission_bloc.dart';

sealed class CheckPermissionEvent extends Equatable {
  const CheckPermissionEvent();

  @override
  List<Object> get props => [];
}

class StatusPermissionEvent extends CheckPermissionEvent {}
