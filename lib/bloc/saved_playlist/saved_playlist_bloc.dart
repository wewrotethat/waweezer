import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waweezer_mobile/bloc/saved_playlist/saved_playlist_event.dart';
import 'package:waweezer_mobile/bloc/saved_playlist/saved_playlist_repository.dart';
import 'package:waweezer_mobile/bloc/saved_playlist/saved_playlist_state.dart';
import 'package:waweezer_mobile/models/playlist.dart';

class SavedPlaylistBloc extends Bloc<SavedPlaylistEvent, SavedPlaylistState> {
  final SavedPlaylistRepository savedPlaylistRepository;
  SavedPlaylistBloc({@required this.savedPlaylistRepository})
      : super(SavedPlaylistInitialState());

  @override
  Stream<SavedPlaylistState> mapEventToState(SavedPlaylistEvent event) async* {
    if (event is AddSavedPlaylistEvent) {
      yield SavedPlaylistOperationInProgress();
      try {
        await savedPlaylistRepository.savePlaylist(event.playlist);
        List<Playlist> playlists =
            await savedPlaylistRepository.readSavedPlaylists();
        yield SavedPlaylistOperationSuccess(playlists);
      } catch (e) {
        yield SavedPlaylistOperationFailed(e.toString());
      }
    } else if (event is RemoveSavedPlaylistEvent) {
      yield SavedPlaylistOperationInProgress();
      try {
        await savedPlaylistRepository.removePlaylist(event.playlistId);
        List<Playlist> playlists =
            await savedPlaylistRepository.readSavedPlaylists();
        yield SavedPlaylistOperationSuccess(playlists);
      } catch (e) {
        yield SavedPlaylistOperationFailed(e.toString());
      }
    } else if (event is ReadSavedPlaylistsEvent) {
      yield SavedPlaylistOperationInProgress();
      try {
        var playlists = await savedPlaylistRepository.readSavedPlaylists();
        yield SavedPlaylistOperationSuccess(playlists);
      } catch (e) {
        yield SavedPlaylistOperationFailed(e.toString());
      }
    }
  }
}
