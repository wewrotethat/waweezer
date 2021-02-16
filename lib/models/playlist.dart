import 'dart:convert';
import 'dart:core';

import 'package:flutter/foundation.dart';

import 'package:waweezer_mobile/models/song.dart';

class Playlist {
  final String id;
  final String name;
  final String owner;
  final List<Song> songs;
  final List<String> tags;
  Playlist({
    this.id,
    this.name,
    this.owner,
    this.songs,
    this.tags,
  });

  Playlist copyWith({
    String id,
    String name,
    String owner,
    List<Song> songs,
    List<String> tags,
  }) {
    return Playlist(
      id: id ?? this.id,
      name: name ?? this.name,
      owner: owner ?? this.owner,
      songs: songs ?? this.songs,
      tags: tags ?? this.tags,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'owner': owner,
      'songs': songs?.map((x) => x?.toMap())?.toList(),
      'tags': tags,
    };
  }

  factory Playlist.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Playlist(
      id: map['id'],
      name: map['name'],
      owner: map['owner'],
      songs: List<Song>.from(map['songs']?.map((x) => Song.fromMap(x))),
      tags: List<String>.from(map['tags']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Playlist.fromJson(String source) =>
      Playlist.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Playlist(id: $id, name: $name, owner: $owner, songs: $songs, tags: $tags)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Playlist &&
        o.id == id &&
        o.name == name &&
        o.owner == owner &&
        listEquals(o.songs, songs) &&
        listEquals(o.tags, tags);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        owner.hashCode ^
        songs.hashCode ^
        tags.hashCode;
  }
}
