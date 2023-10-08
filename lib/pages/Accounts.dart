import 'package:flutter/material.dart';
import 'package:playground/Database/sqldb.dart';
import 'package:playground/helper/helper.dart';
import 'package:playground/model/Accounts_sum.dart';
import 'package:playground/model/Reservations.dart';
import 'package:playground/widgets/MyDrawer.dart';

class Accounts extends StatefulWidget {
  const Accounts({Key? key}) : super(key: key);

  @override
  _AccountsState createState() => _AccountsState();
}

class _AccountsState extends State<Accounts> {
  final Sqldb _sqldb = Sqldb();
  List<Reservations_model> _reservations = [];
  List<Map<String, dynamic>> listOfMaps = [];
  List<AccountsSum> AccountsSum_ = [];
  List<Map<String, dynamic>> Reservations_ = [];

  Map<String, dynamic>? _rowData;

  void initState() {
    super.initState();
    _loadReservations();
  }

  void _loadReservations() async {
    String customQuery =
        'SELECT datex, SUM(amount) AS total_amount FROM Reservations GROUP BY datex';
    List<AccountsSum> people = await _sqldb.getDataWithCustomQuery(customQuery,
        (Map<String, dynamic> result) {
      return AccountsSum.fromMap(result);
    });

    List<Map<String, dynamic>> results =
        await _sqldb.executeSqlAndGetList(customQuery);

    setState(() {
      Reservations_ = results;
      // String myString = listOfMaps[0]['value'][0][2].toString();
      // print("myString:::$myString");
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        elevation: 0,
        backgroundColor: primary,
      ),
      drawer: MyDrawer(),
      body: ListView.builder(
        itemCount: Reservations_.length,
        itemBuilder: (context, index) {
          // الوصول إلى المفتاح 'value' بدلاً من 'total_amount'
          return Padding(
            padding: const EdgeInsets.all(3.0),
            child: SingleChildScrollView(
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(15.0), // تعيين حواف مستديرة هنا
                    color: primary,
                  ),
                  child: ListTile(
                    title: Row(
                      children: [
                        Image.asset(
                          'assets/images/1.png',
                          height: 30,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Text(
                            "${Reservations_[index]['datex']}",
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ),
                        SizedBox(
                          width: 100,
                        ),
                        Text(
                          "${Reservations_[index]['total_amount']}   LE",
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ],
                    ),
                    // onTap: () {
                    //   // إجراء عند النقر على العنصر

                    // },
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
