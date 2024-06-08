part of 'check_permission_bloc.dart';

enum PermissionStatus { initial, granted, denied }

class CheckPermissionState extends Equatable {
  final PermissionStatus permissionStatus;

  const CheckPermissionState({
    this.permissionStatus = PermissionStatus.initial,
  });

  CheckPermissionState copyWith({
    PermissionStatus? permissionStatus,
  }) {
    return CheckPermissionState(
      permissionStatus: permissionStatus ?? this.permissionStatus,
    );
  }

  @override
  List<Object> get props => [permissionStatus];
}
