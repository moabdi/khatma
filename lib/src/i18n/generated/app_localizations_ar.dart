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
}
