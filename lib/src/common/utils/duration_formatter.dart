String formatDateAsTextDuration(DateTime dateTime) {
  DateTime now = DateTime.now();

  if (dateTime.year == now.year && dateTime.month == now.month) {
    int diffInDays = now.difference(dateTime).inDays;

    if (diffInDays == 0) {
      return 'Today';
    } else if (diffInDays == 1) {
      return 'Yesterday';
    } else {
      return '$diffInDays days ago';
    }
  } else {
    int monthsAgo =
        12 * (now.year - dateTime.year) + (now.month - dateTime.month);
    String month = getMonthName(dateTime.month);
    if (now.year == dateTime.year) {
      return '$monthsAgo months ago';
    } else {
      return '$month ${dateTime.year}';
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
