import 'package:flutter/material.dart';
import 'package:playground/Database/sqldb.dart';
import 'package:playground/helper/helper.dart';
import 'package:playground/model/People.dart';
import 'package:playground/widgets/ConfirmationAlertDialog.dart';
import 'package:playground/widgets/MyDrawer.dart';

class Showpeople extends StatefulWidget {
  const Showpeople({Key? key}) : super(key: key);

  @override
  _ShowpeopleState createState() => _ShowpeopleState();
}

class _ShowpeopleState extends State<Showpeople> {
  List<People> _People = [];
  final Sqldb _sqldb = Sqldb();
  People? _selectedPeople;
  void initState() {
    super.initState();
    _loadReservations();
  }

  Future<void> deletedRows(int? id) async {
    if (id != null) {
      final deletedRows = await _sqldb.deleteRecord(
        tableName: 'People',
        primaryKey: 'id',
        id: id.toInt(),
      );
      _loadReservations();
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

  void _loadReservations() async {
    var PeopleData =
        await _sqldb.getAllDataFromTable<People>('People', People.fromMap);

    setState(() {
      _People = PeopleData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        elevation: 0,
        backgroundColor: primary,
      ),
      drawer: MyDrawer(),
      body: Container(
        color: Color.fromARGB(4, 42, 6, 6),
        child: ListView.builder(
            itemCount: _People.length,
            itemBuilder: (BuildContext context, int index) {
              final Peopledata = _People[index];
              return Container(
                color: Color.fromARGB(0, 100, 79, 79),
                child: Column(
                  children: [
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: Container(
                        color: Color.fromARGB(0, 100, 79, 79),
                        child: ListTile(
                          title: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Image.asset(
                                    'assets/images/Sport-Football-Player-Male-Dark-icon.png',
                                    height: 50.0,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  '${Peopledata.name}',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black54,
                                    fontFamily: 'Al-Jazeera',
                                  ),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 140),
                                child: IconButton(
                                  icon: Icon(
                                    Icons.delete,
                                    color:
                                        const Color.fromARGB(255, 118, 23, 16),
                                  ),
                                  onPressed: () => _deletePerson(Peopledata.id),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            }),
      ),
    );
  }
}
