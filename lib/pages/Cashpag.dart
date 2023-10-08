import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:playground/Database/sqldb.dart';
import 'package:playground/helper/helper.dart';
import 'package:playground/model/Cash.dart';
import 'package:playground/test/rsa.dart';
import 'package:playground/widgets/ConfirmationAlertDialog.dart';
import 'package:playground/widgets/CustomElevatedButton.dart';
import 'package:playground/widgets/CustomFormTextField.dart';
import 'package:playground/widgets/MyDrawer.dart';

class Cashpag extends StatefulWidget {
  const Cashpag({Key? key}) : super(key: key);

  @override
  _CashpagState createState() => _CashpagState();
}

class _CashpagState extends State<Cashpag> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController item_ = TextEditingController();
  final TextEditingController amount_ = TextEditingController();
  final Sqldb sql_ = Sqldb(); // Database helper for Reservations
  int? sum;
  List<Cash> _Cash = [];
  final Sqldb _sqldb = Sqldb();
  Cash? _selectedCash;

  initState() {
    super.initState();

    _loadCashData();
  }

  void _loadCashData() async {
    var CashData = await _sqldb.getAllDataFromTable<Cash>('Cash', Cash.fromMap);
    int sumField = await _sqldb.sumFieldWithCondition("Cash", "amount");
    print("sumField:::::$sumField");
    setState(() {
      _Cash = CashData;
      sum = sumField;
    });
  }

  Future<void> deletedRows(int? id) async {
    if (id != null) {
      final deletedRows = await _sqldb.deleteRecord(
        tableName: 'Cash',
        primaryKey: 'id',
        id: id.toInt(),
      );
      _loadCashData();
      showToast_(context, "تم الحذف");
    }
  }

  void _deletePerson(int? id) async {
    if (id != null) {
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: AlertDialog(
              contentPadding: EdgeInsets.zero, // إزالة التباعد الافتراضي
              title: Container(
                padding: EdgeInsets.all(16.0), // تعيين التباعد الخارجي للعنوان
                // color: Colors.blue, // لون خلفية العنوان
                child: Text(
                  'تأكيد الحذف',
                  style: TextStyle(
                    fontFamily: Jazeera, // اسم الخط المخصص
                    fontSize: 16.0, // حجم الخط المخصص
                    color: Colors.black, // لون النص
                  ),
                ),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min, // جعل حجم المربع متناسبًا
                children: [
                  Image.asset(
                    'assets/images/Webiconset-Application-Delete.128.png',
                    height: 128.0,
                  ),
                  SizedBox(height: 16.0), // تباعد بين الصورة والنص
                  Text(
                    'هل أنت متأكد من رغبتك في حذف هذا السجل؟',
                    style: TextStyle(
                      fontFamily: Jazeera, // اسم الخط المخصص
                      fontSize: 12.0, // حجم الخط المخصص
                    ),
                  ),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  child: Text(
                    'نعم',
                    style: TextStyle(
                      fontFamily: Jazeera, // اسم الخط المخصص
                      fontSize: 12.0, // حجم الخط المخصص
                    ),
                  ),
                  onPressed: () async {
                    Navigator.of(context).pop(); // إغلاق مربع الحوار
                    await deletedRows(id);
                  },
                ),
                TextButton(
                  child: Text(
                    'لا',
                    style: TextStyle(
                      fontFamily: Jazeera, // اسم الخط المخصص
                      fontSize: 12.0, // حجم الخط المخصص
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(); // إغلاق مربع الحوار
                  },
                ),
              ],
            ),
          );
        },
      );
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
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomFormTextField(
                      labelText: 'البند',
                      text_: item_,
                    ),
                    CustomFormTextField(
                      labelText: 'السعر',
                      text_: amount_,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: 1200,
                      child: CustomElevatedButton(
                        data: "اضافة نقدية جديدة",
                        star: FontAwesomeIcons.add,
                        onChanged_: () async {
                          final myCash = Cash(
                            item: item_.text,
                            amount: amount_.text,
                          );
                          final CashMap = myCash.toMap();
                          final CashTableName = 'Cash';
                          final insertedRow = await sql_.insertData(
                            CashTableName,
                            CashMap,
                          );
                          if (insertedRow != null) {
                            showToast_(context, "تم الأضافة");
                            _loadCashData();
                          } else {
                            print('حدث خطأ أثناء إضافة الصف');
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            // هنا نقوم بوضع ListView.builder داخل SingleChildScrollView
            Directionality(
              textDirection: TextDirection.rtl,
              child: ListView.builder(
                shrinkWrap: true, // هام: يجعل ListView يتكيف مع ارتفاعه الفعلي
                itemCount: _Cash.length,
                physics:
                    NeverScrollableScrollPhysics(), // للتعطيل التمرير الخاص بـ ListView
                itemBuilder: (BuildContext context, int index) {
                  final Cashdata = _Cash[index];
                  return ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Image.asset(
                          'assets/images/coins-icon.png',
                          height: 50.0,
                        ),
                        Text('${Cashdata.item}'),
                        Text('${Cashdata.amount} LE'),
                        IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Color.fromARGB(255, 220, 108, 100),
                          ),
                          onPressed: () => _deletePerson(Cashdata.id),
                        ),
                      ],
                    ),
                    onTap: () {
                      // يمكنك إضافة السلوك الذي تريده هنا عند النقر على العنصر
                      // مثل الانتقال إلى صفحة أخرى أو إجراء إجراء معين.
                    },
                  );
                },
              ),
            ),
            Container(
              width: 1200,
              child: CustomElevatedButton(
                data: "$sum",
                star: FontAwesomeIcons.add,
                onChanged_: () async {
                  try {
                    var d = await _sqldb
                        .executeSqlAndGetList("select * from Reservations");
                    print("d::::::::$d");
                  } catch (e) {
                    print(e);
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
