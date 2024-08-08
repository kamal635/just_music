part of 'nav_bottom_bar_bloc.dart';

sealed class NavBottomBarEvent extends Equatable {
  const NavBottomBarEvent();

  @override
  List<Object> get props => [];
}

class ChangedCurrentPageEvent extends NavBottomBarEvent {
  final int index;

  const ChangedCurrentPageEvent({required this.index});
}
