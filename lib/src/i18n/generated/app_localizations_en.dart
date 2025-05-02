// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Khatma';

  @override
  String get newKhatma => 'New khatma';

  @override
  String get editKhatma => 'Edit khatma';

  @override
  String get recurrence => 'Recurrence';

  @override
  String get schedule => 'Schedule';

  @override
  String get name => 'Name';

  @override
  String get nameHint => 'Enter the name of the Khatma';

  @override
  String get descriptionHint => 'Enter a description (optional)';

  @override
  String get description => 'Description';

  @override
  String get share => 'Share';

  @override
  String get splitUnit => 'Split unit';

  @override
  String get add => 'Add';

  @override
  String get create => 'Create';

  @override
  String get apply => 'Apply';

  @override
  String get save => 'Save';

  @override
  String get cancel => 'Cancel';

  @override
  String get edit => 'Edit';

  @override
  String get close => 'Close';

  @override
  String get delete => 'Delete';

  @override
  String get ok => 'OK';

  @override
  String get yes => 'Yes';

  @override
  String get no => 'No';

  @override
  String get next => 'Next';

  @override
  String get submit => 'Submit';

  @override
  String get previous => 'Previous';

  @override
  String get finish => 'Finish';

  @override
  String get copy => 'Copy';

  @override
  String get copied => 'Copied';

  @override
  String get copiedToClipboard => 'Copied to clipboard';

  @override
  String get shareKhatma => 'Share khatma';

  @override
  String get loading => 'Loading';

  @override
  String get loadingKhatma => 'Loading khatma';

  @override
  String get loadingKhatmaList => 'Loading khatma list';

  @override
  String get startDate => 'Start date';

  @override
  String get endDate => 'End date';

  @override
  String get every => 'Every';

  @override
  String get repeat => 'Repeat';

  @override
  String get noRepeat => 'No repeat';

  @override
  String get autoRepeatDescription => 'Khatma will be repeated automatically after completion';

  @override
  String repeatEverySelectedDaysDescription(Object count, Object days) {
    return 'Khatma will be repeated every $days for evry $count weeks';
  }

  @override
  String repeatEverySelectedDayDescription(Object days) {
    return 'Khatma will be repeated every $days for evry week';
  }

  @override
  String repeatEveryTimePeriodsDescription(Object count, Object unit) {
    return 'Khatma will be repeated evry $count ${unit}s';
  }

  @override
  String repeatEveryTimePeriodDescription(Object unit) {
    return 'Khatma will be repeated evry $unit';
  }

  @override
  String get noRepeatDescription => 'This khatma will not be repeated';

  @override
  String get repeatDescription => 'Active khatma recreation';

  @override
  String get repeatEvery => 'Repeat very';

  @override
  String get icon => 'Icon';

  @override
  String get color => 'Color';

  @override
  String get chooseColor => 'Choose color';

  @override
  String get chooseIcon => 'Choose icon';

  @override
  String get khatmaList => 'Khatma list';

  @override
  String get quran => 'Quran';

  @override
  String get khatma => 'Khatma';

  @override
  String get home => 'Home';

  @override
  String get settings => 'Settings';

  @override
  String get about => 'About';

  @override
  String get language => 'Language';

  @override
  String get chooseLanguage => 'Choose language';

  @override
  String get chooseTheme => 'Choose theme';

  @override
  String get readMode => 'Read mode';

  @override
  String get readLess => 'Read less';

  @override
  String get showMore => ' show more';

  @override
  String get showLess => ' show less';

  @override
  String get completed => 'Completed';

  @override
  String get completedParts => 'Completed parts';

  @override
  String get remainingParts => 'Remaining parts';

  @override
  String get parts => 'Parts';

  @override
  String readedParts(Object count) {
    return '$count parts';
  }

  @override
  String get confirmDelete => 'Are you sure you want to delete this khatma?';

  @override
  String successCompleteParts(Object count) {
    return '$count parts completed successfully';
  }

  @override
  String remainingPartsOfTotal(Object remaining, Object total) {
    return '$remaining of $total parts';
  }

  @override
  String completeParts(Object count) {
    return 'Complete ($count parts)';
  }

  @override
  String get chooseKhatmaStyle => 'Choose your khatma\'s style';

  @override
  String get khatmaStyle => 'Khatma style';

  @override
  String khatmaSplitUnit(String unit) {
    String _temp0 = intl.Intl.selectLogic(
      unit,
      {
        'sourat': 'Sourat',
        'juzz': 'Juzz',
        'hizb': 'Hizb',
        'half': 'Half-Hizb',
        'rubue': 'Fourth-hizb',
        'thumun': 'Eighth-hizb',
        'other': '',
      },
    );
    return '$_temp0';
  }

  @override
  String khatmaSplitUnitDesc(String unit) {
    String _temp0 = intl.Intl.selectLogic(
      unit,
      {
        'sourat': 'Sourat (114 parts)',
        'juzz': 'Juzz (30 parts)',
        'hizb': 'Hizb (60 parts)',
        'half': 'Half-Hizb (120 parts)',
        'rubue': 'Fourth-hizb (240 parts)',
        'thumun': 'Eighth-hizb (480 parts)',
        'other': '',
      },
    );
    return '$_temp0';
  }

  @override
  String repeatInterval(String recurrence) {
    String _temp0 = intl.Intl.selectLogic(
      recurrence,
      {
        'auto': 'Auto',
        'daily': 'Day',
        'weekly': 'Week',
        'monthly': 'Month',
        'yearly': 'Year',
        'other': 'Other',
      },
    );
    return '$_temp0';
  }

  @override
  String timePeriods(String period) {
    String _temp0 = intl.Intl.selectLogic(
      period,
      {
        'daily': 'Day',
        'weekly': 'Week',
        'monthly': 'Month',
        'yearly': 'Year',
        'other': '',
      },
    );
    return '$_temp0';
  }

  @override
  String weekDay(String day) {
    String _temp0 = intl.Intl.selectLogic(
      day,
      {
        '1': 'Monday',
        '2': 'Tuesday',
        '3': 'Wednesday',
        '4': 'Thursday',
        '5': 'Friday',
        '6': 'Saturday',
        '7': 'Sunday',
        'other': 'Other',
      },
    );
    return '$_temp0';
  }

  @override
  String shortWeekDay(String day) {
    String _temp0 = intl.Intl.selectLogic(
      day,
      {
        '1': 'M',
        '2': 'T',
        '3': 'W',
        '4': 'T',
        '5': 'F',
        '6': 'S',
        '7': 'S',
        'other': 'O',
      },
    );
    return '$_temp0';
  }

  @override
  String repeatOption(String scheduler) {
    String _temp0 = intl.Intl.selectLogic(
      scheduler,
      {
        'true': 'Auto-repeat is enabled',
        'false': 'Auto-repeat is disabled',
        'other': 'Other',
      },
    );
    return '$_temp0';
  }

  @override
  String shareVisibility(String share) {
    String _temp0 = intl.Intl.selectLogic(
      share,
      {
        'other': 'Private',
        'public': 'Public',
        'group': 'Group',
      },
    );
    return '$_temp0';
  }

  @override
  String shareVisibilityDesc(String share) {
    String _temp0 = intl.Intl.selectLogic(
      share,
      {
        'other': 'This khatma is private',
        'public': 'Everyone can access and participate',
        'group': 'Shared only by code or QR code',
      },
    );
    return '$_temp0';
  }

  @override
  String shareVisibilityDescription(String share) {
    String _temp0 = intl.Intl.selectLogic(
      share,
      {
        'other': 'The khatma will be kept private and exclusive to the organizer',
        'public': 'Everyone is welcome to access and join the khatma',
        'group': 'The khatma will be shared only with those who receive a specific number or QR code',
      },
    );
    return '$_temp0';
  }

  @override
  String maxParticipants(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '# participants',
      one: '1 participant',
      zero: 'No participants',
    );
    return '$_temp0';
  }

  @override
  String get maxPartToRead => 'Max part to read';

  @override
  String get maxPartToReserve => 'Max part to reserve';

  @override
  String get title => 'Title';

  @override
  String get areYouSure => 'Are you sure?';

  @override
  String get confirmDeleteKhatma => 'After deleting, this khatma will be permanently deleted';

  @override
  String get congratulation => 'Congratulations!';

  @override
  String get emailInputLabel => 'Enter your gemail';

  @override
  String get passwordInputLabel => 'Enter your password';

  @override
  String themeMode(String mode) {
    String _temp0 = intl.Intl.selectLogic(
      mode,
      {
        'light': 'Light',
        'dark': 'Dark',
        'system': 'System',
        'other': 'System',
      },
    );
    return '$_temp0';
  }

  @override
  String get theme => 'Theme';
}
