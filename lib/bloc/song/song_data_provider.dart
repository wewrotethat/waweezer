import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:waweezer_mobile/helpers/api_helper.dart';
import 'package:waweezer_mobile/models/song.dart';
import 'package:waweezer_mobile/resources/constants.dart';

class SongDataProvider {
  final APIHelper apiHelper;
  SongDataProvider({@required this.apiHelper});

  Future<Song> createSong(Song song) async {
    var response = await apiHelper.post('$baseURL/songs', song.toMap());
    print(response.body);
    return Song.fromJson(response.body);
  }

  Future<Song> readSong(String id) async {
    assert(id != null);
    var response = await apiHelper.get('$baseURL/songs/$id');
    return Song.fromJson(response.body);
  }

  Future<List<Song>> readSongs() async {
    var response = await apiHelper.get('$baseURL/songs');
    List<dynamic> songListResponse = json.decode(response.body);
    List<Song> songs = List<Song>();
    songListResponse.forEach((songMap) {
      songs.add(Song.fromMap(songMap));
    });
    return songs;
  }

  Future<void> updateSong(String id, Song song) async {
    assert(id != null && song != null);
    await apiHelper.patch('$baseURL/songs/$id', song.toMap());
  }

  Future<void> deleteSong(String id) async {
    assert(id != null);
    await apiHelper.delete('$baseURL/songs/$id');
  }
}
