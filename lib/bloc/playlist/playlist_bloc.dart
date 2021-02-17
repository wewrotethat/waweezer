import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waweezer_mobile/bloc/playlist/playlist_event.dart';
import 'package:waweezer_mobile/bloc/playlist/playlist_repository.dart';
import 'package:waweezer_mobile/bloc/playlist/playlist_state.dart';
import 'package:waweezer_mobile/models/playlist.dart';

class PlaylistBloc extends Bloc<PlaylistEvent, PlaylistState> {
  final PlaylistRepository playlistRepository;
  PlaylistBloc({@required this.playlistRepository})
      : super(PlaylistInitialState());

  @override
  Stream<PlaylistState> mapEventToState(PlaylistEvent event) async* {
    if (event is CreatePlaylistEvent) {
      yield PlaylistOperationInProgress();
      try {
        await playlistRepository.createPlaylist(event.playlist);
        List<Playlist> playlists = await playlistRepository.readPlaylists();
        yield MultiplePlaylistsOperationSuccess(playlists);
      } catch (e) {
        yield PlaylistOperationFailed(e.toString());
      }
    } else if (event is UpdatePlaylistEvent) {
      yield PlaylistOperationInProgress();
      try {
        await playlistRepository.updatePlaylist(
            event.playlistId, event.playlist);
        List<Playlist> playlists = await playlistRepository.readPlaylists();
        yield MultiplePlaylistsOperationSuccess(playlists);
      } catch (e) {
        yield PlaylistOperationFailed(e.toString());
      }
    } else if (event is ReadPlaylistsEvent) {
      yield PlaylistOperationInProgress();
      try {
        var playlists = await playlistRepository.readPlaylists();
        yield MultiplePlaylistsOperationSuccess(playlists);
      } catch (e) {
        yield PlaylistOperationFailed(e.toString());
      }
    } else if (event is ReadPlaylistEvent) {
      yield PlaylistOperationInProgress();
      try {
        var playlist = await playlistRepository.readPlaylist(event.playlistId);
        yield SinglePlaylistOperationSuccess(playlist);
      } catch (e) {
        yield PlaylistOperationFailed(e.toString());
      }
    } else if (event is DeletePlaylistEvent) {
      yield PlaylistOperationInProgress();
      try {
        await playlistRepository.deletePlaylist(event.playlistId);
        List<Playlist> playlists = await playlistRepository.readPlaylists();
        yield MultiplePlaylistsOperationSuccess(playlists);
        ;
      } catch (e) {
        yield PlaylistOperationFailed(e.toString());
      }
    }
  }
}
