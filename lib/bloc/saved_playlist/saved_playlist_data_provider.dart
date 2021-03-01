import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:waweezer_mobile/helpers/api_helper.dart';
import 'package:waweezer_mobile/models/playlist.dart';
import 'package:waweezer_mobile/resources/constants.dart';

class SavedPlaylistDataProvider {
  final APIHelper apiHelper;
  SavedPlaylistDataProvider({@required this.apiHelper});

  Future<List<Playlist>> readSavedPlaylists() async {
    var response = await apiHelper.get('$baseURL/me/playlists');
    List<dynamic> playlistListResponse = json.decode(response.body);
    List<Playlist> playlists = List<Playlist>();
    playlistListResponse.forEach((playlistMap) {
      playlists.add(Playlist.fromMap(playlistMap));
    });
    return playlists;
  }

  Future<void> removePlaylist(String id) async {
    assert(id != null);
    await apiHelper.delete('$baseURL/me/playlists/$id');
  }

  Future<void> savePlaylist(Playlist playlist) async {
    assert(playlist != null);
    await apiHelper.post('$baseURL/me/playlists/me', playlist.toMap());
  }
}
