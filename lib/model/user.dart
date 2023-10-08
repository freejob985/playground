class User {
  final int? id;
  final String name;
  final String pas;
  final String? st;
  User({this.id, required this.name, required this.pas, this.st});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'pas': pas,
      'st': st,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      pas: map['pas'],
      st: map['st'],
    );
  }
}
