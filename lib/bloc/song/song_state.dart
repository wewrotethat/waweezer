import 'package:waweezer_mobile/models/song.dart';

abstract class SongState {}

class SongInitialState extends SongState {}

class SingleSongOperationSuccess extends SongState {
  final Song song;

  SingleSongOperationSuccess(this.song);
}

class MultipleSongsOperationSuccess extends SongState {
  final List<Song> songs;

  MultipleSongsOperationSuccess(this.songs);
}

class SongOperationInProgress extends SongState {}

class SongOperationFailed extends SongState {
  final String error;

  SongOperationFailed(this.error);
}
