import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waweezer_mobile/bloc/saved_playlist/saved_playlist_bloc.dart';
import 'package:waweezer_mobile/bloc/saved_playlist/saved_playlist_event.dart';
import 'package:waweezer_mobile/models/playlist.dart';

class SavedPlaylistListItem extends StatelessWidget {
  final Playlist playlist;

  const SavedPlaylistListItem({Key key, @required this.playlist})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: IconButton(
          icon: Icon(Icons.remove),
          onPressed: () {
            BlocProvider.of<SavedPlaylistBloc>(context)
                .add(RemoveSavedPlaylistEvent(playlist.id));
          }),
      title: Text(playlist.name),
      subtitle: Text(playlist.description),
    );
  }
}
