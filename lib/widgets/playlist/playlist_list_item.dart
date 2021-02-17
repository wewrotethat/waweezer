import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waweezer_mobile/bloc/playlist/playlist_bloc.dart';
import 'package:waweezer_mobile/bloc/playlist/playlist_event.dart';
import 'package:waweezer_mobile/models/playlist.dart';
import 'package:waweezer_mobile/screens/playlist/edit_playlist.dart';

class PlaylistListItem extends StatelessWidget {
  final Playlist playlist;

  const PlaylistListItem({Key key, this.playlist}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPressStart: (_) async {
        await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
                title: Text("Are you sure?"),
                content: Text("Do you really want to delete the playlist \"${playlist.name}\"?"),
                actions: [
                  FlatButton(
                    onPressed: () {
                      BlocProvider.of<PlaylistBloc>(context)
                          .add(DeletePlaylistEvent(playlist.id));
                      Navigator.of(context).pop();
                    },
                    child: Text("Yes"),
                  ),
                  FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("No"),
                  ),
                ]);
          },
        );
      },
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return EditPlaylist(playlistToBeEdited: playlist);
            },
          ),
        );
      },
      child: Card(
        child: Column(
          children: [
            Text(playlist.name),
            Text(playlist.description),
            Text('${playlist.numberOfSaves}'),
            Text(playlist.tags.length > 0 ? playlist.tags.join(", ") : ""),
          ],
        ),
      ),
    );
  }
}
