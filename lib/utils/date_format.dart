import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

String fromDate(DateTime date) {
  initializeDateFormatting("ja_JP");
  DateFormat formatter = DateFormat('yyyy/MM/dd(E)', "ja_JP");
  return formatter.format(date);
}