import 'dart:convert';

import 'package:waweezer_mobile/models/user.dart';
import 'package:waweezer_mobile/models/user_credentials.dart';

class SignUpDTO {
  User user;
  UserCredentials userCredentials;
  SignUpDTO({
    this.user,
    this.userCredentials,
  });

  SignUpDTO copyWith({
    User user,
    UserCredentials userCredentials,
  }) {
    return SignUpDTO(
      user: user ?? this.user,
      userCredentials: userCredentials ?? this.userCredentials,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'user': user?.toMap(),
      'userCredentials': userCredentials?.toMap(),
    };
  }

  factory SignUpDTO.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return SignUpDTO(
      user: User.fromMap(map['user']),
      userCredentials: UserCredentials.fromMap(map['userCredentials']),
    );
  }

  String toJson() => json.encode(toMap());

  factory SignUpDTO.fromJson(String source) =>
      SignUpDTO.fromMap(json.decode(source));

  @override
  String toString() =>
      'SignUpDTO(user: $user, userCredentials: $userCredentials)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is SignUpDTO &&
        o.user == user &&
        o.userCredentials == userCredentials;
  }

  @override
  int get hashCode => user.hashCode ^ userCredentials.hashCode;
}
