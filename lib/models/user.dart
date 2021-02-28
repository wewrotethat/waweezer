import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:waweezer_mobile/models/name.dart';
import 'package:waweezer_mobile/models/playlist.dart';

class User {
  String id;
  Name name;
  String email;
  String photoPath;
  int age;
  String role;
  int numberOfSongsSubmitted;
  int numberOfPlaylistsCreated;
  List<Playlist> favoritePlaylists;
  User({
    this.id,
    this.name,
    this.email,
    this.photoPath,
    this.age,
    this.role,
    this.numberOfSongsSubmitted,
    this.numberOfPlaylistsCreated,
    this.favoritePlaylists,
  });

  User copyWith({
    String id,
    Name name,
    String email,
    String photoPath,
    int age,
    String role,
    int numberOfSongsSubmitted,
    int numberOfPlaylistsCreated,
    List<Playlist> favoritePlaylists,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      photoPath: photoPath ?? this.photoPath,
      age: age ?? this.age,
      role: role ?? this.role,
      numberOfSongsSubmitted:
          numberOfSongsSubmitted ?? this.numberOfSongsSubmitted,
      numberOfPlaylistsCreated:
          numberOfPlaylistsCreated ?? this.numberOfPlaylistsCreated,
      favoritePlaylists: favoritePlaylists ?? this.favoritePlaylists,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      if (name != null) 'name': name?.toMap(),
      if (email != null) 'email': email,
      if (photoPath != null) 'photoPath': photoPath,
      if (age != null) 'age': age,
      if (role != null) 'role': role,
      if (numberOfPlaylistsCreated != null)
        'numberOfSongsSubmitted': numberOfSongsSubmitted,
      if (numberOfPlaylistsCreated != null)
        'numberOfPlaylistsCreated': numberOfPlaylistsCreated,
      if (favoritePlaylists != null)
        'favoritePlaylists':
            favoritePlaylists?.map((x) => x?.toMap())?.toList(),
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return User(
      id: map['id'],
      name: map['name'] != null ? Name.fromMap(map['name']) : Name(),
      email: map['email'],
      photoPath: map['photoPath'],
      age: map['age'],
      role: map['role'],
      numberOfSongsSubmitted: map['numberOfSongsSubmitted'],
      numberOfPlaylistsCreated: map['numberOfPlaylistsCreated'],
      favoritePlaylists: map['favoritePlaylists'] != null
          ? List<Playlist>.from(
              map['favoritePlaylists']?.map((x) => Playlist.fromMap(x)))
          : [],
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(id: $id, name: $name, email: $email, photoPath: $photoPath, age: $age, role: $role, numberOfSongsSubmitted: $numberOfSongsSubmitted, numberOfPlaylistsCreated: $numberOfPlaylistsCreated, favoritePlaylists: $favoritePlaylists)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is User &&
        o.id == id &&
        o.name == name &&
        o.email == email &&
        o.photoPath == photoPath &&
        o.age == age &&
        o.role == role &&
        o.numberOfSongsSubmitted == numberOfSongsSubmitted &&
        o.numberOfPlaylistsCreated == numberOfPlaylistsCreated &&
        listEquals(o.favoritePlaylists, favoritePlaylists);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        email.hashCode ^
        photoPath.hashCode ^
        age.hashCode ^
        role.hashCode ^
        numberOfSongsSubmitted.hashCode ^
        numberOfPlaylistsCreated.hashCode ^
        favoritePlaylists.hashCode;
  }
}
