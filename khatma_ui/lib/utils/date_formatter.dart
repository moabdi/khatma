import 'package:intl/intl.dart';
import 'package:time_machine/time_machine.dart';

/// Date formatter to be used in the app.
final kDateFormatter = DateFormat.MMMEd();

final DateFormat dateFormat = DateFormat('dd/MM/yyyy');

DateTime parse(String date) {
  return dateFormat.parse(date);
}

extension DateTimeFormater on DateTime {
  LocalDate toLocalDate() {
    return LocalDate(year, month, day);
  }

  int toInt() {
    return int.parse('$year$month$day');
  }

  DateTime from(String date) {
    return dateFormat.parse(date);
  }

  String format() {
    return dateFormat.format(this);
  }

  String toHumanReadable() {
    Duration difference = DateTime.now().difference(this);

    if (difference.inSeconds < 60) {
      return "Instant";
    } else if (difference.inMinutes < 60) {
      return "${difference.inMinutes} min";
    } else if (difference.inHours < 24) {
      return "${difference.inHours} h";
    } else if (difference.inDays < 30) {
      return "${difference.inDays} days";
    } else if (difference.inDays < 365) {
      return "${(difference.inDays / 30).floor()} months";
    } else {
      int years = (difference.inDays / 365).floor();
      int months = ((difference.inDays % 365) / 30).floor();
      if (months == 0) {
        return "$years years";
      } else {
        return "$years years $months months";
      }
    }
  }
}
