class People {
// CREATE TABLE "People" (
// 	"id"	INTEGER,
// 	"name"	TEXT,
// 	PRIMARY KEY("id" AUTOINCREMENT);
// );

  final int? id;
  final String name;
  People({this.id, required this.name});


  Map<String, dynamic> toMap() {
    return {
      'name': name,
    };
  }

    factory People.fromMap(Map<String, dynamic> map) {
    return People(
      id: map['id'],
      name: map['name'],
    );
  }
}