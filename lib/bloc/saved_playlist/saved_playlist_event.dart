import 'package:waweezer_mobile/models/playlist.dart';

abstract class SavedPlaylistEvent {}

class AddSavedPlaylistEvent extends SavedPlaylistEvent {
  final Playlist playlist;

  AddSavedPlaylistEvent(this.playlist);
}

class RemoveSavedPlaylistEvent extends SavedPlaylistEvent {
  final String playlistId;

  RemoveSavedPlaylistEvent(this.playlistId);
}

class ReadSavedPlaylistsEvent extends SavedPlaylistEvent {
  ReadSavedPlaylistsEvent();
}
