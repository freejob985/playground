import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:playground/helper/helper.dart';
import 'package:playground/widgets/Control/fotter.dart';
import 'package:playground/widgets/Control/Hedder.dart';
import 'package:playground/widgets/CustomElevatedButton.dart';
import 'package:playground/widgets/MyDrawer.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  var st;
  var st2;
  Map<String, dynamic>? _rowData;
  Future<void> fetchRowuser() async {
    bool hasRows = await sql_.tableHasRows('user');
    if (hasRows) {
      final row = await sql_.getRowById("user", 1);
      _rowData = row;
      String st2 = row?['st'];
      print("st:::::$st");
      if (st2 == "0") {
        st = "login";
      } else {
        st = "Home";
      }
    } else {
      st = "login";
    }
    setState(() {});
    print("st:::::$st");
  }

  void initState() {
    super.initState();
    fetchRowuser();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        elevation: 0,
        backgroundColor: primary,
      ),
      drawer: MyDrawer(),
      body: SingleChildScrollView(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            color: Colors.white,
            child: Column(
              children: [
                // Hedder(),
                Image.asset(
                  'assets/images/sport1.png',
                  height: 350.0,
                ),
                SizedBox(height: 40.0),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      color: Color.fromARGB(255, 255, 255, 255),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(height: 5.0),
                          CustomElevatedButton(
                              data: "اضافة حجز",
                              star: FontAwesomeIcons.add,
                              onChanged_: () {
                                Navigator.pushNamed(context, "AddReservation");
                              }),
                          CustomElevatedButton(
                              data: "حجوزات اليوم",
                              star: FontAwesomeIcons.calendarDay,
                              onChanged_: () {
                                Navigator.pushNamed(context, "Addres");
                              }),
                          CustomElevatedButton(
                              data: "بحث",
                              star: FontAwesomeIcons.search,
                              onChanged_: () {
                                Navigator.pushNamed(context, "Reservation");
                              }),
                        ],
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
