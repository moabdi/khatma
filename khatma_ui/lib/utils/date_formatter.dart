import 'package:intl/intl.dart';
import 'package:time_machine/time_machine.dart';

/// Date formatter to be used in the app.
final kDateFormatter = DateFormat.MMMEd();

final DateFormat dateFormat = DateFormat('dd/MM/yyyy');

DateTime parse(String date) {
  return dateFormat.parse(date);
}

DateTime parseOrNow(String? date) {
  if (date == null || date.isEmpty) return DateTime.now();
  try {
    return dateFormat.parse(date);
  } catch (e) {
    return DateTime.now();
  }
}

extension DateTimeFormatter on DateTime {
  LocalDate toLocalDate() => LocalDate(year, month, day);

  int toInt() => int.parse('$year$month$day');

  DateTime from(String date) => dateFormat.parse(date);

  /// Formats date as dd/MM/yyyy (e.g., "25/12/2023")
  String format() => dateFormat.format(this);

  /// Formats date as MMM d, y (e.g., "Dec 25, 2023")
  String formatMMMEd() => kDateFormatter.format(this);

  /// Formats date as yyyy-MM-dd (e.g., "2023-12-25")
  String formatISO() => DateFormat('yyyy-MM-dd').format(this);

  /// Formats date as dd MMM yyyy (e.g., "25 Dec 2023")
  String formatDayMonthYear() => DateFormat('dd MMM yyyy').format(this);

  /// Formats date as MMMM d, y (e.g., "December 25, 2023")
  String formatLongDate() => DateFormat('MMMM d, y').format(this);

  /// Formats date as dd/MM (e.g., "25/12")
  String formatDayMonth() => DateFormat('dd/MM').format(this);

  /// Formats time as HH:mm (e.g., "14:30")
  String formatTime() => DateFormat('HH:mm').format(this);

  /// Formats time as h:mm a (e.g., "2:30 PM")
  String formatTime12Hour() => DateFormat('h:mm a').format(this);

  /// Formats date and time as dd/MM/yyyy HH:mm (e.g., "25/12/2023 14:30")
  String formatDateTime() => DateFormat('dd/MM/yyyy HH:mm').format(this);

  /// Formats date and time as dd MMM yyyy, h:mm a (e.g., "25 Dec 2023, 2:30 PM")
  String formatDateTimeLong() => DateFormat('dd MMM yyyy, h:mm a').format(this);

  /// Formats relative time (e.g., "5 min", "3 days", "2 years")
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
