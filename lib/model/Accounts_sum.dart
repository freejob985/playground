class AccountsSum {

  final String datex   ;
  final int total_amount     ;
  AccountsSum({required this.datex,required this.total_amount});

  factory AccountsSum.fromMap(Map<String, dynamic> map) {
    return AccountsSum(
      datex: map['datex'],
      total_amount: map['total_amount'],
    );
  }
}