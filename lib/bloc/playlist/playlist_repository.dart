import 'package:flutter/foundation.dart';
import 'package:waweezer_mobile/bloc/playlist/playlist_data_provider.dart';
import 'package:waweezer_mobile/models/playlist.dart';

class PlaylistRepository {
  final PlaylistDataProvider playlistDataProvider;

  PlaylistRepository({@required this.playlistDataProvider, PlaylistDataProvider savedPlaylistDataProvider});

  Future<Playlist> createPlaylist(Playlist playlist) async {
    return await playlistDataProvider.createPlaylist(playlist);
  }

  Future<List<Playlist>> readPlaylists() async {
    return await playlistDataProvider.readPlaylists();
  }

  Future<Playlist> readPlaylist(String id) async {
    return await playlistDataProvider.readPlaylist(id);
  }

  Future<void> updatePlaylist(String id, Playlist playlist) async {
    return await playlistDataProvider.updatePlaylist(id, playlist);
  }

  Future<void> deletePlaylist(String id) async {
    return await playlistDataProvider.deletePlaylist(id);
  }
}
