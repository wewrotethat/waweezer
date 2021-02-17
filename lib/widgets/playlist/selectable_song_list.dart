import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waweezer_mobile/bloc/song/song_bloc.dart';
import 'package:waweezer_mobile/bloc/song/song_state.dart';
import 'package:waweezer_mobile/models/song.dart';

class SelectableSongList extends StatefulWidget {
  final Function(List<Song>) onCompletion;
  final List<Song> selectedSongs;

  const SelectableSongList(
      {Key key, @required this.onCompletion, @required this.selectedSongs})
      : super(key: key);
  @override
  _SelectableSongListState createState() => _SelectableSongListState();
}

class _SelectableSongListState extends State<SelectableSongList> {
  List<Song> selectedSongs = List<Song>();

  @override
  void initState() {
    selectedSongs = widget.selectedSongs;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<SongBloc, SongState>(
        builder: (context, state) {
          if (state is MultipleSongsOperationSuccess) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: state.songs.length,
                    itemBuilder: (context, index) {
                      return CheckboxListTile(
                        title: Text(state.songs[index].title),
                        subtitle: Text(state.songs[index].artist),
                        value: selectedSongs
                            .any((song) => song.id == state.songs[index].id),
                        onChanged: (value) {
                          setState(() {
                            if (value) {
                              selectedSongs.add(state.songs[index]);
                            } else {
                              selectedSongs.removeWhere(
                                  (song) => song.id == state.songs[index].id);
                            }
                          });
                        },
                      );
                    },
                  ),
                ),
                FlatButton(
                  child: Text("Done"),
                  onPressed: () {
                    widget.onCompletion(selectedSongs);
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          } else if (state is SongOperationInProgress) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  Text("Loading songs"),
                ],
              ),
            );
          } else {
            return Center(
              child: Text("No songs here"),
            );
          }
        },
        listener: (context, state) {},
      ),
    );
  }
}
