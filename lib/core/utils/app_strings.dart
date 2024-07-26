abstract class AppStrings {
  static const String unknown = "<unknown>";
  static const String cancel = "Cancel";
  static const String confirm = "Confirm";
  static const String ok = "OK";
  static const String createPlaylist = "create playlist";
  static const String editNamePlaylist = 'Edit Name Playlist';
  static const String addSongs = "Add Songs";
  static const String deleteSong = "Delete this song from the playlist?";
  static const String songAlreadyExist =
      "This song already exists in this playlist";
  static const String newPlaylist = "New playlist";
  static const String successfullyAddedSong =
      "Successfully added to the playlist";
  static const String localSongs = "Local songs";
  static const String addToPlaylist = "Add To Playlist";
  static const String addSongsToPlaylist = "Add songs to playlist";
  static const String removeFromPlaylist = "Remove From Playlist";
  static const String addToFavorite = "Add To Favorite";
  static const String nameBlank = "Playlist name can't be blank";
  static const String nameAlreadyExist = "Playlist Name already exists";
  static const String renamePlaylist = "Rename Playlist";
  static const String allow = " Allow ";
  static const String detail = " detail";
  static const String playAll = "Play All";
  static const String shuffle = "Shuffle";
  static const String library = "Library";
  static const String songs = "Songs";
  static const String albums = "Albums";
  static const String playlists = "Playlists";
  static const String playlistName = "Playlist Name";
  static const String enterPlaylistName = "Enter Playlist Name";
  static const String folders = "Folders";
  static const String favorites = "Favorites";
  static const String favoriteSongs = "Favorite songs";
  static const String delete = "Delete";
  static const String done = "Done";
  static const String searchByName = "Search for songs on device";
  static const String emptySongs = "No items here yet.";
  static const String unexpectedError =
      "Unexpected error..please try again later!";
  static const String followingSteps =
      "You can grant this permission in Settings > Apps > Permissions > Files and media > Music";
  static const String allowPermission =
      "Allow this app to access files to discover music on your device";
}

abstract class AppHive {
  static const String favoriteBox = "favoriteBox";
  static const String storeSongs = "storeSongs";
  static const String playlist = "playlist";
}

abstract class AppArguments {
  static const String favoriteSong = "favoriteSong";
  static const String playlist = "playlist";
  static const String songs = "songs";
  static const String playlistComeFromPreviousPage =
      "playlistComeFromPreviousPage";
}
