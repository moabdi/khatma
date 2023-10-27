import 'package:intl/intl.dart';

/// Date formatter to be used in the app.
final kDateFormatter = DateFormat.MMMEd();

final DateFormat dateFormat = DateFormat('dd/MM/yyyy');

DateTime parse(String date) {
  return dateFormat.parse(date);
}

extension DateTimeFormater on DateTime {
  DateTime from(String date) {
    return dateFormat.parse(date);
  }

  String format() {
    return dateFormat.format(this);
  }
}
