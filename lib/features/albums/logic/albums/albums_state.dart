part of 'albums_bloc.dart';

enum AlbumsStatus { initial, loading, loaded, failure }

class AlbumsState extends Equatable {
  final AlbumsStatus albumsStatus;
  final List<Album>? albums;

  const AlbumsState({
    this.albumsStatus = AlbumsStatus.initial,
    this.albums,
  });

  AlbumsState copyWith({
    final AlbumsStatus? albumsStatus,
    final List<Album>? albums,
  }) {
    return AlbumsState(
      albumsStatus: albumsStatus ?? this.albumsStatus,
      albums: albums ?? this.albums,
    );
  }

  @override
  List<Object?> get props => [albumsStatus, albums];
}
