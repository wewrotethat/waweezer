import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waweezer_mobile/bloc/song/song_bloc.dart';
import 'package:waweezer_mobile/bloc/song/song_event.dart';
import 'package:waweezer_mobile/bloc/song/song_state.dart';
import 'package:waweezer_mobile/models/song.dart';

class CreateSong extends StatefulWidget {
  @override
  _CreateSongState createState() => _CreateSongState();
}

class _CreateSongState extends State<CreateSong> {
  TextEditingController titleController;
  TextEditingController albumArtURLController;
  TextEditingController albumNameController;
  TextEditingController artistNameController;
  TextEditingController genreController;
  TextEditingController youtubeLinkController;
  TextEditingController spotifyLinkController;

  @override
  void initState() {
    titleController = TextEditingController();
    albumArtURLController = TextEditingController();
    albumNameController = TextEditingController();
    artistNameController = TextEditingController();
    genreController = TextEditingController();
    youtubeLinkController = TextEditingController();
    spotifyLinkController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add new song"),
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
                        BlocProvider.of<SongBloc>(context).add(CreateSongEvent(
                            Song(
                                album: albumNameController.text,
                                albumArtURL: albumArtURLController.text,
                                artist: artistNameController.text,
                                genre: genreController.text,
                                owner: "TO BE ADDED",
                                spotifyLink: spotifyLinkController.text,
                                title: titleController.text,
                                youtubeLink: youtubeLinkController.text)));
                      },
                      child: Text("Create Song"),
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
