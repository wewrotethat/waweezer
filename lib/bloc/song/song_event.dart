import 'package:flutter/foundation.dart';
import 'package:waweezer_mobile/models/song.dart';

abstract class SongEvent {}

class CreateSongEvent extends SongEvent {
  final Song song;

  CreateSongEvent(this.song);
}

class ReadSongsEvent extends SongEvent {}

class ReadSongEvent extends SongEvent {
  final String songId;

  ReadSongEvent(this.songId);
}

class UpdateSongEvent extends SongEvent {
  final String songId;
  final Song song;

  UpdateSongEvent({
    @required this.songId,
    @required this.song,
  });
}

class DeleteSongEvent extends SongEvent {
  final String songId;

  DeleteSongEvent(this.songId);
}
