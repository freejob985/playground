import 'package:flutter/material.dart';
import 'package:playground/Database/sqldb.dart';
import 'package:playground/helper/helper.dart';
import 'package:playground/model/user.dart';
import 'package:playground/widgets/Control/Hedder.dart';
import 'package:playground/widgets/CustomFormTextField.dart';
import 'package:playground/widgets/MyDrawer.dart';

class Updateuser extends StatefulWidget {
  const Updateuser({Key? key}) : super(key: key);

  @override
  _UpdateuserState createState() => _UpdateuserState();
}

class _UpdateuserState extends State<Updateuser> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final Sqldb sql_ = Sqldb();
  Map<String, dynamic>? _rowData;

  // Database helper for Reservations
  void initState() {
    super.initState();
    fetchRowData();
  }

  Future<void> fetchRowData() async {
    final row = await sql_.getRowById("user", 1);
    setState(() {
      _rowData = row;
      String name = _rowData?['name'];
      String pas = _rowData?['pas'];
      usernameController.text = name;
      passwordController.text = pas;
    });
  }

  Future<void> _updateRecord() async {
    try {
      final updatedUser = User(
        // يمكنك تحديث القيم في هذا المكان باستخدام قيم حقول النص في الاستمارة
        id: 1, // قم بتوفير القيمة الصحيحة للمفتاح الرئيسي
        name: usernameController.text,
        pas: passwordController.text,
      );
      // قم بإجراء التحديث باستخدام الدالة المُعدلة
      final updatedRows = await sql_.updateRecord(
        'user', // اسم الجدول
        updatedUser.toMap(), // تحويل الكائن إلى Map
        'id', // اسم المفتاح الرئيسي
        1, // القيمة المراد تحديثها
      );
      if (updatedRows > 0) {
        showToast_(context, " تم التعديل علي السجل");
      } else {
        print('لا');
      }
    } catch (e) {
      print("print::::::::::$e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        elevation: 0,
        backgroundColor: primary,
      ),
      drawer: MyDrawer(),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Hedder(),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 50.0),
                    CustomFormTextField(
                        labelText: "اسم المستخدم", text_: usernameController),
                    SizedBox(height: 20.0),
                    CustomFormTextField(
                        labelText: "كلمة المرور", text_: passwordController),
                    SizedBox(height: 20.0),
                    ElevatedButton(
                      onPressed: _updateRecord,
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFF383780), // لون الخلفية
                        onPrimary: Colors.white, // لون الكتابة
                        elevation: 0, // الارتفاع

                        textStyle: TextStyle(
                          fontFamily: Jazeera, // الخط
                        ),
                      ),
                      child: Text('تحديث المستخدم'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _login() {}
}
