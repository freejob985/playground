class Cash {
  final int? id;
  final String item;
  final String amount;

  Cash({this.id, required this.item, required this.amount});

  Map<String, dynamic> toMap() {
    return {
      'item': item,
      'amount': amount,
    };
  }

  factory Cash.fromMap(Map<String, dynamic> map) {
    return Cash(
      id: map['id'],
      item: map['item'],
      amount: map['amount'],
    );
  }
}
