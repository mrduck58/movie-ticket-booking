import 'package:intl/intl.dart';

class DateFormatter {
  static final _time = DateFormat('HH:mm');
  static final _date = DateFormat('dd/MM/yyyy');

  static String time(DateTime dt) => _time.format(dt);
  static String date(DateTime dt) => _date.format(dt);
}