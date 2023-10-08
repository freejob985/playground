import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:day_night_time_picker/lib/constants.dart';
import 'package:day_night_time_picker/lib/daynight_timepicker.dart';
import 'package:day_night_time_picker/lib/state/time.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:playground/Database/sqldb.dart';
import 'package:playground/helper/helper.dart';
import 'package:playground/model/People.dart';
import 'package:playground/model/Reservations.dart';
import 'package:playground/widgets/Control/fotter.dart';
import 'package:playground/widgets/CustomElevatedButton.dart';
import 'package:playground/widgets/CustomFormTextField.dart';
import 'package:playground/widgets/MyDrawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddReservation extends StatefulWidget {
  @override
  _AddReservationState createState() => _AddReservationState();
}

class _AddReservationState extends State<AddReservation> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController name_ = TextEditingController();
  final TextEditingController from_ = TextEditingController();
  final TextEditingController to_ = TextEditingController();
  final TextEditingController amount_ = TextEditingController();
  final TextEditingController day_ = TextEditingController();
  final TextEditingController status_ = TextEditingController();
  final TextEditingController datex_ = TextEditingController();
  final TextEditingController sss = TextEditingController();

  List<String> suggestions = [];
  // TimeOfDay _startTime = TimeOfDay(hour: 8, minute: 0);
  // TimeOfDay _endTime = TimeOfDay(hour: 9, minute: 0);

  final Sqldb _reservationDb = Sqldb(); // Database helper for Reservations
  final Sqldb _peopleDb = Sqldb(); // Database helper for People
  String _selectedDay = '';
  int _hoursDifference = 0;
  String _dayOrNight = '';
  GlobalKey<AutoCompleteTextFieldState<String>> key = GlobalKey();

  @override
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        datex_.text = formatDate(picked);

        day_.text = getArabicDay(picked);
      });
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
          //     Pricecalculation(amount_);
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
                child: const Text(
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
                child: const Text(
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

  void initState() {
    super.initState();

    _loadReservations();
  }

  void _loadReservations() async {
    var names = await _reservationDb.getColumnValues("Reservations", "name");

    setState(() {
      // suggestions = reservationsData;
      //    suggestions = List.from(suggestions)..addAll(names);
      //  suggestions.addAll(reservationsData);
      suggestions.addAll(names);

      print("suggestions:::::$suggestions");
    });
  }

  void _initializeDatabases() async {
    await _reservationDb.initializeDatabase();
    await _peopleDb.initializeDatabase();
  }

  @override
  void dispose() {
    name_.dispose();
    from_.dispose();
    to_.dispose();
    amount_.dispose();
    day_.dispose();
    status_.dispose();

    super.dispose();
  }

  void showToast() {
    Fluttertoast.showToast(
      msg: 'تم اضافة البيانات بنجاح',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.blue,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  Future<void> insertData() async {
    final myReservation = Reservations_model(
      name: name_.text,
      amount: amount_.text,
      from: from_.text,
      to: to_.text,
      day: day_.text,
      datex: datex_.text,
      status: "جاري التنفيذ",
    );

    final reservationMap = myReservation.toMap();
    final reservationTableName = 'Reservations';
    final insertedRow = await _reservationDb.insertData(
      reservationTableName,
      reservationMap,
    );
    try {
      final myPeople = People(name: name_.text);
      final peopleMap = myPeople.toMap();
      final peopleTableName = 'People';
      final insertedRowPeople = await _peopleDb.insertData(
        peopleTableName,
        peopleMap,
      );
    } catch (e) {
      print("People::::::::::::::::::$e");
    }

    if (insertedRow != null) {
      showToast();
      print("insertedRow::::::::::$insertedRow");
    } else {
      print('حدث خطأ أثناء إضافة الصف');
    }
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
                        AutoCompleteTextField<String>(
                          key: key,
                          clearOnSubmit: false,
                          textChanged: (String text) {
                            //      _loadReservations();
                          },
                          suggestions: suggestions,
                          controller: name_,
                          decoration: InputDecoration(
                            labelText: "الأسماء",
                            floatingLabelBehavior:
                                FloatingLabelBehavior.auto, // تحديد سلوك الوسم
                            labelStyle: TextStyle(color: Colors.black),
                            border: InputBorder.none, // إزالة الحدود,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(0.0),
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            filled: true,
                            fillColor: primary_,
                          ),
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: Jazeera,
                            fontSize: 15, // حجم الخط
                          ),
                          itemFilter: (item, query) {
                            return item
                                .toLowerCase()
                                .contains(query.toLowerCase());
                          },
                          itemSorter: (a, b) {
                            return a.compareTo(b);
                          },
                          itemSubmitted: (item) {
                            setState(() {
                              name_.text = item;
                            });
                          },
                          itemBuilder: (context, item) {
                            return ListTile(
                              title: Text(item),
                            );
                          },
                        ),
                        // CustomFormTextField(
                        //   labelText: 'الأسم',
                        //   text_: name_,
                        // ),
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
                          keyboardType: TextInputType.number,
                        ),
                        CustomFormTextField(
                          labelText: 'يوم',
                          text_: day_,
                          onTap_: () {
                            _showWeekDaysDialog(context);
                          },
                        ),
                        CustomFormTextField(
                          labelText: 'التاريخ',
                          text_: datex_,
                          onTap_: () {
                            _selectDate(context);
                          },
                        ),
                        Container(
                          width: 1200,
                          child: CustomElevatedButton(
                            data: "اضافة حجز",
                            star: FontAwesomeIcons.add,
                            onChanged_: () {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                insertData();
                              }
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
