import 'package:flutter/material.dart';
import 'package:waweezer_mobile/models/song.dart';

class SongListItem extends StatelessWidget {
  final Song song;

  const SongListItem({
    Key key,
    this.song,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Text(song.title),
          Text(song.albumArtURL),
          Text(song.artist),
          Text(song.genre),
          Text(song.youtubeLink),
          Text(song.spotifyLink),
        ],
      ),
    );
  }
}
