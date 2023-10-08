import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:playground/Database/sqldb.dart';
import 'package:playground/helper/helper.dart';
import 'package:playground/model/Reservations.dart';
import 'package:playground/pages/reservationsupdate.dart';
import 'package:playground/widgets/ConfirmationAlertDialog.dart';
import 'package:playground/widgets/CustomElevatedButton.dart';
import 'package:playground/widgets/MyDrawer.dart';

Color? colors = null;

class Reservation extends StatefulWidget {
  const Reservation({Key? key}) : super(key: key);

  @override
  _ReservationState createState() => _ReservationState();
}

class _ReservationState extends State<Reservation> {
  Color? colors;

  TextEditingController _searchController = TextEditingController();
  List<Reservations_model> _reservations = [];
  final Sqldb _sqldb = Sqldb();
  Reservations_model? _selectedPerson;
  int? sum;

  @override
  void initState() {
    super.initState();
    _loadReservations();
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
              await deletedRows(id);
            },
          );
        },
      );
    }
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

  void _clearForm() {
    setState(() {
      _selectedPerson = null;
      _searchController.clear();
    });
  }

  void _loadReservations() async {
    var reservationsData =
        await _sqldb.getAllDataFromTablewhereArgs<Reservations_model>(
      'Reservations',
      Reservations_model.fromMap,
    );

    int sumField = await _sqldb.sumFieldWithCondition("Reservations", "amount");

    setState(() {
      _reservations = reservationsData;
      sum = sumField;
    });
  }

  Future<void> _search() async {
    final query = _searchController.text;

    if (query.isNotEmpty) {
      final searchCondition = {
        'name': '%$query%',
      };

      final searchResults = await _sqldb.searchItems<Reservations_model>(
        'reservations',
        searchCondition,
        Reservations_model.fromMap,
      );

      setState(() {
        _reservations = searchResults!;
      });
    } else {
      _loadReservations();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('الحجوزات'),
        elevation: 0,
        backgroundColor: primary,
      ),
      drawer: MyDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'ابحث هنا...',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    onChanged: (_) => _search(),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _reservations.length,
              itemBuilder: (BuildContext context, int index) {
                final reservation = _reservations[index];
                Color color = setColors(reservation.status);

                return Column(
                  children: [
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: Container(
                        color: Color(0xFFF6F6F6),
                        child: ListTile(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Reservationsupdate(
                                  reservation: reservation,
                                ),
                              ),
                            );
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          'من الساعة ${reservation.from} الى الساعة ${reservation.to}',
                                          style: const TextStyle(
                                            fontSize: 10,
                                            color: Colors.black54,
                                            fontFamily: 'Al-Jazeera',
                                          ),
                                        ),
                                        const SizedBox(width: 4),
                                        Container(
                                          decoration: BoxDecoration(
                                            color:
                                                color, // تغيير لون الحالة هنا
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(2.0),
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
                                padding: const EdgeInsets.only(right: 30),
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
                    ),
                    const Divider(
                      color: Colors.white,
                      thickness: 8.0,
                      indent: 16,
                      endIndent: 16,
                    )
                  ],
                );
              },
            ),
          ),
          Container(
            width: double.infinity,
            child: CustomElevatedButton(
              data: "$sum",
              star: FontAwesomeIcons.moneyBill,
              onChanged_: () {
                try {} catch (e) {
                  print(e);
                }
              },
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
