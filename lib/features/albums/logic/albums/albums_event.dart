part of 'albums_bloc.dart';

sealed class AlbumsEvent extends Equatable {
  const AlbumsEvent();

  @override
  List<Object> get props => [];
}

class LoadAlbumsEvent extends AlbumsEvent {}
