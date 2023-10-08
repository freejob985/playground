import 'package:flutter/material.dart';
import 'package:playground/Database/sqldb.dart';
import 'package:playground/helper/helper.dart';
import 'package:playground/widgets/Control/fotter.dart';
import 'package:playground/widgets/Control/Hedder.dart';
import 'package:playground/widgets/CustomFormTextField.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final Sqldb sql_ = Sqldb(); // Database helper for Reservations
  List<Map<String, dynamic>> user_ = [];
  final int idToSearch = 1;
  Map<String, dynamic>? _rowData;

  void initState() {
    super.initState();
    fetchRowData();
  }

  void _loadReservations() async {
    String customQuery = 'select * from user';

    List<Map<String, dynamic>> results =
        await sql_.executeSqlAndGetList(customQuery);

    setState(() {
      user_ = results;
      print("user:::::${user_[0]['name']}");
    });
  }

  Future<void> simulateLoading() async {
    await Future.delayed(Duration(seconds: 2));
  }

  Future<void> fetchRowData() async {
    bool hasRows = await sql_.tableHasRows('user');
    if (hasRows) {
      final row = await sql_.getRowById("user", idToSearch);
      setState(() {
        _rowData = row;
      });
    } else {
      // المتغير هو null، يمكنك التعامل مع هذه الحالة هنا
      print('المتغير هو null');
    }
  }

  void _login() async {
    bool hasRows = await sql_.tableHasRows('user');
    String username = usernameController.text;
    String password = passwordController.text;

    if (hasRows) {
      fetchRowData();
      int id = _rowData?['id'];
      String name = _rowData?['name'];
      String pas = _rowData?['pas'];

      if (username == name && password == pas) {
        await sql_.updateRow("user", {'st': 1}, 1);
        Navigator.pushNamed(context, "Home");
      } else {
        showToast_(context, "كلمة المرور غير صحيحة");
      }
    } else {
      if (username == "admin" && password == "admin") {
        Navigator.pushNamed(context, "Adduser");
      } else {
        showToast_(context, "كلمة المرور غير صحيحة");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: FutureBuilder(
          future: simulateLoading(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Text('حدث خطأ: ${snapshot.error}');
            } else {
              return Container(
                color: Colors.white,
                child: SingleChildScrollView(
                  child: Container(
                    color: Colors.white,
                    child: Column(
                      children: [
                        Hedder(),
                        SizedBox(height: 20.0),
                        Image.asset(
                          'assets/images/17.jpg',
                          height: 400.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              CustomFormTextField(
                                  labelText: "اسم المستخدم",
                                  text_: usernameController),
                              SizedBox(height: 20.0),
                              CustomFormTextField(
                                  labelText: "كلمة المرور",
                                  text_: passwordController),
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
                                child: Text('تسجيل الدخول'),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 26.0),
                      ],
                    ),
                  ),
                ),
              );
            }
          },
        ));
  }
}
