import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waweezer_mobile/bloc/playlist/playlist_bloc.dart';
import 'package:waweezer_mobile/bloc/playlist/playlist_event.dart';
import 'package:waweezer_mobile/bloc/playlist/playlist_state.dart';
import 'package:waweezer_mobile/models/playlist.dart';
import 'package:waweezer_mobile/models/song.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:waweezer_mobile/widgets/playlist/selectable_song_list.dart';
import 'package:waweezer_mobile/widgets/song/song_list_item.dart';

class EditPlaylist extends StatefulWidget {
  final Playlist playlistToBeEdited;

  const EditPlaylist({Key key, @required this.playlistToBeEdited})
      : super(key: key);
  @override
  _EditPlaylistState createState() => _EditPlaylistState();
}

class _EditPlaylistState extends State<EditPlaylist> {
  TextEditingController nameInputController = TextEditingController();
  TextEditingController descriptionInputController = TextEditingController();
  List<String> tags = List<String>();
  List<Song> songs = List<Song>();
  onSelectionCompletion(List<Song> _songs) {
    setState(() {
      songs = _songs;
    });
  }

  @override
  void initState() {
    super.initState();
    nameInputController.text = widget.playlistToBeEdited.name;
    descriptionInputController.text = widget.playlistToBeEdited.description;
    tags = widget.playlistToBeEdited.tags;
    songs = widget.playlistToBeEdited.songs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit a playlist"),
        centerTitle: true,
      ),
      body: BlocConsumer<PlaylistBloc, PlaylistState>(
        builder: (context, state) => SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      decoration: InputDecoration(labelText: "Name"),
                      controller: nameInputController,
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: "Description"),
                      controller: descriptionInputController,
                    ),
                    Tags(
                      itemCount: tags.length,
                      textField: TagsTextField(
                        helperText: "Tags",
                        onSubmitted: (String tag) {
                          setState(() {
                            tags.add(tag);
                          });
                        },
                      ),
                      itemBuilder: (index) => ItemTags(
                        title: tags[index],
                        index: index,
                        onPressed: (tag) {
                          setState(() {
                            tags.remove(tag.title);
                          });
                        },
                      ),
                    ),
                    if (songs.isNotEmpty)
                      Container(
                        height: 200,
                        child: ListView.builder(
                          itemCount: songs.length,
                          itemBuilder: (context, index) {
                            return SongListItem(song: songs[index]);
                          },
                          scrollDirection: Axis.horizontal,
                        ),
                      ),
                    RaisedButton(
                        child: Text("Modify Songs"),
                        onPressed: () async {
                          await showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return SelectableSongList(
                                    selectedSongs: songs,
                                    onCompletion: onSelectionCompletion);
                              });
                        }),
                    RaisedButton(
                        child: Text("Update Playlist"),
                        onPressed: () async {
                          BlocProvider.of<PlaylistBloc>(context).add(
                              UpdatePlaylistEvent(
                                  playlistId: widget.playlistToBeEdited.id,
                                  playlist: Playlist(
                                      description:
                                          descriptionInputController.text,
                                      name: nameInputController.text,
                                      songs: songs,
                                      tags: tags,
                                      numberOfSaves: 0,
                                      owner: "TO BE ADDED")));
                        })
                  ],
                ),
              ),
              if (state is PlaylistOperationInProgress)
                CircularProgressIndicator()
              else
                Container()
            ],
          ),
        ),
        listener: (context, state) {
          if (state is MultiplePlaylistsOperationSuccess) {
            Navigator.of(context).pop();
          }
        },
      ),
    );
  }
}
