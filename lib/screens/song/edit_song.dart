import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waweezer_mobile/bloc/song/song_bloc.dart';
import 'package:waweezer_mobile/bloc/song/song_event.dart';
import 'package:waweezer_mobile/bloc/song/song_state.dart';
import 'package:waweezer_mobile/models/song.dart';

class EditSong extends StatefulWidget {
  final Song songToBeEdited;

  const EditSong({Key key, this.songToBeEdited}) : super(key: key);
  @override
  _EditSongState createState() => _EditSongState();
}

class _EditSongState extends State<EditSong> {
  TextEditingController titleController = TextEditingController();
  TextEditingController albumArtURLController = TextEditingController();
  TextEditingController albumNameController = TextEditingController();
  TextEditingController artistNameController = TextEditingController();
  TextEditingController genreController = TextEditingController();
  TextEditingController youtubeLinkController = TextEditingController();
  TextEditingController spotifyLinkController = TextEditingController();

  @override
  void initState() {
    //set inital form values
    titleController.text = widget.songToBeEdited.title;
    albumArtURLController.text = widget.songToBeEdited.albumArtURL;
    albumNameController.text = widget.songToBeEdited.album;
    artistNameController.text = widget.songToBeEdited.artist;
    genreController.text = widget.songToBeEdited.genre;
    youtubeLinkController.text = widget.songToBeEdited.youtubeLink;
    spotifyLinkController.text = widget.songToBeEdited.spotifyLink;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit ${widget.songToBeEdited.title}"),
        centerTitle: true,
      ),
      body: BlocConsumer<SongBloc, SongState>(
        builder: (context, state) => SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Form(
                child: Column(
                  children: [
                    TextFormField(
                      controller: titleController,
                      decoration: InputDecoration(labelText: "Title"),
                    ),
                    TextFormField(
                      controller: albumNameController,
                      decoration: InputDecoration(labelText: "Album Name"),
                    ),
                    TextFormField(
                      controller: albumArtURLController,
                      decoration: InputDecoration(labelText: "Album Art URL"),
                    ),
                    TextFormField(
                      controller: artistNameController,
                      decoration: InputDecoration(labelText: "Artist's name"),
                    ),
                    TextFormField(
                      controller: genreController,
                      decoration: InputDecoration(labelText: "Genre"),
                    ),
                    TextFormField(
                      controller: youtubeLinkController,
                      decoration: InputDecoration(labelText: "Youtube Link"),
                    ),
                    TextFormField(
                      controller: spotifyLinkController,
                      decoration: InputDecoration(labelText: "Spotify Link"),
                    ),
                    RaisedButton(
                      onPressed: () {
                        BlocProvider.of<SongBloc>(context).add(UpdateSongEvent(
                            songId: widget.songToBeEdited.id,
                            song: Song(
                                album: albumNameController.text,
                                albumArtURL: albumArtURLController.text,
                                artist: artistNameController.text,
                                genre: genreController.text,
                                owner: "TO BE ADDED",
                                spotifyLink: spotifyLinkController.text,
                                title: titleController.text,
                                youtubeLink: youtubeLinkController.text)));
                      },
                      child: Text("Update Song"),
                    )
                  ],
                ),
              ),
              if (state is SongOperationInProgress)
                CircularProgressIndicator()
              else
                Container()
            ],
          ),
        ),
        listener: (context, state) {
          if (state is MultipleSongsOperationSuccess) {
            Navigator.of(context).pop();
          }
        },
      ),
    );
  }
}
