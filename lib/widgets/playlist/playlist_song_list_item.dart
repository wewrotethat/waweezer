import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waweezer_mobile/bloc/authentication/authentication_bloc.dart';
import 'package:waweezer_mobile/bloc/authentication/authentication_state.dart';
import 'package:waweezer_mobile/models/song.dart';

class PlaylistSongListItem extends StatelessWidget {
  final Song song;

  const PlaylistSongListItem({
    Key key,
    this.song,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        if (state is UserLoggedIn) {
          return Card(
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
          );
        }
        return Container();
      },
    );
  }
}
