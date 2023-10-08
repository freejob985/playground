
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  await initializeDateFormatting('ar_SA', null);
  String dateStr = '2023-09-28'; // تغيير هذا التاريخ حسب القيمة التي تريدها
  print(getDayName(dateStr));
}

String getDayName(String dateStr) {
  DateTime date = DateTime.parse(dateStr);

  DateFormat arabicDateFormat = DateFormat('EEEE', 'ar_SA');

  String arabicDay = arabicDateFormat.format(date);

  return 'التاريخ: $date\nاليوم بالعربية: $arabicDay';
}
