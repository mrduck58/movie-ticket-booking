import 'package:intl/intl.dart';

class MoneyFormatter {
  static final _vnd = NumberFormat.currency(
    locale: 'vi_VN',
    symbol: 'VND',
    decimalDigits: 0,
  );

  static String vnd(num value) => _vnd.format(value);
}
