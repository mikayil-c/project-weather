import 'package:intl/intl.dart';

class DateHelper {
  static String getDayName(DateTime date, String locale){
    return DateFormat('EEEE',locale).format(date);
  }

  static String getMonthName(DateTime date, String locale){
    return DateFormat('MMMM',locale).format(date);
  }

  static String getFormattedDate(DateTime date, String locale) {
    return DateFormat('d MMMM', locale).format(date);
  }
}