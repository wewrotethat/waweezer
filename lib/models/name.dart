import 'dart:convert';

class Name {
  String first;
  String middle;
  String last;
  Name({
    this.first,
    this.middle,
    this.last,
  });

  Name copyWith({
    String first,
    String middle,
    String last,
  }) {
    return Name(
      first: first ?? this.first,
      middle: middle ?? this.middle,
      last: last ?? this.last,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'first': first,
      'middle': middle,
      'last': last,
    };
  }

  factory Name.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Name(
      first: map['first'],
      middle: map['middle'],
      last: map['last'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Name.fromJson(String source) => Name.fromMap(json.decode(source));

  @override
  String toString() => 'Name(first: $first, middle: $middle, last: $last)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Name &&
        o.first == first &&
        o.middle == middle &&
        o.last == last;
  }

  @override
  int get hashCode => first.hashCode ^ middle.hashCode ^ last.hashCode;
}
