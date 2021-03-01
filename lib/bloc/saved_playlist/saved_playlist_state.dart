import 'package:waweezer_mobile/models/playlist.dart';

abstract class SavedPlaylistState {}

class SavedPlaylistInitialState extends SavedPlaylistState {}

class SavedPlaylistOperationSuccess extends SavedPlaylistState {
  final List<Playlist> playlists;

  SavedPlaylistOperationSuccess(this.playlists);
}

class SavedPlaylistOperationInProgress extends SavedPlaylistState {}

class SavedPlaylistOperationFailed extends SavedPlaylistState {
  final String error;

  SavedPlaylistOperationFailed(this.error);
}
