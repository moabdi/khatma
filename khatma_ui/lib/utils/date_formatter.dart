import 'package:intl/intl.dart';
import 'package:time_machine/time_machine.dart';

/// Date formatter to be used in the app.
final kDateFormatter = DateFormat.MMMEd();

final DateFormat dateFormat = DateFormat('dd/MM/yyyy');

DateTime parse(String date) {
  return dateFormat.parse(date);
}

extension DateTimeFormatter on DateTime {
  LocalDate toLocalDate() => LocalDate(year, month, day);

  int toInt() => int.parse('$year$month$day');

  DateTime from(String date) => dateFormat.parse(date);

  String format() => dateFormat.format(this);

  String timeAgoSince([DateTime? referenceDate]) {
    final diff = (referenceDate ?? DateTime.now()).difference(this).abs();

    if (diff.inSeconds < 60) return "${diff.inSeconds} sec";
    if (diff.inMinutes < 60) return "${diff.inMinutes} min";
    if (diff.inHours < 24) return "${diff.inHours} h";
    if (diff.inDays < 30) return "${diff.inDays} days";
    if (diff.inDays < 365) return "${(diff.inDays / 30).floor()} months";

    final years = diff.inDays ~/ 365;
    final months = (diff.inDays % 365) ~/ 30;
    return months == 0 ? "$years years" : "$years years $months months";
  }
}
