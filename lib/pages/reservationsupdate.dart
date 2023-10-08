// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:day_night_time_picker/lib/constants.dart';
import 'package:day_night_time_picker/lib/daynight_timepicker.dart';
import 'package:day_night_time_picker/lib/state/time.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:playground/Database/sqldb.dart';

import 'package:playground/helper/helper.dart';
import 'package:playground/model/Reservations.dart';
import 'package:playground/widgets/CustomElevatedButton.dart';
import 'package:playground/widgets/CustomFormTextField.dart';
import 'package:playground/widgets/MyDrawer.dart';

class Reservationsupdate extends StatefulWidget {
  final Reservations_model? reservation;

  const Reservationsupdate({this.reservation});

  @override
  _ReservationsupdateState createState() => _ReservationsupdateState();
}

class _ReservationsupdateState extends State<Reservationsupdate> {
  final _formKey = GlobalKey<FormState>();
  late final Reservations_model? reservation;
  final TextEditingController name_ = TextEditingController();
  final TextEditingController from_ = TextEditingController();
  final TextEditingController to_ = TextEditingController();
  final TextEditingController amount_ = TextEditingController();
  final TextEditingController day_ = TextEditingController();
  final TextEditingController status_ = TextEditingController();
  String _selectedDay = '';
  Time startHour = Time(hour: 11, minute: 00);
  Time endHour = Time(hour: 12, minute: 00);
  final Sqldb _sqldb = Sqldb();
  void _selectPerson(Reservations_model reservation) {
    setState(() {
      name_.text = reservation.name;
      from_.text = reservation.from;
      to_.text = reservation.to;
      amount_.text = reservation.amount;
      day_.text = reservation.day;
      status_.text = reservation.status;
    });
  }

  void initState() {
    super.initState();
    reservation = widget
        .reservation; // تهيئة المتغير reservation بقيمة widget.reservation
    _selectPerson(reservation!);
  }

  void onTimeChanged(Time newTime) {
    setState(() {
      startHour = newTime;
      endHour = newTime;
    });
  }

  void showPicker_(BuildContext context, Time t, TextEditingController inp) {
    Navigator.of(context).push(
      showPicker(
        showSecondSelector: true,
        context: context,
        value: t,
        onChange: onTimeChanged,
        minuteInterval: TimePickerInterval.FIVE,
        // Optional onChange to receive value as DateTime
        onChangeDateTime: (DateTime dateTime) {
          String formattedTime = formatDateTime(dateTime);
          inp.text = formattedTime;
        },
      ),
    );
  }

  void _showWeekDaysDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Container(
            // تعيين اللون الذي تريده هنا
            child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: Container(
                color: Color(0xFF383780),
                width: double.infinity,
                child: Text(
                  'أيام الأسبوع',
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.white,
                    fontFamily: 'Al-Jazeera',
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDayButton('السبت'),
              _buildDayButton('الأحد'),
              _buildDayButton('الاثنين'),
              _buildDayButton('الثلاثاء'),
              _buildDayButton('الأربعاء'),
              _buildDayButton('الخميس'),
              _buildDayButton('الجمعة'),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDayButton(String day) {
    return ListTile(
      title: Text(
        day,
        style: TextStyle(
          fontSize: 13,
          color: Colors.black54,
          fontFamily: 'Al-Jazeera',
        ),
        textAlign: TextAlign.center,
      ),
      onTap: () {
        setState(() {
          _selectedDay = day;
          day_.text = day; // تحديث النص في TextFormField
        });
        Navigator.of(context).pop(); // إغلاق الحوار
      },
    );
  }

  void _showWeekstatusDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Container(
            // تعيين اللون الذي تريده هنا
            child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: Container(
                color: Color(0xFF383780),
                width: double.infinity,
                child: Text(
                  'أيام الأسبوع',
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.white,
                    fontFamily: 'Al-Jazeera',
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildstatusButton('جاري التنفيذ'),
              _buildstatusButton('الغاء'),
              _buildstatusButton('تم'),
              _buildstatusButton('أجل'),
            ],
          ),
        );
      },
    );
  }

  Future<void> _updateRecord() async {
    try {
      final updatedReservation = Reservations_model(
        // يمكنك تحديث القيم في هذا المكان باستخدام قيم حقول النص في الاستمارة
        id: reservation!.id, // قم بتوفير القيمة الصحيحة للمفتاح الرئيسي
        name: name_.text,
        from: from_.text,
        to: to_.text,
        amount: amount_.text,
        day: day_.text,
        status: status_.text,
        datex: reservation!.datex,
      );
      // قم بإجراء التحديث باستخدام الدالة المُعدلة
      final updatedRows = await _sqldb.updateRecord(
        'Reservations', // اسم الجدول
        updatedReservation.toMap(), // تحويل الكائن إلى Map
        'id', // اسم المفتاح الرئيسي
        reservation?.id ?? 0, // القيمة المراد تحديثها
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

  Widget _buildstatusButton(String status) {
    return ListTile(
      title: Text(
        status,
        style: TextStyle(
          fontSize: 13,
          color: Colors.black54,
          fontFamily: 'Al-Jazeera',
        ),
        textAlign: TextAlign.center,
      ),
      onTap: () {
        setState(() {
          _selectedDay = status;
          status_.text = status; // تحديث النص في TextFormField
        });
        Navigator.of(context).pop(); // إغلاق الحوار
      },
    );
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
      body: SingleChildScrollView(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            child: Column(
              children: [
                Stack(
                  children: [
                    Center(
                      child: Image.asset(
                        'assets/images/Rectangle 3.png',
                      ),
                    ),
                    Center(
                      child: Image.asset(
                        'assets/images/Layer 1.png',
                        width: 200,
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        CustomFormTextField(
                          labelText: 'الأسم',
                          text_: name_,
                        ),
                        CustomFormTextField(
                          labelText: 'من',
                          text_: from_,
                          onTap_: () => showPicker_(context, startHour, from_),
                        ),
                        CustomFormTextField(
                          labelText: 'الي',
                          text_: to_,
                          onTap_: () => showPicker_(context, endHour, to_),
                        ),
                        CustomFormTextField(
                          labelText: 'مبلغ',
                          text_: amount_,
                        ),
                        CustomFormTextField(
                          labelText: 'يوم',
                          text_: day_,
                          onTap_: () {
                            _showWeekDaysDialog(context);
                          },
                        ),
                        CustomFormTextField(
                          labelText: 'حالة',
                          text_: status_,
                          onTap_: () {
                            _showWeekstatusDialog(context);
                          },
                        ),
                        Container(
                          width: 1200,
                          child: CustomElevatedButton(
                            data: "تعديل",
                            star: FontAwesomeIcons.add,
                            onChanged_: () async {
                              _updateRecord();
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
