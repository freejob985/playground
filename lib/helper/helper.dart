import 'dart:ui';

import 'package:day_night_time_picker/lib/state/time.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:playground/Database/sqldb.dart';
import 'package:playground/widgets/CustomToast.dart';

const Jazeera = 'Al-Jazeera';
const primary = Color(0xFF383780);
const primary_ = Color(0xFFE9E9E9);
const sizeicon = 15.0;
Time startHour = Time(hour: 11, minute: 00);
Time endHour = Time(hour: 12, minute: 00);
DateTime selectedDate = DateTime.now();
DateFormat format = DateFormat('yyyy-M-d');

String formattedDate2 = DateFormat('yyyy-M-d').format(selectedDate);
final Sqldb sql_ = Sqldb();
void showToast_(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: CustomToast(message: message),
      duration: Duration(seconds: 2), // تعديل على مدى الظهور حسب الحاجة
    ),
  );
}

String getFormattedDate() {
  final now = DateTime.now();
  final formatter =
      DateFormat('yyyy-M-d'); // يمكنك استخدام التنسيق الذي تريده هنا
  final formattedDate = formatter.format(now);
  return formattedDate;
}

String getDayName(DateTime date) {
  // استخدم DateFormat للحصول على اسم اليوم باللغة الإنجليزية
  DateFormat englishDateFormat = DateFormat('EEEE', 'en_US');
  String englishDay = englishDateFormat.format(date);

  // استخدم DateFormat للتحويل إلى اللغة العربية (معتمد على ترجمة اللغة العربية في جهازك)
  DateFormat arabicDateFormat = DateFormat('EEEE', 'ar');

  String arabicDay = arabicDateFormat.format(date);
  return arabicDay;
}

String formatTimeOfDay(TimeOfDay time) {
  final now = DateTime.now();
  final dateTime = DateTime(
    now.year,
    now.month,
    now.day,
    time.hour,
    time.minute,
  );

  final hour = dateTime.hour > 12 ? dateTime.hour - 12 : dateTime.hour;
  final period = dateTime.hour >= 12 ? 'PM' : 'AM';

  final formattedTime =
      '$hour:${dateTime.minute.toString().padLeft(2, '0')} $period';

  return formattedTime;
}

String formatDateTime(DateTime dateTime) {
  final hour = dateTime.hour > 12 ? dateTime.hour - 12 : dateTime.hour;
  final period = dateTime.hour >= 12 ? 'PM' : 'AM';

  final formattedTime = '$hour:${dateTime.minute.toString().padLeft(2, '0')} ';

  return formattedTime;
}

int calculateHoursDifference(Time startHour, Time endHour) {
  int hoursDifference = endHour.hour - startHour.hour;
  int minutesDifference = endHour.minute - startHour.minute;

  // التحقق من الفرق في الدقائق وإضافتها إلى الساعات إذا كانت إيجابية
  if (minutesDifference > 0) {
    hoursDifference += 1;
  }

  return hoursDifference;
}

bool isNight(Time time) {
  int hour = time.hour;
  return hour < 6 ||
      hour >= 18; // يعتبر أي وقت قبل السادسة صباحًا أو بعد السادسة مساءً ليلاً
}

Color setColors(String status) {
  switch (status) {
    case 'تم':
      return Colors.green;
    case 'أجل':
      return Colors.orange;
    case 'الغاء':
      return Colors.red;
    default:
      return Colors.blue;
  }
}

String formatDate(DateTime date, {String format = 'yyyy-M-d'}) {
  final formatter = DateFormat(format);
  return formatter.format(date);
}

String getArabicDay(DateTime date) {
  // مصفوفة تحتوي على ترجمات الأيام من الإنجليزية إلى العربية
  Map<String, String> dayTranslations = {
    'Sunday': 'الأحد',
    'Monday': 'الإثنين',
    'Tuesday': 'الثلاثاء',
    'Wednesday': 'الأربعاء',
    'Thursday': 'الخميس',
    'Friday': 'الجمعة',
    'Saturday': 'السبت',
  };

  // استخدم اسم اليوم بالإنجليزية للعثور على الترجمة المناسبة
  String englishDay = DateFormat('EEEE').format(date);
  String translatedDay = dayTranslations[englishDay] ?? englishDay;

  return translatedDay;
}
