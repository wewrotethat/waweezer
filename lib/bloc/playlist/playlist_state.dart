import 'package:waweezer_mobile/models/playlist.dart';

abstract class PlaylistState {}

class PlaylistInitialState extends PlaylistState {}

class SinglePlaylistOperationSuccess extends PlaylistState {
  final Playlist playlist;

  SinglePlaylistOperationSuccess(this.playlist);
}

class MultiplePlaylistsOperationSuccess extends PlaylistState {
  final List<Playlist> playlists;

  MultiplePlaylistsOperationSuccess(this.playlists);
}

class PlaylistOperationInProgress extends PlaylistState {}

class PlaylistOperationFailed extends PlaylistState {
  final String error;

  PlaylistOperationFailed(this.error);
}
