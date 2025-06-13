// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'الختمة';

  @override
  String get newKhatma => 'ختمة جديدة';

  @override
  String get editKhatma => 'تعديل الختمة';

  @override
  String get recurrence => 'التكرار';

  @override
  String get schedule => 'الجدول الزمني';

  @override
  String get name => 'الاسم';

  @override
  String get nameHint => 'أدخل اسم الختمة';

  @override
  String get descriptionHint => 'أدخل وصفًا (اختياري)';

  @override
  String get description => 'الوصف';

  @override
  String get share => 'مشاركة';

  @override
  String get splitUnit => 'وحدة التقسيم';

  @override
  String get add => 'إضافة';

  @override
  String get create => 'إنشاء';

  @override
  String get apply => 'تطبيق';

  @override
  String get save => 'حفظ';

  @override
  String get cancel => 'إلغاء';

  @override
  String get edit => 'تعديل';

  @override
  String get close => 'إغلاق';

  @override
  String get delete => 'حذف';

  @override
  String get ok => 'موافق';

  @override
  String get yes => 'نعم';

  @override
  String get no => 'لا';

  @override
  String get next => 'التالي';

  @override
  String get submit => 'إرسال';

  @override
  String get previous => 'السابق';

  @override
  String get finish => 'إنهاء';

  @override
  String get copy => 'نسخ';

  @override
  String get copied => 'تم النسخ';

  @override
  String get copiedToClipboard => 'تم النسخ إلى الحافظة';

  @override
  String get shareKhatma => 'مشاركة الختمة';

  @override
  String get loading => 'جاري التحميل';

  @override
  String get loadingKhatma => 'جاري تحميل الختمة';

  @override
  String get loadingKhatmaList => 'جاري تحميل قائمة الختمات';

  @override
  String get startDate => 'تاريخ البداية';

  @override
  String get endDate => 'تاريخ النهاية';

  @override
  String get every => 'كل';

  @override
  String get repeat => 'تكرار';

  @override
  String get noRepeat => 'بدون تكرار';

  @override
  String get autoRepeatDescription => 'إعادة تلقائية بعد الاكتمال';

  @override
  String repeatEverySelectedDaysDescription(Object count, Object days) {
    return 'سيتم تكرار الختمة كل $days من كل $count أسبوع';
  }

  @override
  String repeatEverySelectedDayDescription(Object days) {
    return 'سيتم تكرار الختمة كل $days من كل أسبوع';
  }

  @override
  String repeatEveryTimePeriodsDescription(Object count, Object unit) {
    return 'سيتم تكرار الختمة كل $count $unit';
  }

  @override
  String repeatEveryTimePeriodDescription(Object unit) {
    return 'سيتم تكرار الختمة كل $unit';
  }

  @override
  String get noRepeatDescription => 'لن يتم تكرار هذه الختمة';

  @override
  String get repeatDescription => 'إعادة إنشاء الختمة مفعلة';

  @override
  String get repeatEvery => 'تكرار كل';

  @override
  String get icon => 'أيقونة';

  @override
  String get color => 'اللون';

  @override
  String get chooseColor => 'اختر اللون';

  @override
  String get chooseIcon => 'اختر الأيقونة';

  @override
  String get khatmaList => 'قائمة الختمات';

  @override
  String get quran => 'القرآن';

  @override
  String get khatma => 'ختمة';

  @override
  String get home => 'الرئيسية';

  @override
  String get settings => 'الإعدادات';

  @override
  String get about => 'حول';

  @override
  String get language => 'اللغة';

  @override
  String get chooseLanguage => 'اختر اللغة';

  @override
  String get chooseTheme => 'اختر النمط';

  @override
  String get readMode => 'وضع القراءة';

  @override
  String get readLess => 'اقرأ أقل';

  @override
  String get showMore => 'عرض المزيد';

  @override
  String get showLess => 'عرض أقل';

  @override
  String get completed => 'مكتمل';

  @override
  String get completedParts => 'الأجزاء المكتملة';

  @override
  String get remainingParts => 'الأجزاء المتبقية';

  @override
  String get parts => 'أجزاء';

  @override
  String readedParts(Object count) {
    return '$count جزء';
  }

  @override
  String get confirmDelete => 'هل أنت متأكد أنك تريد حذف هذه الختمة؟';

  @override
  String successCompleteParts(Object count) {
    return 'تم إكمال $count جزء بنجاح';
  }

  @override
  String remainingPartsOfTotal(Object remaining, Object total) {
    return '$remaining من أصل $total جزء';
  }

  @override
  String completeParts(Object count) {
    return 'إكمال ($count جزء)';
  }

  @override
  String get chooseKhatmaStyle => 'اختر نمط ختمتك';

  @override
  String get khatmaStyle => 'نمط الختمة';

  @override
  String khatmaSplitUnit(String unit) {
    String _temp0 = intl.Intl.selectLogic(
      unit,
      {
        'sourat': 'سورة',
        'juzz': 'جزء',
        'hizb': 'حزب',
        'half': 'نصف حزب',
        'rubue': 'ربع حزب',
        'thumun': 'ثمن حزب',
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
        'sourat': 'سورة (١١٤ جزء)',
        'juzz': 'جزء (٣٠ جزء)',
        'hizb': 'حزب (٦٠ جزء)',
        'half': 'نصف حزب (١٢٠ جزء)',
        'rubue': 'ربع حزب (٢٤٠ جزء)',
        'thumun': 'ثمن حزب (٤٨٠ جزء)',
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
        'auto': 'تلقائي',
        'daily': 'يومي',
        'weekly': 'أسبوعي',
        'monthly': 'شهري',
        'yearly': 'سنوي',
        'other': 'آخر',
      },
    );
    return '$_temp0';
  }

  @override
  String timePeriods(String period) {
    String _temp0 = intl.Intl.selectLogic(
      period,
      {
        'daily': 'يوم',
        'weekly': 'أسبوع',
        'monthly': 'شهر',
        'yearly': 'سنة',
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
        '1': 'الاثنين',
        '2': 'الثلاثاء',
        '3': 'الأربعاء',
        '4': 'الخميس',
        '5': 'الجمعة',
        '6': 'السبت',
        '7': 'الأحد',
        'other': 'أخرى',
      },
    );
    return '$_temp0';
  }

  @override
  String shortWeekDay(String day) {
    String _temp0 = intl.Intl.selectLogic(
      day,
      {
        '1': 'ن',
        '2': 'ث',
        '3': 'ر',
        '4': 'خ',
        '5': 'ج',
        '6': 'س',
        '7': 'ح',
        'other': 'أ',
      },
    );
    return '$_temp0';
  }

  @override
  String repeatOption(String scheduler) {
    String _temp0 = intl.Intl.selectLogic(
      scheduler,
      {
        'true': 'التكرار التلقائي مفعّل',
        'false': 'التكرار التلقائي غير مفعّل',
        'other': 'آخر',
      },
    );
    return '$_temp0';
  }

  @override
  String shareVisibility(String share) {
    String _temp0 = intl.Intl.selectLogic(
      share,
      {
        'other': 'خاص',
        'public': 'عام',
        'group': 'مجموعة',
      },
    );
    return '$_temp0';
  }

  @override
  String shareVisibilityDesc(String share) {
    String _temp0 = intl.Intl.selectLogic(
      share,
      {
        'other': 'هذه الختمة خاصة',
        'public': 'يمكن للجميع الوصول والمشاركة',
        'group': 'تُشارك فقط عبر رمز أو كود QR',
      },
    );
    return '$_temp0';
  }

  @override
  String shareVisibilityDescription(String share) {
    String _temp0 = intl.Intl.selectLogic(
      share,
      {
        'other': 'ستبقى الختمة خاصة وحصرية للمنظم',
        'public': 'الكل مدعو للوصول والانضمام للختمة',
        'group': 'الختمة ستُشارك فقط مع من يحصل على رقم محدد أو رمز QR',
      },
    );
    return '$_temp0';
  }

  @override
  String maxParticipants(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '# مشاركين',
      one: 'مشارك واحد',
      zero: 'لا يوجد مشاركون',
    );
    return '$_temp0';
  }

  @override
  String get maxPartToRead => 'أقصى عدد مسموح قراءته';

  @override
  String get maxPartToReserve => 'عدد الحجوزات المتزامنة';

  @override
  String get title => 'العنوان';

  @override
  String get areYouSure => 'هل أنت متأكد؟';

  @override
  String get confirmDeleteKhatma => 'بعد الحذف، سيتم حذف هذه الختمة نهائيًا';

  @override
  String get congratulation => 'تهانينا!';

  @override
  String get emailInputLabel => 'أدخل بريدك الإلكتروني';

  @override
  String get passwordInputLabel => 'أدخل كلمة المرور';

  @override
  String themeMode(String mode) {
    String _temp0 = intl.Intl.selectLogic(
      mode,
      {
        'light': 'فاتح',
        'dark': 'داكن',
        'system': 'النظام',
        'other': 'النظام',
      },
    );
    return '$_temp0';
  }

  @override
  String get theme => 'النمط';

  @override
  String get onboarding1Title => 'أكمل ختمتك';

  @override
  String get onboarding1Description => 'تابع تلاوتك اليومية للقرآن الكريم وتتبع تقدمك نحو إكمال الختمة.';

  @override
  String get onboarding2Title => 'تلاوات جميلة';

  @override
  String get onboarding2Description => 'استمع لتلاوات واضحة من أشهر القراء مع تمييز الكلمات أثناء التلاوة.';

  @override
  String get onboarding3Title => 'تذكيرات يومية';

  @override
  String get onboarding3Description => 'اضبط تذكيرات روحانية للحفاظ على صلتك بالقرآن طوال يومك.';

  @override
  String get onboarding4Title => 'فهم عميق';

  @override
  String get onboarding4Description => 'احصل على شروحات التفسير والترجمات لإثراء فهمك القرآني.';

  @override
  String get skipButton => 'تخطي';

  @override
  String get continueButton => 'متابعة';

  @override
  String get startButton => 'ابدأ رحلتك مع القرآن';

  @override
  String get errorAuthUserNotLoggedIn => 'User not logged in.';

  @override
  String get errorAuthAnonymousNotAllowed => 'Anonymous login is not allowed.';

  @override
  String get errorAuthSessionExpired => 'Session has expired.';

  @override
  String get errorAuthPermissionDenied => 'Permission denied.';

  @override
  String get errorAuthInvalidAccount => 'Invalid account details.';

  @override
  String get errorNetConnectionFailed => 'Failed to connect to the internet.';

  @override
  String get errorNetTimeout => 'Network request timed out.';

  @override
  String get errorNetServerError => 'Server encountered an error.';

  @override
  String get errorNetNotFound => 'Requested resource not found.';

  @override
  String get errorNetUnauthorized => 'Unauthorized access.';

  @override
  String get errorNetRateLimit => 'Rate limit exceeded.';

  @override
  String get errorNetBadRequest => 'Bad request sent to server.';

  @override
  String get errorNetUnavailable => 'Network service is unavailable.';

  @override
  String get errorSyncGeneralFailure => 'Synchronization failed.';

  @override
  String get errorSyncConflict => 'Data conflict occurred during sync.';

  @override
  String get errorSyncCorruptData => 'Data is corrupted and cannot be synced.';

  @override
  String get errorSyncInProgress => 'A sync is already in progress.';

  @override
  String get errorSyncPartialFailure => 'Partial sync failure occurred.';

  @override
  String get errorSyncStatusFailed => 'Failed to retrieve sync status.';

  @override
  String get errorStorageSaveFailed => 'Failed to save data.';

  @override
  String get errorStorageDeleteFailed => 'Failed to delete data.';

  @override
  String get errorStorageLoadFailed => 'Failed to load data.';

  @override
  String get errorStorageFull => 'Storage is full.';

  @override
  String get errorStorageCorrupted => 'Storage is corrupted.';

  @override
  String get errorStoragePermissionDenied => 'Permission denied for storage access.';

  @override
  String get errorValidationInvalidData => 'Invalid data provided.';

  @override
  String get errorValidationMissingFields => 'Required fields are missing.';

  @override
  String get errorValidationInvalidFormat => 'Invalid data format.';

  @override
  String get errorValidationOutOfRange => 'Value is out of allowed range.';

  @override
  String get errorValidationInvalidDate => 'Invalid date provided.';

  @override
  String get errorKhatmaNotFound => 'Khatma not found.';

  @override
  String get errorKhatmaAlreadyCompleted => 'This Khatma is already completed.';

  @override
  String get errorKhatmaDeletionNotAllowed => 'Cannot delete this Khatma.';

  @override
  String get errorKhatmaArchiveFailed => 'Failed to archive Khatma.';

  @override
  String get errorKhatmaInvalidParts => 'Invalid Khatma parts.';

  @override
  String get errorKhatmaMarkCompletedFailed => 'Could not mark Khatma as completed.';

  @override
  String get errorKhatmaRepeatFailed => 'Failed to repeat Khatma.';

  @override
  String get errorLimitKhatmaMaxReached => 'Maximum number of Khatma reached.';

  @override
  String get errorLimitStorageQuotaExceeded => 'Storage quota exceeded.';

  @override
  String get errorLimitCreationNotAllowed => 'Creation not allowed due to limits.';

  @override
  String get errorHistoryCreateFailed => 'Failed to create history.';

  @override
  String get errorHistoryLoadFailed => 'Failed to load history.';

  @override
  String get errorHistoryDeleteFailed => 'Failed to delete history.';

  @override
  String get errorHistoryNotFound => 'History not found.';

  @override
  String get errorSearchFailed => 'Search failed.';

  @override
  String get errorSearchNoResults => 'No results found.';

  @override
  String get errorSearchInvalidQuery => 'Invalid search query.';

  @override
  String get errorSearchTimeout => 'Search timed out.';

  @override
  String get errorStatsCalculationFailed => 'Failed to calculate statistics.';

  @override
  String get errorStatsNoData => 'No data available for statistics.';

  @override
  String get errorStatsExportFailed => 'Failed to export statistics.';

  @override
  String get errorGeneralUnknown => 'An unknown error occurred.';

  @override
  String get errorGeneralCancelled => 'The operation was cancelled.';

  @override
  String get errorGeneralInvalidOperation => 'Invalid operation.';

  @override
  String get errorGeneralUnavailableResource => 'The resource is unavailable.';

  @override
  String get errorGeneralTimeout => 'The operation timed out.';

  @override
  String get errorGeneralOutOfMemory => 'The system is out of memory.';

  @override
  String get errorGeneralConfigError => 'Configuration error occurred.';

  @override
  String get errorGeneralInitializationFailed => 'Initialization failed.';

  @override
  String get errorDateRangeInvalid => 'The date range is invalid.';

  @override
  String get errorDateFormatInvalid => 'Date format is invalid.';

  @override
  String get errorDateParsingFailed => 'Failed to parse the date.';

  @override
  String get errorPermissionDenied => 'Permission denied.';

  @override
  String get errorPermissionFeatureDisabled => 'Feature is disabled due to permissions.';

  @override
  String get errorPermissionInsufficient => 'Insufficient permissions to proceed.';
}
