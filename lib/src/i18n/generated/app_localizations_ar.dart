// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get languageName => 'العربية';

  @override
  String get appTitle => 'ختمة';

  @override
  String get appName => 'ختمة';

  @override
  String get add => 'إضافة';

  @override
  String get apply => 'تطبيق';

  @override
  String get back => 'رجوع';

  @override
  String get cancel => 'إلغاء';

  @override
  String get change => 'تغيير';

  @override
  String get close => 'إغلاق';

  @override
  String get copy => 'نسخ';

  @override
  String get copied => 'تم النسخ';

  @override
  String get copiedToClipboard => 'تم النسخ إلى الحافظة';

  @override
  String get create => 'إنشاء';

  @override
  String get delete => 'حذف';

  @override
  String get edit => 'تعديل';

  @override
  String get finish => 'إنهاء';

  @override
  String get next => 'التالي';

  @override
  String get no => 'لا';

  @override
  String get ok => 'موافق';

  @override
  String get previous => 'السابق';

  @override
  String get retry => 'إعادة المحاولة';

  @override
  String get save => 'حفظ';

  @override
  String get submit => 'إرسال';

  @override
  String get yes => 'نعم';

  @override
  String get or => 'أو';

  @override
  String get confirmReading => 'تمييز كمقروء';

  @override
  String get processing => 'جاري المعالجة …';

  @override
  String get today => 'اليوم';

  @override
  String get yesterday => 'أمس';

  @override
  String daysAgo(int count) {
    return 'منذ $count يوم';
  }

  @override
  String monthsAgo(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count شهور مضت',
      one: 'الشهر الماضي',
      zero: 'هذا الشهر',
    );
    return '$_temp0';
  }

  @override
  String monthName(String month) {
    String _temp0 = intl.Intl.selectLogic(
      month,
      {
        '1': 'يناير',
        '2': 'فبراير',
        '3': 'مارس',
        '4': 'أبريل',
        '5': 'مايو',
        '6': 'يونيو',
        '7': 'يوليو',
        '8': 'أغسطس',
        '9': 'سبتمبر',
        '10': 'أكتوبر',
        '11': 'نوفمبر',
        '12': 'ديسمبر',
        'other': '',
      },
    );
    return '$_temp0';
  }

  @override
  String get signIn => 'تسجيل الدخول';

  @override
  String get signUp => 'التسجيل';

  @override
  String get signOut => 'تسجيل الخروج';

  @override
  String get register => 'التسجيل';

  @override
  String get welcome => 'مرحباً!';

  @override
  String get joinUs => 'انضم إلينا!';

  @override
  String get createAccount => 'إنشاء حساب';

  @override
  String get createAnAccount => 'إنشاء حساب';

  @override
  String get createAccountToStart => 'أنشئ حسابك للبدء';

  @override
  String get createMyAccount => 'إنشاء حسابي';

  @override
  String get signInToContinue => 'سجل الدخول للمتابعة';

  @override
  String get haveAccountSignIn => 'لديك حساب؟ سجل الدخول';

  @override
  String get needAccountRegister => 'تحتاج حساب؟ سجل الآن';

  @override
  String get noAccountYet => 'لا تملك حساب بعد؟ ';

  @override
  String get orContinueWith => 'أو تابع باستخدام';

  @override
  String get continueWithGoogle => 'المتابعة مع جوجل';

  @override
  String get continueAsGuest => 'المتابعة كضيف';

  @override
  String get backToLogin => 'العودة إلى صفحة تسجيل الدخول';

  @override
  String get name => 'الاسم';

  @override
  String get displayName => 'الاسم المعروض';

  @override
  String get fullNameOrNickname => 'الاسم الكامل أو الكنية';

  @override
  String get fullNameOrNicknameHint => 'أدخل اسمك الكامل أو كنيتك';

  @override
  String get email => 'البريد الإلكتروني';

  @override
  String get emailHint => 'أدخل عنوان بريدك الإلكتروني';

  @override
  String get emailInputLabel => 'أدخل بريدك الإلكتروني';

  @override
  String get password => 'كلمة المرور';

  @override
  String get yourPassword => 'كلمة المرور الخاصة بك';

  @override
  String get passwordInputLabel => 'أدخل كلمة المرور';

  @override
  String get passwordWith8Characters => 'كلمة المرور (8 أحرف على الأقل)';

  @override
  String get atLeast8Characters => '8 أحرف على الأقل';

  @override
  String get confirmPassword => 'تأكيد كلمة المرور';

  @override
  String get retypePassword => 'أعد كتابة كلمة المرور';

  @override
  String get currentPassword => 'كلمة المرور الحالية';

  @override
  String get newPassword => 'كلمة المرور الجديدة';

  @override
  String get confirmNewPassword => 'تأكيد كلمة المرور الجديدة';

  @override
  String get forgotPassword => 'نسيت كلمة المرور؟';

  @override
  String get forgotPasswordTitle => 'نسيت كلمة المرور';

  @override
  String get forgotPasswordDescription =>
      'أدخل عنوان بريدك الإلكتروني لتلقي رابط إعادة تعيين كلمة المرور.';

  @override
  String get sendPasswordResetEmail => 'إرسال بريد إعادة تعيين كلمة المرور';

  @override
  String get createNewPassword => 'إنشاء كلمة مرور جديدة';

  @override
  String get newPasswordDescription =>
      'أدخل كلمة مرور جديدة لإعادة تعيين حسابك.';

  @override
  String get updatePassword => 'تحديث كلمة المرور';

  @override
  String get changePassword => 'تغيير كلمة المرور';

  @override
  String get changePasswordSubtitle => 'غير كلمة المرور للحفاظ على أمان حسابك.';

  @override
  String get updateYourPassword => 'تحديث كلمة المرور';

  @override
  String get passwordResetEmailSent => 'تم إرسال بريد إعادة تعيين كلمة المرور';

  @override
  String get passwordResetEmailSentDescription =>
      'تم إرسال بريد إعادة تعيين كلمة المرور إلى عنوان بريدك الإلكتروني. يرجى مراجعة صندوق الوارد واتباع التعليمات لإعادة تعيين كلمة المرور.';

  @override
  String get checkInboxForPasswordReset =>
      'يرجى مراجعة صندوق الوارد لبريد إعادة تعيين كلمة المرور.';

  @override
  String get checkSpamFolder =>
      'إذا لم تجد البريد، تحقق من مجلد الرسائل المزعجة.';

  @override
  String get resendEmail => 'إعادة إرسال البريد';

  @override
  String get emailSent => 'تم إرسال البريد';

  @override
  String get passwordUpdated => 'تم تحديث كلمة المرور بنجاح!';

  @override
  String get passwordUpdatedSuccessfully => 'تم تحديث كلمة المرور بنجاح!';

  @override
  String get passwordUpdatedDescription =>
      'تم تحديث كلمة المرور بنجاح. يمكنك الآن تسجيل الدخول بكلمة المرور الجديدة.';

  @override
  String get rememberPasswordBackToLogin =>
      'تذكرت كلمة المرور؟ العودة لتسجيل الدخول';

  @override
  String get redirectingToLogin => 'جاري التوجيه لتسجيل الدخول...';

  @override
  String get goToLoginPage => 'الذهاب إلى صفحة تسجيل الدخول';

  @override
  String get show => 'إظهار';

  @override
  String get hide => 'إخفاء';

  @override
  String get passwordRequirements => 'متطلبات كلمة المرور';

  @override
  String get passwordCriteria => 'معايير كلمة المرور:';

  @override
  String get atLeast8CharsCriterion => '8 أحرف على الأقل';

  @override
  String get oneUppercaseCriterion => 'حرف كبير واحد';

  @override
  String get oneLowercaseCriterion => 'حرف صغير واحد';

  @override
  String get oneDigitCriterion => 'رقم واحد';

  @override
  String get passwordsMatch => 'كلمتا المرور متطابقتان';

  @override
  String get passwordStrengthWeak => 'ضعيفة';

  @override
  String get passwordStrengthMedium => 'متوسطة';

  @override
  String get passwordStrengthGood => 'جيدة';

  @override
  String get passwordStrengthStrong => 'قوية';

  @override
  String get acceptTerms => 'أوافق على ';

  @override
  String get termsOfService => 'شروط الخدمة';

  @override
  String get andThe => ' و';

  @override
  String get privacyPolicy => 'سياسة الخصوصية';

  @override
  String get termsAndConditions => 'الشروط والأحكام';

  @override
  String get legalNotices => 'الإشعارات القانونية';

  @override
  String get mustAcceptTerms => 'يجب أن توافق على شروط الخدمة';

  @override
  String get myAccount => 'حسابي';

  @override
  String get profile => 'الملف الشخصي';

  @override
  String get editProfile => 'تعديل الملف الشخصي';

  @override
  String get accountSettings => 'إعدادات الحساب';

  @override
  String get changeDisplayName => 'تغيير الاسم المعروض';

  @override
  String get changeDisplayNameSubtitle => 'غير اسمك المعروض لتخصيص حسابك.';

  @override
  String get verifyEmail => 'التحقق من البريد الإلكتروني';

  @override
  String get confirmEmailAddress => 'تأكيد عنوان البريد الإلكتروني';

  @override
  String get refreshData => 'تحديث البيانات';

  @override
  String get updateAccountInformation => 'تحديث معلومات الحساب';

  @override
  String get profileUpdatedSuccessfully => 'تم تحديث الملف الشخصي بنجاح!';

  @override
  String get dataRefreshed => 'تم تحديث البيانات بنجاح!';

  @override
  String get security => 'الأمان';

  @override
  String get dangerZone => 'منطقة الخطر';

  @override
  String get deleteAccount => 'حذف الحساب';

  @override
  String get permanentlyDeleteAccount => 'حذف حسابك نهائياً';

  @override
  String get deleteAccountWarning =>
      'هذا الإجراء سيحذف حسابك وجميع البيانات المرتبطة به نهائياً. لا يمكن التراجع عن هذا الإجراء.';

  @override
  String get confirmWithPassword => 'تأكيد بكلمة المرور';

  @override
  String get accountDeletedSuccessfully => 'تم حذف حسابك بنجاح.';

  @override
  String get deletePermantly => 'حذف نهائياً';

  @override
  String get confirmSignOut => 'هل أنت متأكد من رغبتك في تسجيل الخروج؟';

  @override
  String get closeYourSession => 'إغلاق جلستك';

  @override
  String get becomeMember => 'كن عضواً';

  @override
  String get anonymousUser => 'مستخدم مجهول';

  @override
  String get anonymous => 'مجهول';

  @override
  String get guest => 'ضيف';

  @override
  String get user => 'مستخدم';

  @override
  String get guestAccount => 'حساب ضيف';

  @override
  String get userAccount => 'حساب مستخدم';

  @override
  String get verifiedUser => 'مستخدم موثق';

  @override
  String get unverifiedUser => 'مستخدم غير موثق';

  @override
  String get emailVerified => 'البريد الإلكتروني موثق';

  @override
  String get emailNotVerified => 'البريد الإلكتروني غير موثق';

  @override
  String get verified => 'موثق';

  @override
  String get unverified => 'غير موثق';

  @override
  String get verificationEmailSent =>
      'تم إرسال بريد التحقق إلى عنوان بريدك الإلكتروني. يرجى مراجعة صندوق الوارد واتباع التعليمات للتحقق من بريدك الإلكتروني.';

  @override
  String get unlockAllFeatures => 'فتح جميع الميزات';

  @override
  String get signInOrSignUp => 'سجل الدخول أو التسجيل';

  @override
  String get manageYourAccount => 'إدارة حسابك';

  @override
  String get accessYourData => 'الوصول إلى بياناتك';

  @override
  String get nameCannotBeEmpty => 'الاسم لا يمكن أن يكون فارغاً';

  @override
  String get nameMinLength => 'الاسم يجب أن يكون 2 أحرف على الأقل';

  @override
  String get displayNameRequired => 'الاسم المعروض مطلوب';

  @override
  String get displayNameTooShort => 'الاسم المعروض يجب أن يكون حرفين على الأقل';

  @override
  String get emailCannotBeEmpty => 'البريد الإلكتروني لا يمكن أن يكون فارغاً';

  @override
  String get invalidEmailFormat => 'تنسيق البريد الإلكتروني غير صحيح';

  @override
  String get loginEmailCannotBeEmpty =>
      'البريد الإلكتروني لا يمكن أن يكون فارغاً';

  @override
  String get loginInvalidEmailFormat => 'تنسيق البريد الإلكتروني غير صحيح';

  @override
  String get passwordCannotBeEmpty => 'كلمة المرور لا يمكن أن تكون فارغة';

  @override
  String get passwordMinLength => 'كلمة المرور يجب أن تكون 8 أحرف على الأقل';

  @override
  String get passwordMustBeAtLeast8Characters =>
      'كلمة المرور يجب أن تكون 8 أحرف على الأقل';

  @override
  String get passwordTooShort => 'كلمة المرور يجب أن تكون 6 أحرف على الأقل';

  @override
  String get passwordTooWeak =>
      'كلمة المرور ضعيفة جداً. يرجى استخدام كلمة مرور أقوى';

  @override
  String get passwordComplexityRequirement =>
      'كلمة المرور يجب أن تحتوي على حرف كبير واحد على الأقل، وحرف صغير واحد، ورقم واحد';

  @override
  String get passwordMustContainUpperLowerAndDigit =>
      'كلمة المرور يجب أن تحتوي على حرف كبير واحد على الأقل، وحرف صغير واحد، ورقم واحد';

  @override
  String get passwordNeedsLowercase =>
      'كلمة المرور يجب أن تحتوي على حرف صغير واحد على الأقل';

  @override
  String get passwordNeedsUppercase =>
      'كلمة المرور يجب أن تحتوي على حرف كبير واحد على الأقل';

  @override
  String get passwordNeedsDigit =>
      'كلمة المرور يجب أن تحتوي على رقم واحد على الأقل';

  @override
  String get pleaseConfirmPassword => 'يرجى تأكيد كلمة المرور';

  @override
  String get pleaseConfirmYourPassword => 'يرجى تأكيد كلمة المرور';

  @override
  String get passwordsDoNotMatch => 'كلمتا المرور غير متطابقتين';

  @override
  String get currentPasswordRequired => 'كلمة المرور الحالية مطلوبة';

  @override
  String get newPasswordRequired => 'كلمة المرور الجديدة مطلوبة';

  @override
  String get confirmPasswordRequired => 'يرجى تأكيد كلمة المرور';

  @override
  String get incorrectCurrentPassword => 'كلمة المرور الحالية غير صحيحة';

  @override
  String get loginPasswordCannotBeEmpty => 'كلمة المرور لا يمكن أن تكون فارغة';

  @override
  String get loginPasswordTooShort =>
      'كلمة المرور يجب أن تكون 8 أحرف على الأقل';

  @override
  String get fixErrorsBeforeSubmitting => 'يرجى إصلاح الأخطاء قبل الإرسال.';

  @override
  String get invalidDisplayName => 'الاسم المعروض غير صحيح';

  @override
  String get areYouSure => 'هل أنت متأكد؟';

  @override
  String get confirmAction => 'يرجى تأكيد إجراءك';

  @override
  String get confirmDeleteTitle => 'حذف';

  @override
  String get confirmLogoutTitle => 'تسجيل الخروج';

  @override
  String get confirmExitTitle => 'خروج';

  @override
  String get confirmDelete => 'هل أنت متأكد من رغبتك في حذف هذا العنصر؟';

  @override
  String confirmDeleteItem(Object itemName) {
    return 'هل أنت متأكد من رغبتك في حذف $itemName؟';
  }

  @override
  String get confirmDeleteKhatma => 'بعد الحذف، ستحذف هذه الختمة نهائياً';

  @override
  String get confirmLogout => 'هل أنت متأكد من رغبتك في تسجيل الخروج؟';

  @override
  String get confirmExitApp => 'هل أنت متأكد من رغبتك في الخروج من التطبيق؟';

  @override
  String get logout => 'تسجيل الخروج';

  @override
  String get exitApp => 'الخروج من التطبيق';

  @override
  String get exit => 'خروج';

  @override
  String get terminate => 'إنهاء';

  @override
  String khatmaFinishedMessage(Object timeAgo) {
    return 'لقد أنهيت ختمتك منذ $timeAgo.';
  }

  @override
  String get completion => 'الإنجاز';

  @override
  String get khatmaHistory => 'تاريخ الختمات';

  @override
  String get congratulations => 'تهانينا';

  @override
  String get khatmaListTitle => 'قائمة الختمات';

  @override
  String get khatmaListSubtitle => 'ختماتك الجارية';

  @override
  String get noKhatmaYet => 'لا توجد ختمة بعد';

  @override
  String get createKhatmaToStart => 'أنشئ ختمة للبدء';

  @override
  String get account => 'الحساب';

  @override
  String get helpAndSupport => 'المساعدة والدعم';

  @override
  String get accessYourKhatmas => 'الوصول إلى ختماتك وتقدمك';

  @override
  String get managePersonalInfo => 'إدارة معلوماتك الشخصية';

  @override
  String get preferencesAndOptions => 'التفضيلات وخيارات التطبيق';

  @override
  String get commonQuestions => 'العثور على إجابات للأسئلة الشائعة';

  @override
  String get termsAndPrivacy => 'شروط الخدمة وسياسة الخصوصية';

  @override
  String get learnMoreAboutKhatma => 'تعرف أكثر على مهمتنا';

  @override
  String get getHelpFromTeam => 'احصل على المساعدة من فريق الدعم';

  @override
  String get madeWithLove => 'صُنع بـ ❤️ للمجتمع المسلم';

  @override
  String get success => 'نجح';

  @override
  String get congratulation => 'تهانينا!';

  @override
  String get accountCreatedSuccessfully => 'تم إنشاء الحساب بنجاح!';

  @override
  String successCompleteParts(Object count) {
    return 'تم إنجاز $count أجزاء بنجاح';
  }

  @override
  String get khatmaCompleted => 'ختمة مكتملة';

  @override
  String get backToHome => 'العودة إلى الرئيسية';

  @override
  String get journeyDetails => 'تفاصيل الرحلة';

  @override
  String get started => 'بدأت';

  @override
  String get completed => 'مكتمل';

  @override
  String get totalDuration => 'المدة الإجمالية';

  @override
  String daysCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count يوم',
      many: '$count يوماً',
      few: '$count أيام',
      two: 'يومان',
      one: 'يوم واحد',
    );
    return '$_temp0';
  }

  @override
  String get shareAchievement => 'مشاركة الإنجاز';

  @override
  String get signInFailed => 'فشل تسجيل الدخول';

  @override
  String get loginFailed => 'فشل تسجيل الدخول';

  @override
  String get registrationFailed =>
      'فشل التسجيل. يرجى المحاولة مرة أخرى لاحقاً.';

  @override
  String get anonymousSignInFailed => 'فشل تسجيل الدخول المجهول';

  @override
  String get googleSignInFailed => 'فشل تسجيل الدخول بجوجل';

  @override
  String get updateProfileError =>
      'فشل تحديث الملف الشخصي. يرجى المحاولة مرة أخرى';

  @override
  String get errorLoadingProfile =>
      'خطأ في تحميل الملف الشخصي. يرجى المحاولة مرة أخرى لاحقاً.';

  @override
  String get networkError => 'خطأ في الشبكة. يرجى التحقق من الاتصال';

  @override
  String get permissionDenied => 'تم رفض الإذن';

  @override
  String get pleaseTryAgain => 'يرجى المحاولة مرة أخرى.';

  @override
  String get criticalError => 'خطأ حرج';

  @override
  String get error => 'خطأ';

  @override
  String get errorCode => 'رمز الخطأ';

  @override
  String get cannotUpdateKhatmaWhileStarted =>
      'لا يمكن تحديث الختمة بينما هي مبدوءة';

  @override
  String get failedToSaveKhatma => 'فشل حفظ الختمة. يرجى المحاولة مرة أخرى.';

  @override
  String get failedToLoadKhatma => 'فشل تحميل الختمة. يرجى المحاولة مرة أخرى.';

  @override
  String get failedToDeleteKhatma => 'فشل حذف الختمة. يرجى المحاولة مرة أخرى.';

  @override
  String get failedToShareKhatma =>
      'فشل مشاركة الختمة. يرجى المحاولة مرة أخرى.';

  @override
  String get errorOccurred => 'حدث خطأ';

  @override
  String get pageNotFound => 'الصفحة غير موجودة';

  @override
  String get pageNotFound404 => 'خطأ 404 - الصفحة غير موجودة';

  @override
  String get notImplemented => 'الميزة غير متوفرة';

  @override
  String get goToHome => 'الانتقال إلى الصفحة الرئيسية';

  @override
  String get errorAuthUserNotLoggedIn => 'المستخدم غير مسجل الدخول.';

  @override
  String get errorAuthAnonymousNotAllowed => 'تسجيل الدخول المجهول غير مسموح.';

  @override
  String get errorAuthSessionExpired => 'انتهت صلاحية الجلسة.';

  @override
  String get errorAuthPermissionDenied => 'تم رفض الإذن.';

  @override
  String get errorAuthInvalidAccount => 'تفاصيل الحساب غير صحيحة.';

  @override
  String get errorAuthAccountExistsWithDifferentCredentials =>
      'يوجد حساب بالفعل ببيانات اعتماد مختلفة.';

  @override
  String get errorAuthInvalidCredentials =>
      'بيانات الاعتماد المقدمة غير صحيحة.';

  @override
  String get errorAuthInvalidEmail => 'عنوان البريد الإلكتروني غير صحيح.';

  @override
  String get errorAuthOperationNotAllowed => 'العملية غير مسموحة.';

  @override
  String get errorAuthUserDisabled => 'حساب المستخدم معطل.';

  @override
  String get errorAuthUserNotFound => 'المستخدم غير موجود.';

  @override
  String get errorAuthEmailAlreadyInUse =>
      'عنوان البريد الإلكتروني مستخدم بالفعل.';

  @override
  String get errorAuthWeakPassword => 'كلمة المرور المقدمة ضعيفة.';

  @override
  String get errorAuthRequiresRecentLogin => 'يتطلب تسجيل دخول حديث.';

  @override
  String get errorAuthTooManyRequests => 'تم إجراء طلبات كثيرة جداً.';

  @override
  String get errorAuthNetworkRequestFailed => 'فشل طلب الشبكة.';

  @override
  String get errorAuthPopupBlocked => 'تم حظر النافذة المنبثقة من قبل المتصفح.';

  @override
  String get errorAuthPopClosedByUser => 'أغلق المستخدم النافذة المنبثقة.';

  @override
  String get errorNetConnectionFailed => 'فشل الاتصال بالإنترنت.';

  @override
  String get errorNetTimeout => 'انتهت مهلة طلب الشبكة.';

  @override
  String get errorNetServerError => 'واجه الخادم خطأ.';

  @override
  String get errorNetNotFound => 'المورد المطلوب غير موجود.';

  @override
  String get errorNetUnauthorized => 'وصول غير مصرح به.';

  @override
  String get errorNetRateLimit => 'تم تجاوز حد المعدل.';

  @override
  String get errorNetBadRequest => 'طلب سيء أرسل إلى الخادم.';

  @override
  String get errorNetUnavailable => 'خدمة الشبكة غير متاحة.';

  @override
  String get errorAuthActionCancelled => 'تم إلغاء إجراء المصادقة.';

  @override
  String get errorSyncGeneralFailure => 'فشل التزامن.';

  @override
  String get errorSyncConflict => 'حدث تعارض في البيانات أثناء التزامن.';

  @override
  String get errorSyncCorruptData => 'البيانات تالفة ولا يمكن مزامنتها.';

  @override
  String get errorSyncInProgress => 'التزامن جاري بالفعل.';

  @override
  String get errorSyncPartialFailure => 'حدث فشل جزئي في التزامن.';

  @override
  String get errorSyncStatusFailed => 'فشل في استرداد حالة التزامن.';

  @override
  String get errorStorageSaveFailed => 'فشل حفظ البيانات.';

  @override
  String get errorStorageDeleteFailed => 'فشل حذف البيانات.';

  @override
  String get errorStorageLoadFailed => 'فشل تحميل البيانات.';

  @override
  String get errorStorageFull => 'التخزين ممتلئ.';

  @override
  String get errorStorageCorrupted => 'التخزين تالف.';

  @override
  String get errorStoragePermissionDenied => 'تم رفض الإذن للوصول إلى التخزين.';

  @override
  String get errorValidationInvalidData => 'البيانات المقدمة غير صحيحة.';

  @override
  String get errorValidationMissingFields => 'الحقول المطلوبة مفقودة.';

  @override
  String get errorValidationInvalidFormat => 'تنسيق البيانات غير صحيح.';

  @override
  String get errorValidationOutOfRange => 'القيمة خارج النطاق المسموح.';

  @override
  String get errorValidationInvalidDate => 'التاريخ المقدم غير صحيح.';

  @override
  String get errorValidationInvalidOperation => 'تم محاولة عملية غير صحيحة.';

  @override
  String get errorKhatmaNotFound => 'الختمة غير موجودة.';

  @override
  String get errorKhatmaAlreadyCompleted => 'هذه الختمة مكتملة بالفعل.';

  @override
  String get errorKhatmaDeletionNotAllowed => 'لا يمكن حذف هذه الختمة.';

  @override
  String get errorKhatmaArchiveFailed => 'فشل أرشفة الختمة.';

  @override
  String get errorKhatmaInvalidParts => 'أجزاء الختمة غير صحيحة.';

  @override
  String get errorKhatmaMarkCompletedFailed => 'لا يمكن تسييل الختمة كمكتملة.';

  @override
  String get errorKhatmaRepeatFailed => 'فشل إعادة الختمة.';

  @override
  String get errorNoPartsSelected => 'لا توجد أجزاء محددة.';

  @override
  String get errorNoKhatmaSelected => 'لا توجد ختمة محددة.';

  @override
  String get errorLimitKhatmaMaxReached =>
      'تم الوصول إلى العدد الأقصى للختمات.';

  @override
  String get errorLimitStorageQuotaExceeded => 'تم تجاوز حصة التخزين.';

  @override
  String get errorLimitCreationNotAllowed => 'الإنشاء غير مسموح بسبب الحدود.';

  @override
  String get errorHistoryCreateFailed => 'فشل إنشاء التاريخ.';

  @override
  String get errorHistoryLoadFailed => 'فشل تحميل التاريخ.';

  @override
  String get errorHistoryDeleteFailed => 'فشل حذف التاريخ.';

  @override
  String get errorHistoryNotFound => 'التاريخ غير موجود.';

  @override
  String get errorSearchFailed => 'فشل البحث.';

  @override
  String get errorSearchNoResults => 'لم يتم العثور على نتائج.';

  @override
  String get errorSearchInvalidQuery => 'استعلام البحث غير صحيح.';

  @override
  String get errorSearchTimeout => 'انتهت مهلة البحث.';

  @override
  String get errorStatsCalculationFailed => 'فشل حساب الإحصائيات.';

  @override
  String get errorStatsNoData => 'لا توجد بيانات متاحة للإحصائيات.';

  @override
  String get errorStatsExportFailed => 'فشل تصدير الإحصائيات.';

  @override
  String get errorGeneralUnknown => 'حدث خطأ غير معروف.';

  @override
  String get errorGeneralCancelled => 'تم إلغاء العملية.';

  @override
  String get errorGeneralInvalidOperation => 'عملية غير صحيحة.';

  @override
  String get errorGeneralUnavailableResource => 'المورد غير متاح.';

  @override
  String get errorGeneralTimeout => 'انتهت مهلة العملية.';

  @override
  String get errorGeneralOutOfMemory => 'النظام خارج الذاكرة.';

  @override
  String get errorGeneralConfigError => 'حدث خطأ في التكوين.';

  @override
  String get errorGeneralInitializationFailed => 'فشل التهيئة.';

  @override
  String get errorDateRangeInvalid => 'نطاق التاريخ غير صحيح.';

  @override
  String get errorDateFormatInvalid => 'تنسيق التاريخ غير صحيح.';

  @override
  String get errorDateParsingFailed => 'فشل تحليل التاريخ.';

  @override
  String get errorPermissionDenied => 'تم رفض الإذن.';

  @override
  String get errorPermissionFeatureDisabled => 'الميزة معطلة بسبب الأذونات.';

  @override
  String get errorPermissionInsufficient => 'أذونات غير كافية للمتابعة.';

  @override
  String get newKhatma => 'ختمة جديدة';

  @override
  String get editKhatma => 'تعديل الختمة';

  @override
  String get khatma => 'ختمة';

  @override
  String get khatmaList => 'قائمة الختمات';

  @override
  String get shareKhatma => 'مشاركة الختمة';

  @override
  String get chooseKhatmaStyle => 'اختر نمط ختمتك';

  @override
  String get khatmaStyle => 'نمط الختمة';

  @override
  String get quran => 'القرآن';

  @override
  String get title => 'العنوان';

  @override
  String get nameHint => 'أدخل اسم الختمة';

  @override
  String get description => 'الوصف';

  @override
  String get descriptionHint => 'أدخل وصفاً (اختياري)';

  @override
  String get icon => 'الأيقونة';

  @override
  String get chooseIcon => 'اختر الأيقونة';

  @override
  String get color => 'اللون';

  @override
  String get chooseColor => 'اختر اللون';

  @override
  String get share => 'مشاركة';

  @override
  String get splitUnit => 'وحدة التقسيم';

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
  String khatmaSplitUnitWithDef(String unit) {
    String _temp0 = intl.Intl.selectLogic(
      unit,
      {
        'sourat': 'السورة',
        'juzz': 'الجزء',
        'hizb': 'الحزب',
        'half': 'نصف الحزب',
        'rubue': 'ربع الحزب',
        'thumun': 'ثمن الحزب',
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
        'sourat': 'سورة (114 جزء)',
        'juzz': 'جزء (30 جزء)',
        'hizb': 'حزب (60 جزء)',
        'half': 'نصف حزب (120 جزء)',
        'rubue': 'ربع حزب (240 جزء)',
        'thumun': 'ثمن حزب (480 جزء)',
        'other': '',
      },
    );
    return '$_temp0';
  }

  @override
  String ordinalPartNumber(String num) {
    String _temp0 = intl.Intl.selectLogic(
      num,
      {
        '1': 'الأول',
        '2': 'الثاني',
        '3': 'الثالث',
        '4': 'الرابع',
        '5': 'الخامس',
        '6': 'السادس',
        '7': 'السابع',
        '8': 'الثامن',
        '9': 'التاسع',
        '10': 'العاشر',
        '11': 'الحادي عشر',
        '12': 'الثاني عشر',
        '13': 'الثالث عشر',
        '14': 'الرابع عشر',
        '15': 'الخامس عشر',
        '16': 'السادس عشر',
        '17': 'السابع عشر',
        '18': 'الثامن عشر',
        '19': 'التاسع عشر',
        '20': 'العشرون',
        '21': 'الحادي والعشرون',
        '22': 'الثاني والعشرون',
        '23': 'الثالث والعشرون',
        '24': 'الرابع والعشرون',
        '25': 'الخامس والعشرون',
        '26': 'السادس والعشرون',
        '27': 'السابع والعشرون',
        '28': 'الثامن والعشرون',
        '29': 'التاسع والعشرون',
        '30': 'الثلاثون',
        '31': 'الحادي والثلاثون',
        '32': 'الثاني والثلاثون',
        '33': 'الثالث والثلاثون',
        '34': 'الرابع والثلاثون',
        '35': 'الخامس والثلاثون',
        '36': 'السادس والثلاثون',
        '37': 'السابع والثلاثون',
        '38': 'الثامن والثلاثون',
        '39': 'التاسع والثلاثون',
        '40': 'الأربعون',
        '41': 'الحادي والأربعون',
        '42': 'الثاني والأربعون',
        '43': 'الثالث والأربعون',
        '44': 'الرابع والأربعون',
        '45': 'الخامس والأربعون',
        '46': 'السادس والأربعون',
        '47': 'السابع والأربعون',
        '48': 'الثامن والأربعون',
        '49': 'التاسع والأربعون',
        '50': 'الخمسون',
        '51': 'الحادي والخمسون',
        '52': 'الثاني والخمسون',
        '53': 'الثالث والخمسون',
        '54': 'الرابع والخمسون',
        '55': 'الخامس والخمسون',
        '56': 'السادس والخمسون',
        '57': 'السابع والخمسون',
        '58': 'الثامن والخمسون',
        '59': 'التاسع والخمسون',
        '60': 'الستون',
        'other': '',
      },
    );
    return '$_temp0';
  }

  @override
  String get loading => 'جارٍ التحميل';

  @override
  String get loadingKhatma => 'جارٍ تحميل الختمة';

  @override
  String get loadingKhatmaList => 'جارٍ تحميل قائمة الختمات';

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
  String remainingPartsOfTotal(Object remaining, Object total) {
    return '$remaining من $total جزء';
  }

  @override
  String completeParts(Object count) {
    return 'إكمال ($count جزء)';
  }

  @override
  String selectedParts(num count) {
    return 'تم اختيار $count جزءًا';
  }

  @override
  String get maxPartToRead => 'أقصى جزء للقراءة';

  @override
  String get maxPartToReserve => 'أقصى جزء للحجز';

  @override
  String get recurrence => 'التكرار';

  @override
  String get schedule => 'الجدول';

  @override
  String get startDate => 'تاريخ البداية';

  @override
  String get endDate => 'تاريخ النهاية';

  @override
  String get every => 'كل';

  @override
  String get repeat => 'ختمة متكررة';

  @override
  String get noRepeat => 'بدون تكرار';

  @override
  String get repeatEvery => 'كرر كل';

  @override
  String get autoRepeatDescription => 'إعادة البدء تلقائياً عند الانتهاء';

  @override
  String repeatEverySelectedDaysDescription(Object count, Object days) {
    return 'ستكرر الختمة كل $days لكل $count أسابيع';
  }

  @override
  String repeatEverySelectedDayDescription(Object days) {
    return 'ستكرر الختمة كل $days لكل أسبوع';
  }

  @override
  String repeatEveryTimePeriodsDescription(Object count, Object unit) {
    return 'ستكرر الختمة كل $count $unit';
  }

  @override
  String repeatEveryTimePeriodDescription(Object unit) {
    return 'ستكرر الختمة كل $unit';
  }

  @override
  String get noRepeatDescription => 'إعادة البدء تلقائياً عند الانتهاء';

  @override
  String get repeatDescription => 'إعادة البدء تلقائياً عند الانتهاء';

  @override
  String repeatInterval(String recurrence) {
    String _temp0 = intl.Intl.selectLogic(
      recurrence,
      {
        'auto': 'تلقائي',
        'daily': 'يوم',
        'weekly': 'أسبوع',
        'monthly': 'شهر',
        'yearly': 'سنة',
        'other': 'أخرى',
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
        '1': 'الإثنين',
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
        'true': 'التكرار التلقائي مفعل',
        'false': 'التكرار التلقائي معطل',
        'other': 'أخرى',
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
        'group': 'مشاركة فقط برمز أو رمز الاستجابة السريعة',
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
        'public': 'الجميع مرحب بهم للوصول والانضمام للختمة',
        'group':
            'ستتم مشاركة الختمة فقط مع من يتلقون رقماً محدداً أو رمز الاستجابة السريعة',
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
  String get home => 'الرئيسية';

  @override
  String get settings => 'الإعدادات';

  @override
  String get about => 'حول';

  @override
  String get appPreferences => 'تفضيلات التطبيق';

  @override
  String get aboutUs => 'حولنا';

  @override
  String get learnMoreAboutApp => 'تعلم المزيد عن التطبيق';

  @override
  String get readMode => 'وضع القراءة';

  @override
  String get readLess => 'قراءة أقل';

  @override
  String get showMore => ' عرض المزيد';

  @override
  String get showLess => ' عرض أقل';

  @override
  String get language => 'اللغة';

  @override
  String get chooseLanguage => 'اختر اللغة';

  @override
  String get riwaya => 'الرواية';

  @override
  String get chooseRiwaya => 'اختر الرواية';

  @override
  String get recitation => 'القراءة';

  @override
  String get hafs => 'حفص';

  @override
  String get hafsDescription =>
      'القراءة الأكثر انتشاراً في العالم الإسلامي، خاصة في الشرق الأوسط.';

  @override
  String get warsh => 'ورش';

  @override
  String get warshDescription =>
      'شائعة في شمال أفريقيا. اختلافات طفيفة في النطق والإملاء.';

  @override
  String get theme => 'المظهر';

  @override
  String get chooseTheme => 'اختر المظهر';

  @override
  String themeMode(String mode) {
    String _temp0 = intl.Intl.selectLogic(
      mode,
      {
        'light': 'فاتح',
        'dark': 'مظلم',
        'system': 'النظام',
        'other': 'النظام',
      },
    );
    return '$_temp0';
  }

  @override
  String riwayaMode(String riwaya) {
    String _temp0 = intl.Intl.selectLogic(
      riwaya,
      {
        'hafs': 'Hafs',
        'warsh': 'Warsh',
        'other': 'Hafs',
      },
    );
    return '$_temp0';
  }

  @override
  String get faq => 'الأسئلة الشائعة';

  @override
  String get frequentlyAskedQuestions => 'الأسئلة المتكررة';

  @override
  String get contactSupport => 'الاتصال بالدعم';

  @override
  String get questionsAndSuggestions => 'الأسئلة والاقتراحات';

  @override
  String get onboarding1Title => 'أكمل ختمتك';

  @override
  String get onboarding1Description =>
      'تابع قراءتك اليومية للقرآن وتصور تقدمك نحو إتمام القرآن الكريم.';

  @override
  String get onboarding2Title => 'تلاوات جميلة';

  @override
  String get onboarding2Description =>
      'اغمر نفسك بصوت واضح كالكريستال من القراء المشهورين مع تمييز كلمة بكلمة.';

  @override
  String get onboarding3Title => 'تذكيرات يومية';

  @override
  String get onboarding3Description =>
      'اضبط تذكيرات روحية للحفاظ على اتصالك بالقرآن طوال يومك.';

  @override
  String get onboarding4Title => 'فهم عميق';

  @override
  String get onboarding4Description =>
      'احصل على تفسيرات متعددة وترجمات لإثراء معرفتك القرآنية.';

  @override
  String get skipButton => 'تخطي';

  @override
  String get continueButton => 'متابعة';

  @override
  String get startButton => 'ابدأ رحلة القرآن';

  @override
  String get registration_validation => 'رسائل التحقق من التسجيل';

  @override
  String get login_validation => 'رسائل التحقق من تسجيل الدخول';

  @override
  String get registration_ui => 'واجهة التسجيل';

  @override
  String get login_ui => 'واجهة تسجيل الدخول';

  @override
  String get form_types => 'أنواع النماذج';

  @override
  String get shared_fields => 'الحقول المشتركة';

  @override
  String get validation_messages => 'رسائل التحقق';

  @override
  String get password_criteria => 'معايير كلمة المرور';

  @override
  String get terms_and_actions => 'الشروط والإجراءات';

  @override
  String get rememberMe => 'تذكرني';

  @override
  String get ui_labels => 'تسميات الواجهة';

  @override
  String get openSettings => 'فتح الإعدادات';

  @override
  String get tryAgain => 'حاول مرة أخرى';

  @override
  String get authenticationError => 'خطأ في المصادقة';

  @override
  String get syncError => 'خطأ في المزامنة';

  @override
  String get storageError => 'خطأ في التخزين';

  @override
  String get validationError => 'خطأ في التحقق';

  @override
  String get khatmaError => 'خطأ في الختمة';

  @override
  String get limitError => 'تم الوصول إلى الحد الأقصى';

  @override
  String get historyError => 'خطأ في التاريخ';

  @override
  String get searchError => 'خطأ في البحث';

  @override
  String get statsError => 'خطأ في الإحصائيات';

  @override
  String get dateError => 'خطأ في التاريخ';

  @override
  String get permissionError => 'خطأ في الإذن';

  @override
  String get errorDialogExamples => 'أمثلة على حوارات الخطأ';

  @override
  String get networkErrors => 'أخطاء الشبكة';

  @override
  String get authenticationErrors => 'أخطاء المصادقة';

  @override
  String get storageErrors => 'أخطاء التخزين';

  @override
  String get validationErrors => 'أخطاء التحقق';

  @override
  String get khatmaErrors => 'أخطاء الختمة';

  @override
  String get connectionFailed => 'فشل الاتصال';

  @override
  String get timeout => 'انتهت المهلة';

  @override
  String get serverError => 'خطأ الخادم';

  @override
  String get userNotLoggedIn => 'المستخدم غير مسجل الدخول';

  @override
  String get sessionExpired => 'انتهت صلاحية الجلسة';

  @override
  String get storageFull => 'التخزين ممتلئ';

  @override
  String get storageCorrupted => 'التخزين تالف';

  @override
  String get saveFailed => 'فشل الحفظ';

  @override
  String get invalidData => 'بيانات غير صحيحة';

  @override
  String get missingFields => 'حقول مفقودة';

  @override
  String get invalidDate => 'تاريخ غير صحيح';

  @override
  String get khatmaNotFound => 'الختمة غير موجودة';

  @override
  String get alreadyCompleted => 'مكتملة بالفعل';

  @override
  String get invalidParts => 'أجزاء غير صحيحة';

  @override
  String get retrying => 'جاري إعادة المحاولة...';

  @override
  String get openingSignIn => 'جاري فتح تسجيل الدخول...';

  @override
  String get openingSettings => 'جاري فتح الإعدادات...';

  @override
  String get actionPerformed => 'تم تنفيذ الإجراء';

  @override
  String get displayNameTooLong => 'الاسم المعروض يجب أن يكون أقل من 50 حرف';

  @override
  String get displayNameInvalidCharacters =>
      'الاسم المعروض يحتوي على أحرف غير صحيحة';

  @override
  String get unexpectedError => 'حدث خطأ غير متوقع';

  @override
  String get contactUs => 'اتصل بنا';

  @override
  String get contactType => 'نوع التواصل';

  @override
  String get bugReport => 'تبليغ عن خطأ';

  @override
  String get bugReportDescription => 'بلّغ عن مشاكل تقنية أو أعطال في التطبيق';

  @override
  String get suggestion => 'اقتراح';

  @override
  String get suggestionDescription => 'شارك أفكارك لتحسين تجربة التطبيق';

  @override
  String get feedback => 'ملاحظات';

  @override
  String get feedbackDescription => 'أعطِ رأيك بشكل عام عن تجربتك مع التطبيق';

  @override
  String get other => 'غير ذلك';

  @override
  String get otherDescription => 'أي استفسار أو سؤال آخر';

  @override
  String get yourName => 'اسمك';

  @override
  String get enterYourName => 'أدخل اسمك';

  @override
  String get enterYourEmail => 'أدخل عنوان بريدك الإلكتروني';

  @override
  String get message => 'رسالة';

  @override
  String get writeYourMessage => 'اكتب رسالتك';

  @override
  String get sendMessage => 'إرسال الرسالة';

  @override
  String get contactViaEmail => 'التواصل عبر البريد الإلكتروني';

  @override
  String get pleaseEnterYourName => 'يرجى إدخال اسمك';

  @override
  String get nameMustBeAtLeast2Characters =>
      'يجب أن يكون الاسم على الأقل حرفين';

  @override
  String get pleaseEnterYourEmail => 'يرجى إدخال بريدك الإلكتروني';

  @override
  String get pleaseEnterValidEmail => 'يرجى إدخال عنوان بريد إلكتروني صحيح';

  @override
  String get pleaseEnterYourMessage => 'يرجى إدخال رسالتك';

  @override
  String get messageMustBeAtLeast10Characters =>
      'يجب أن تكون الرسالة على الأقل 10 أحرف';

  @override
  String get pleaseFillAllFieldsValid => 'يرجى ملء جميع الحقول بمعلومات صحيحة.';

  @override
  String get messageSentSuccessfully => 'تم إرسال الرسالة بنجاح!';

  @override
  String get failedToSendMessage =>
      'فشل في إرسال الرسالة. يرجى المحاولة مرة أخرى.';

  @override
  String contactFormSubject(String contactType) {
    return '[$contactType]: ';
  }

  @override
  String get sentViaKhatmaApp => 'مُرسل عبر تطبيق ختمة';

  @override
  String get chooseContactMethod => 'اختر طريقة التواصل';

  @override
  String get selectContactTypeDescription =>
      'حدد نوع الاستفسار للحصول على مساعدة أفضل';

  @override
  String get directEmailContact => 'تواصل مباشر عبر البريد الإلكتروني';

  @override
  String get openEmailApp => 'البريد الإلكتروني';

  @override
  String get unableToOpenEmail => 'تعذر فتح تطبيق البريد الإلكتروني';

  @override
  String get emailNotAvailable =>
      'تطبيق البريد الإلكتروني غير متوفر على هذا الجهاز';

  @override
  String get refresh => 'تحديث';

  @override
  String get failedToLoadFaq => 'فشل في تحميل الأسئلة الشائعة';

  @override
  String get noFaqAvailable => 'لا توجد أسئلة شائعة متاحة';

  @override
  String get dataSynchronization => 'مزامنة البيانات';

  @override
  String get chooseSyncMethod => 'اختر كيفية مزامنة بياناتك';

  @override
  String get syncStatus => 'حالة المزامنة';

  @override
  String get syncing => 'جاري المزامنة...';

  @override
  String lastSyncTime(String time) {
    return 'آخر مزامنة: $time';
  }

  @override
  String get neverSynced => 'لم تتم المزامنة مطلقاً';

  @override
  String get justNow => 'الآن';

  @override
  String minutesAgo(int count) {
    return 'منذ $count دقيقة';
  }

  @override
  String hoursAgo(int count) {
    return 'منذ $count ساعة';
  }

  @override
  String get fullSync => 'مزامنة كاملة';

  @override
  String get pullFromServer => 'تحميل من الخادم';

  @override
  String get pushToServer => 'رفع إلى الخادم';

  @override
  String get downloadRemoteChanges => 'تحميل أحدث التغييرات من الخادم';

  @override
  String get uploadLocalChanges => 'رفع تغييراتك المحلية إلى الخادم';

  @override
  String get performingFullSync => 'جاري تنفيذ المزامنة الكاملة...';

  @override
  String get downloadingChanges => 'جاري تحميل التغييرات من الخادم...';

  @override
  String get uploadingChanges => 'جاري رفع التغييرات إلى الخادم...';

  @override
  String get syncCompleted => 'تمت المزامنة بنجاح';

  @override
  String syncFailed(String error) {
    return 'فشلت المزامنة: $error';
  }

  @override
  String get syncNow => 'مزامنة الآن';

  @override
  String get syncWarning => 'تحذير المزامنة';

  @override
  String get syncUpToDate => 'محدث';

  @override
  String syncFailureCount(int count) {
    return '$count محاولات فاشلة';
  }

  @override
  String khatmasCount(int count) {
    return '$count ختمة';
  }

  @override
  String historyCount(int count) {
    return '$count عنصر تاريخ';
  }

  @override
  String get performBothUploadAndDownload => 'تنفيذ مزامنة الرفع والتحميل معاً';

  @override
  String get synchronizeYourData => 'مزامنة بيانات الختمة مع الخادم';

  @override
  String get syncCompletedSuccessfully => 'تمت المزامنة بنجاح';

  @override
  String get synchronizeData => 'مزامنة البيانات';

  @override
  String get synchronizeUploadAndDownload =>
      'رفع التغييرات المحلية وتحميل التحديثات';

  @override
  String get checkForUpdatesAndSync => 'التحقق من تحديثات الخادم والمزامنة';

  @override
  String get toUpload => 'للرفع';

  @override
  String get allDataSynchronized => 'تمت مزامنة جميع بياناتك بنجاح';

  @override
  String get synchronizingPleaseWait => 'جارٍ مزامنة بياناتك، يرجى الانتظار...';
}
