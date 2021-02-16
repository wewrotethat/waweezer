import 'package:flutter/foundation.dart';
import 'package:waweezer_mobile/models/playlist.dart';

abstract class PlaylistEvent {}

class CreatePlaylistEvent extends PlaylistEvent {
  final Playlist playlist;

  CreatePlaylistEvent(this.playlist);
}

class ReadPlaylistsEvent extends PlaylistEvent {}

class ReadPlaylistEvent extends PlaylistEvent {
  final String playlistId;

  ReadPlaylistEvent(this.playlistId);
}

class UpdatePlaylistEvent extends PlaylistEvent {
  final String playlistId;
  final Playlist playlist;

  UpdatePlaylistEvent({
    @required this.playlistId,
    @required this.playlist,
  });
}

class DeletePlaylistEvent extends PlaylistEvent {
  final String playlistId;

  DeletePlaylistEvent(this.playlistId);
}
