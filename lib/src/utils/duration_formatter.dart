import 'package:khatma/src/i18n/generated/app_localizations.dart';

String formatDateAsTextDuration(AppLocalizations loc, DateTime dateTime) {
  DateTime now = DateTime.now();

  if (dateTime.year == now.year && dateTime.month == now.month) {
    int diffInDays = now.difference(dateTime).inDays;

    if (diffInDays == 0) {
      return loc.today;
    } else if (diffInDays == 1) {
      return loc.yesterday;
    } else {
      return '${loc.daysAgo(diffInDays)}';
    }
  } else {
    int monthsAgo =
        12 * (now.year - dateTime.year) + (now.month - dateTime.month);
    String month = loc.monthName("${dateTime.month}");
    if (now.year == dateTime.year) {
      return '${loc.monthsAgo(monthsAgo)}';
    } else {
      return '$month ${dateTime.year}';
    }
  }
}
