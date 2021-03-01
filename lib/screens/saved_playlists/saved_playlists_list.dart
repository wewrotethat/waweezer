import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waweezer_mobile/bloc/saved_playlist/saved_playlist_bloc.dart';
import 'package:waweezer_mobile/bloc/saved_playlist/saved_playlist_state.dart';
import 'package:waweezer_mobile/widgets/saved_playlists/saved_playlist_list_item.dart';

class SavedPlaylistsList extends StatefulWidget {
  @override
  _SavedPlaylistsListState createState() => _SavedPlaylistsListState();
}

class _SavedPlaylistsListState extends State<SavedPlaylistsList> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SavedPlaylistBloc, SavedPlaylistState>(
      builder: (context, state) => Container(
        child: state is SavedPlaylistOperationSuccess
            ? ListView.builder(
                itemCount: state.playlists.length,
                itemBuilder: (context, index) =>
                    SavedPlaylistListItem(playlist: state.playlists[index]),
              )
            : Container(
                child: Center(
                  child: (state is SavedPlaylistOperationInProgress)
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(),
                            Text("Loading playlists"),
                          ],
                        )
                      : state is SavedPlaylistOperationFailed
                          ? Text(state.error)
                          : Text(state.toString()),
                ),
              ),
      ),
      listener: (context, state) {
        //TODO: show error dialog and reload on retry or exit
      },
    );
  }
}
