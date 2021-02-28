import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waweezer_mobile/bloc/song/song_bloc.dart';
import 'package:waweezer_mobile/bloc/song/song_state.dart';
import 'package:waweezer_mobile/widgets/song/song_list_item.dart';

class SongsList extends StatefulWidget {
  @override
  _SongsListState createState() => _SongsListState();
}

class _SongsListState extends State<SongsList> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SongBloc, SongState>(
      builder: (context, state) => Container(
        child: state is MultipleSongsOperationSuccess
            ? ListView.builder(
                itemCount: state.songs.length,
                itemBuilder: (context, index) =>
                    SongListItem(song: state.songs[index]),
              )
            : Container(
                child: Center(
                  child: (state is SongOperationInProgress)
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(),
                            Text("Loading songs"),
                          ],
                        )
                      : state is SongOperationFailed
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
