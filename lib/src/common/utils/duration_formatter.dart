import 'dart:async';

String formatLastRead(DateTime lastRead) {
  DateTime now = DateTime.now();

  if (lastRead.year == now.year && lastRead.month == now.month) {
    int diffInDays = now.difference(lastRead).inDays;

    if (diffInDays == 0) {
      return 'Today';
    } else if (diffInDays == 1) {
      return 'Yesterday';
    } else {
      return '$diffInDays days ago';
    }
  } else {
    int monthsAgo =
        12 * (now.year - lastRead.year) + (now.month - lastRead.month);
    String month = getMonthName(lastRead.month);
    if (now.year == lastRead.year) {
      return '$monthsAgo months ago';
    } else {
      return '$month ${lastRead.year}';
    }
  }
}

String getMonthName(int month) {
  switch (month) {
    case 1:
      return 'January';
    case 2:
      return 'February';
    case 3:
      return 'March';
    case 4:
      return 'April';
    case 5:
      return 'May';
    case 6:
      return 'June';
    case 7:
      return 'July';
    case 8:
      return 'August';
    case 9:
      return 'September';
    case 10:
      return 'October';
    case 11:
      return 'November';
    case 12:
      return 'December';
    default:
      return '';
  }
}
