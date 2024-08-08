part of 'nav_bottom_bar_bloc.dart';

enum NavBottomBarStatus { initial, changed }

class NavBottomBarState extends Equatable {
  final NavBottomBarStatus navBottomBarStatus;
  final int currentPage;

  const NavBottomBarState({
    this.navBottomBarStatus = NavBottomBarStatus.initial,
    this.currentPage = 0,
  });

  NavBottomBarState copyWith({
    NavBottomBarStatus? navBottomBarStatus,
    int? currentPage,
  }) {
    return NavBottomBarState(
      currentPage: currentPage ?? this.currentPage,
      navBottomBarStatus: navBottomBarStatus ?? this.navBottomBarStatus,
    );
  }

  @override
  List<Object> get props => [navBottomBarStatus, currentPage];
}
