import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waweezer_mobile/bloc/song/song_event.dart';
import 'package:waweezer_mobile/bloc/song/song_repository.dart';
import 'package:waweezer_mobile/bloc/song/song_state.dart';

class SongBloc extends Bloc<SongEvent, SongState> {
  final SongRepository songRepository;
  SongBloc({@required this.songRepository}) : super(SongInitialState());

  @override
  Stream<SongState> mapEventToState(SongEvent event) async* {
    if (event is CreateSongEvent) {
      yield SongOperationInProgress();
      try {
        await songRepository.createSong(event.song);
        var songs = await songRepository.readSongs();

        yield MultipleSongsOperationSuccess(songs);
      } catch (e) {
        yield SongOperationFailed(e.toString());
      }
    } else if (event is UpdateSongEvent) {
      yield SongOperationInProgress();
      try {
        await songRepository.updateSong(event.songId, event.song);
        var songs = await songRepository.readSongs();

        yield MultipleSongsOperationSuccess(songs);
      } catch (e) {
        yield SongOperationFailed(e.toString());
      }
    } else if (event is ReadSongsEvent) {
      yield SongOperationInProgress();
      try {
        var songs = await songRepository.readSongs();
        yield MultipleSongsOperationSuccess(songs);
      } catch (e) {
        yield SongOperationFailed(e.toString());
      }
    } else if (event is ReadSongEvent) {
      yield SongOperationInProgress();
      try {
        var song = await songRepository.readSong(event.songId);
        yield SingleSongOperationSuccess(song);
      } catch (e) {
        yield SongOperationFailed(e.toString());
      }
    } else if (event is DeleteSongEvent) {
      yield SongOperationInProgress();
      try {
        await songRepository.deleteSong(event.songId);
        var songs = await songRepository.readSongs();

        yield MultipleSongsOperationSuccess(songs);
      } catch (e) {
        yield SongOperationFailed(e.toString());
      }
    }
  }
}
