import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waweezer_mobile/bloc/playlist/playlist_bloc.dart';
import 'package:waweezer_mobile/bloc/playlist/playlist_state.dart';
import 'package:waweezer_mobile/widgets/playlist/playlist_list_item.dart';

class PlaylistsList extends StatefulWidget {
  @override
  _PlaylistsListState createState() => _PlaylistsListState();
}

class _PlaylistsListState extends State<PlaylistsList> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PlaylistBloc, PlaylistState>(
      builder: (context, state) => Container(
        child: state is MultiplePlaylistsOperationSuccess
            ? ListView.builder(
                itemCount: state.playlists.length,
                itemBuilder: (context, index) =>
                    PlaylistListItem(playlist: state.playlists[index]),
              )
            : Container(
                child: Center(
                  child: (state is PlaylistOperationInProgress)
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(),
                            Text("Loading playlists"),
                          ],
                        )
                      : state is PlaylistOperationFailed
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
