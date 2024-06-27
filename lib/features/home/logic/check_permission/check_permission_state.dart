part of 'check_permission_bloc.dart';

enum PermissionStatuss { initial, granted, denied }

class CheckPermissionState extends Equatable {
  final PermissionStatuss permissionStatus;

  const CheckPermissionState({
    this.permissionStatus = PermissionStatuss.initial,
  });

  CheckPermissionState copyWith({
    PermissionStatuss? permissionStatus,
  }) {
    return CheckPermissionState(
      permissionStatus: permissionStatus ?? this.permissionStatus,
    );
  }

  @override
  List<Object> get props => [permissionStatus];
}
