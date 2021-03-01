import 'package:flutter/foundation.dart';
import 'package:waweezer_mobile/bloc/saved_playlist/saved_playlist_data_provider.dart';
import 'package:waweezer_mobile/models/playlist.dart';

class SavedPlaylistRepository {
  final SavedPlaylistDataProvider savedPlaylistDataProvider;

  SavedPlaylistRepository({@required this.savedPlaylistDataProvider});

  Future<List<Playlist>> readSavedPlaylists() async {
    return await savedPlaylistDataProvider.readSavedPlaylists();
  }

  Future<void> savePlaylist(Playlist playlist) async {
    return await savedPlaylistDataProvider.savePlaylist(playlist);
  }

  Future<void> removePlaylist(String id) async {
    return await savedPlaylistDataProvider.removePlaylist(id);
  }
}
