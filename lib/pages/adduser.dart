import 'package:flutter/material.dart';
import 'package:playground/Database/sqldb.dart';
import 'package:playground/helper/helper.dart';
import 'package:playground/model/user.dart';
import 'package:playground/widgets/Control/Hedder.dart';
import 'package:playground/widgets/Control/fotter.dart';
import 'package:playground/widgets/CustomFormTextField.dart';
import 'package:playground/widgets/MyDrawer.dart';

class Adduser extends StatefulWidget {
  const Adduser({Key? key}) : super(key: key);

  @override
  _AdduserState createState() => _AdduserState();
}

class _AdduserState extends State<Adduser> {
  @override
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final Sqldb sql_ = Sqldb(); // Database helper for Reservations

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
              // Image.asset(
              //   'assets/images/17.jpg',
              //   height: 250.0,
              // ),
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
                      onPressed: _login,
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFF383780), // لون الخلفية
                        onPrimary: Colors.white, // لون الكتابة
                        elevation: 0, // الارتفاع

                        textStyle: TextStyle(
                          fontFamily: Jazeera, // الخط
                        ),
                      ),
                      child: Text('تسجيل مستخدم جديد'),
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

  void _login() async {
    final myuser = User(
        name: usernameController.text, pas: passwordController.text, st: "1");
    final userMap = myuser.toMap();
    final userTableName = 'user';
    final insertedRow = await sql_.insertData(
      userTableName,
      userMap,
    );
    if (insertedRow != null) {
      Navigator.pushNamed(context, "Home");
    } else {
      showToast_(context, "هناك خطأ ");
    }
  }
}
