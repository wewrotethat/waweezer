import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:waweezer_mobile/helpers/api_helper.dart';
import 'package:waweezer_mobile/models/playlist.dart';
import 'package:waweezer_mobile/resources/constants.dart';

class PlaylistDataProvider {
  final APIHelper apiHelper;
  PlaylistDataProvider({@required this.apiHelper});

  Future<Playlist> createPlaylist(Playlist playlist) async {
    var response = await apiHelper.post('$baseURL/playlists', playlist.toMap());
    return Playlist.fromJson(response.body);
  }

  Future<Playlist> readPlaylist(String id) async {
    assert(id != null);
    var response = await apiHelper.get('$baseURL/playlists/$id');
    return Playlist.fromJson(response.body);
  }

  Future<List<Playlist>> readPlaylists() async {
    var response = await apiHelper.get('$baseURL/playlists');
    List<dynamic> playlistListResponse = json.decode(response.body);
    List<Playlist> playlists = List<Playlist>();
    playlistListResponse.forEach((playlistMap) {
      playlists.add(Playlist.fromMap(playlistMap));
    });
    return playlists;
  }

  Future<void> updatePlaylist(String id, Playlist playlist) async {
    assert(id != null && playlist != null);

    await apiHelper.patch('$baseURL/playlists/$id', playlist.toMap());
  }

  Future<void> deletePlaylist(String id) async {
    assert(id != null);
    await apiHelper.delete('$baseURL/playlists/$id');
  }
}
