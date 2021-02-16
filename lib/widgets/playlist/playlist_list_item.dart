import 'package:flutter/material.dart';
import 'package:waweezer_mobile/models/playlist.dart';

class PlaylistListItem extends StatelessWidget {
  final Playlist playlist;

  const PlaylistListItem({Key key, this.playlist}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Text(playlist.name),
          Text(playlist.description),
          Text(playlist.numberOfSaves.toString()),
          Text(playlist.tags.length > 0 ? playlist.tags[0] : ""),
        ],
      ),
    );
  }
}
