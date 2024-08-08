import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'nav_bottom_bar_event.dart';
part 'nav_bottom_bar_state.dart';

class NavBottomBarBloc extends Bloc<NavBottomBarEvent, NavBottomBarState> {
  NavBottomBarBloc() : super(const NavBottomBarState()) {
    on<ChangedCurrentPageEvent>(_onChangedCurrentPageEvent);
  }

  void _onChangedCurrentPageEvent(
    ChangedCurrentPageEvent event,
    Emitter<NavBottomBarState> emit,
  ) {
    emit(state.copyWith(
      currentPage: event.index,
      navBottomBarStatus: NavBottomBarStatus.changed,
    ));
  }
}
