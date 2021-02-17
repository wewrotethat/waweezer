import 'package:flutter/foundation.dart';
import 'package:waweezer_mobile/bloc/song/song_data_provider.dart';
import 'package:waweezer_mobile/models/song.dart';

class SongRepository {
  final SongDataProvider songDataProvider;

  SongRepository({@required this.songDataProvider});

  Future<Song> createSong(Song song) async {
    return await songDataProvider.createSong(song);
  }

  Future<List<Song>> readSongs() async {
    return await songDataProvider.readSongs();
  }

  Future<Song> readSong(String id) async {
    return await songDataProvider.readSong(id);
  }

  Future<void> updateSong(String id, Song song) async {
    return await songDataProvider.updateSong(id, song);
  }

  Future<void> deleteSong(String id) async {
    return await songDataProvider.deleteSong(id);
  }
}
