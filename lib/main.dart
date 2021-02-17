import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waweezer_mobile/bloc/playlist/playlist_data_provider.dart';
import 'package:waweezer_mobile/bloc/playlist/playlist_event.dart';
import 'package:waweezer_mobile/screens/home.dart';

import 'bloc/playlist/playlist_bloc.dart';
import 'bloc/playlist/playlist_repository.dart';
import 'bloc/song/song_bloc.dart';
import 'bloc/song/song_data_provider.dart';
import 'bloc/song/song_event.dart';
import 'bloc/song/song_repository.dart';
import 'helpers/api_helper.dart';

void main() {
  final apiHelper = APIHelper();
  final songDataProvider = SongDataProvider(apiHelper: apiHelper);
  final songRepository = SongRepository(songDataProvider: songDataProvider);
  final playlistDataProvider = PlaylistDataProvider(apiHelper: apiHelper);
  final playlistRepository =
      PlaylistRepository(playlistDataProvider: playlistDataProvider);
  runApp(MultiBlocProvider(providers: [
    //TODO: remove one of these events
    BlocProvider<SongBloc>(
        create: (context) =>
            SongBloc(songRepository: songRepository)..add(ReadSongsEvent())),
    BlocProvider<PlaylistBloc>(
      create: (context) => PlaylistBloc(playlistRepository: playlistRepository)
        ..add(ReadPlaylistsEvent()),
    ),
  ], child: App()));
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}
