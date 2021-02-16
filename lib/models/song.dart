import 'dart:convert';

class Song {
  final String id;
  final String album;
  final String albumArtURL;
  final String artist;
  final String genre;
  final String owner;
  final String spotifyLink;
  final String title;
  final String youtubeLink;
  Song({
    this.id,
    this.album,
    this.albumArtURL,
    this.artist,
    this.genre,
    this.owner,
    this.spotifyLink,
    this.title,
    this.youtubeLink,
  });

  Song copyWith({
    String id,
    String album,
    String albumArtURL,
    String artist,
    String genre,
    String owner,
    String spotifyLink,
    String title,
    String youtubeLink,
  }) {
    return Song(
      id: id ?? this.id,
      album: album ?? this.album,
      albumArtURL: albumArtURL ?? this.albumArtURL,
      artist: artist ?? this.artist,
      genre: genre ?? this.genre,
      owner: owner ?? this.owner,
      spotifyLink: spotifyLink ?? this.spotifyLink,
      title: title ?? this.title,
      youtubeLink: youtubeLink ?? this.youtubeLink,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'album': album,
      'albumArtURL': albumArtURL,
      'artist': artist,
      'genre': genre,
      'owner': owner,
      'spotifyLink': spotifyLink,
      'title': title,
      'youtubeLink': youtubeLink,
    };
  }

  factory Song.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Song(
      id: map['id'],
      album: map['album'],
      albumArtURL: map['albumArtURL'],
      artist: map['artist'],
      genre: map['genre'],
      owner: map['owner'],
      spotifyLink: map['spotifyLink'],
      title: map['title'],
      youtubeLink: map['youtubeLink'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Song.fromJson(String source) => Song.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Song(id: $id, album: $album, albumArtURL: $albumArtURL, artist: $artist, genre: $genre, owner: $owner, spotifyLink: $spotifyLink, title: $title, youtubeLink: $youtubeLink)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Song &&
        o.id == id &&
        o.album == album &&
        o.albumArtURL == albumArtURL &&
        o.artist == artist &&
        o.genre == genre &&
        o.owner == owner &&
        o.spotifyLink == spotifyLink &&
        o.title == title &&
        o.youtubeLink == youtubeLink;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        album.hashCode ^
        albumArtURL.hashCode ^
        artist.hashCode ^
        genre.hashCode ^
        owner.hashCode ^
        spotifyLink.hashCode ^
        title.hashCode ^
        youtubeLink.hashCode;
  }
}
