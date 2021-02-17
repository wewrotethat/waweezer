import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waweezer_mobile/bloc/song/song_bloc.dart';
import 'package:waweezer_mobile/bloc/song/song_event.dart';
import 'package:waweezer_mobile/models/song.dart';
import 'package:waweezer_mobile/screens/song/edit_song.dart';

class SongListItem extends StatelessWidget {
  final Song song;

  const SongListItem({
    Key key,
    this.song,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPressStart: (_) async {
        await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
                title: Text("Are you sure?"),
                content: Text(
                    "Do you really want to delete ${song.title} by ${song.artist}"),
                actions: [
                  FlatButton(
                    onPressed: () {
                      BlocProvider.of<SongBloc>(context)
                          .add(DeleteSongEvent(song.id));
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
              return EditSong(songToBeEdited: song);
            },
          ),
        );
      },
      child: Card(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(song.title),
              Text(song.albumArtURL),
              Text(song.album),
              Text(song.artist),
              Text(song.genre),
              Text(song.youtubeLink),
              Text(song.spotifyLink),
            ],
          ),
        ),
      ),
    );
  }
}
