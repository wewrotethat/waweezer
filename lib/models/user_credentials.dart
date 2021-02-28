import 'dart:convert';

class UserCredentials {
  String email;
  String password;
  UserCredentials({
    this.email,
    this.password,
  });

  UserCredentials copyWith({
    String email,
    String password,
  }) {
    return UserCredentials(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
    };
  }

  factory UserCredentials.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return UserCredentials(
      email: map['email'],
      password: map['password'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserCredentials.fromJson(String source) =>
      UserCredentials.fromMap(json.decode(source));

  @override
  String toString() => 'UserCredentials(email: $email, password: $password)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is UserCredentials && o.email == email && o.password == password;
  }

  @override
  int get hashCode => email.hashCode ^ password.hashCode;
}
