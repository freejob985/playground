import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:playground/Database/sqldb.dart';
import 'package:playground/pages/Accounts.dart';
import 'package:playground/pages/Add_reservation.dart';
import 'package:playground/pages/Cashpag.dart';
import 'package:playground/pages/Home.dart';
import 'package:playground/pages/addres.dart';
import 'package:playground/pages/adduser.dart';
import 'package:playground/pages/login.dart';
import 'package:playground/pages/reservation.dart';
import 'package:playground/pages/showpeople.dart';
import 'package:playground/pages/updateuser.dart';
import 'package:playground/pages/userpag.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path/path.dart';

var st;
final Sqldb sql_ = Sqldb();
Map<String, dynamic>? _rowData;
void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter is initialized

  if (Platform.isWindows || Platform.isLinux) {
    // Initialize FFI~
    sqfliteFfiInit();
  }

// في داخل دالة أو مكان آخر مناسب
  // PermissionStatus status = await Permission.storage.request();
  // if (status.isGranted) {
  //   // final databaseFactory = databaseFactoryFfi;
  //   databaseFactory = databaseFactoryFfi;

  //   String databasepath = await getDatabasesPath();
  //   String path = join(databasepath, 'wael.db');
  //   File file = File(path);
  // } else if (status.isDenied) {
  //   print('2');
  // }

  // // Change the default factory. On iOS/Android, if not using `sqlite_flutter_lib` you can forget
  // // this step, it will use the sqlite version available on the system.
  databaseFactory = databaseFactoryFfi;
  await fetchRowuser();
  runApp(const starthome());
}

void initState() {
  fetchRowuser();
}

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

  print("st:::::$st");
}

class starthome extends StatelessWidget {
  const starthome({super.key});
//
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        'login': (context) => Login(),
        'Home': (context) => Home(),
        'AddReservation': (context) => AddReservation(),
        'Reservation': (context) => Reservation(),
        'Showpeople': (context) => Showpeople(),
        'Cashpag': (context) => Cashpag(),
        'Accounts': (context) => Accounts(),
        'Userpag': (context) => Userpag(),
        'Adduser': (context) => Adduser(),
        'Updateuser': (context) => Updateuser(),
        'Addres': (context) => Addres(),
      },
      initialRoute: st,
      debugShowCheckedModeBanner: false,
    );
  }
}
