import 'package:intl/intl.dart';

class Reservations_model {
//   CREATE TABLE "Reservations" (
// 	"id"	INTEGER,
// 	"name"	TEXT,
// 	"amount"	TEXT,
// 	"from"	TEXT,
// 	"to"	TEXT,
// 	"day"	TEXT,
// 	"date"	TEXT,
// 	PRIMARY KEY("id" AUTOINCREMENT)
// );

  final int? id;
  final String name;
  final String amount;
  final String from;
  final String to;
  final String day;
  final String datex;
  final String status;
  Reservations_model(
      {this.id,
      required this.name,
      required this.amount,
      required this.from,
      required this.to,
      required this.day,
      required this.datex,
      required this.status});
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'amount': amount ?? '',
      'from': from,
      'to': to,
      'day': day,
      'datex': datex,
      'status': status,
    };
  }

  factory Reservations_model.fromMap(Map<String, dynamic> map) {
    return Reservations_model(
      id: map['id'],
      name: map['name'],
      amount: map['amount'],
      from: map['from'],
      to: map['to'],
      day: map['day'],
      datex: map['datex'],
      status: map['status'],
    );
  }
  
  String getTodayDate() {
    final now = DateTime.now();
    final formatter =
        DateFormat('yyyy-MM-dd'); // يمكنك تغيير التنسيق حسب احتياجاتك
    return formatter.format(now);
  }
}
