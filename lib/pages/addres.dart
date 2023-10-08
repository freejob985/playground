import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:playground/Database/sqldb.dart';
import 'package:playground/helper/helper.dart';
import 'package:playground/model/Reservations.dart';
import 'package:playground/pages/reservationsupdate.dart';
import 'package:playground/widgets/ConfirmationAlertDialog.dart';
import 'package:playground/widgets/CustomElevatedButton.dart';
import 'package:playground/widgets/MyDrawer.dart';

class Addres extends StatefulWidget {
  const Addres({Key? key}) : super(key: key);

  @override
  _AddresState createState() => _AddresState();
}

class _AddresState extends State<Addres> {
  @override
  List<Reservations_model> _reservations = [];
  final Sqldb _sqldb = Sqldb();
  Reservations_model? _selectedPerson;
  int? sum;

  void initState() {
    super.initState();
    _loadReservations();
  }

  void _loadReservations() async {
    String today = getFormattedDate();

    final List<Reservations_model> data =
        await _sqldb.getAllDataFromTablewhereArgs(
      'Reservations',
      (Map<String, dynamic> map) => Reservations_model.fromMap(map),
      where: 'datex = ?',
      whereArgs: [today],
    );

    int sumField = await _sqldb.sumFieldWithCondition("Reservations", "amount");

    int result = await _sqldb.sumFieldWithCondition(
      'Reservations', // اسم الجدول
      'amount', // اسم الحقل الذي نريد حساب مجموعه
      conditionField: 'datex', // اسم الحقل الشرطي
      conditionValue: getFormattedDate(), // قيمة الشرط
    );

    setState(() {
      _reservations = data;
      sum = result;
    });
  }

  void _clearForm() {
    setState(() {
      _selectedPerson = null;
    });
  }

  Future<void> deletedRows(int? id) async {
    if (id != null) {
      final deletedRows = await _sqldb.deleteRecord(
        tableName: 'Reservations',
        primaryKey: 'id',
        id: id.toInt(),
      );
      _loadReservations();
      _clearForm();
    }
  }

  void _deletePerson(int? id) async {
    if (id != null) {
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return ConfirmationAlertDialog(
            title: 'تأكيد الحذف',
            content: 'هل أنت متأكد من رغبتك في حذف هذا السجل؟',
            onConfirm: () async {
              // Navigator.of(context).pop(); // إغلاق مربع الحوار بعد الحذف
              await deletedRows(id);
            },
          );
        },
      );
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        elevation: 0,
        backgroundColor: primary,
      ),
      drawer: MyDrawer(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              width: double.infinity,
              child: CustomElevatedButton(
                data: "$sum",
                star: FontAwesomeIcons.add,
                onChanged_: () {
                  try {} catch (e) {
                    print(e);
                  }
                },
              ),
            ),
          ),
          Expanded(
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: ListView.builder(
                itemCount: _reservations.length,
                itemBuilder: (BuildContext context, int index) {
                  final reservation = _reservations[index];
                  Color color = setColors(reservation.status);
                  return Expanded(
                    child: Column(
                      children: [
                        Container(
                          color: Color(0xFFF6F6F6),
                          child: ListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Reservationsupdate(
                                        reservation: reservation),
                                  ));
                            },
                            title: Row(
                              children: [
                                Image.asset(
                                  'assets/images/Chrisbanks2-Cold-Fusion-Hd-Football-soccer.128.png',
                                  height: 50.0,
                                ),
                                SizedBox(width: 3.0),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${reservation.name}',
                                        style: const TextStyle(
                                          fontSize: 15,
                                          color: Colors.black54,
                                          fontFamily: 'Al-Jazeera',
                                        ),
                                        textAlign: TextAlign.right,
                                      ),
                                      Row(
                                        // mainAxisAlignment:
                                        //     MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            'من الساعة ${reservation.from} الى الساعة ${reservation.to}',
                                            style: const TextStyle(
                                              fontSize: 8,
                                              color: Colors.black54,
                                              fontFamily: 'Al-Jazeera',
                                            ),
                                          ),
                                          const SizedBox(width: 4),
                                          Container(
                                            decoration: BoxDecoration(
                                              color: color,
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(3.0),
                                              child: Text(
                                                '${reservation.status}',
                                                style: const TextStyle(
                                                  fontSize: 8,
                                                  color: Colors.white,
                                                  fontFamily: 'Al-Jazeera',
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 35),
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Color.fromARGB(255, 118, 23, 16),
                                    ),
                                    onPressed: () =>
                                        _deletePerson(reservation.id),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        const Divider(
                          color: Colors.white,
                          thickness: 8.0,
                          indent: 16,
                          endIndent: 16,
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
