import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
    Locale('fr')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Khatma'**
  String get appTitle;

  /// No description provided for @newKhatma.
  ///
  /// In en, this message translates to:
  /// **'New khatma'**
  String get newKhatma;

  /// No description provided for @editKhatma.
  ///
  /// In en, this message translates to:
  /// **'Edit khatma'**
  String get editKhatma;

  /// No description provided for @recurrence.
  ///
  /// In en, this message translates to:
  /// **'Recurrence'**
  String get recurrence;

  /// No description provided for @schedule.
  ///
  /// In en, this message translates to:
  /// **'Schedule'**
  String get schedule;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @nameHint.
  ///
  /// In en, this message translates to:
  /// **'Enter the name of the Khatma'**
  String get nameHint;

  /// No description provided for @descriptionHint.
  ///
  /// In en, this message translates to:
  /// **'Enter a description (optional)'**
  String get descriptionHint;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @share.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get share;

  /// No description provided for @splitUnit.
  ///
  /// In en, this message translates to:
  /// **'Split unit'**
  String get splitUnit;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @create.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get create;

  /// No description provided for @apply.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get apply;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @submit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// No description provided for @previous.
  ///
  /// In en, this message translates to:
  /// **'Previous'**
  String get previous;

  /// No description provided for @finish.
  ///
  /// In en, this message translates to:
  /// **'Finish'**
  String get finish;

  /// No description provided for @copy.
  ///
  /// In en, this message translates to:
  /// **'Copy'**
  String get copy;

  /// No description provided for @copied.
  ///
  /// In en, this message translates to:
  /// **'Copied'**
  String get copied;

  /// No description provided for @copiedToClipboard.
  ///
  /// In en, this message translates to:
  /// **'Copied to clipboard'**
  String get copiedToClipboard;

  /// No description provided for @shareKhatma.
  ///
  /// In en, this message translates to:
  /// **'Share khatma'**
  String get shareKhatma;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading'**
  String get loading;

  /// No description provided for @loadingKhatma.
  ///
  /// In en, this message translates to:
  /// **'Loading khatma'**
  String get loadingKhatma;

  /// No description provided for @loadingKhatmaList.
  ///
  /// In en, this message translates to:
  /// **'Loading khatma list'**
  String get loadingKhatmaList;

  /// No description provided for @startDate.
  ///
  /// In en, this message translates to:
  /// **'Start date'**
  String get startDate;

  /// No description provided for @endDate.
  ///
  /// In en, this message translates to:
  /// **'End date'**
  String get endDate;

  /// No description provided for @every.
  ///
  /// In en, this message translates to:
  /// **'Every'**
  String get every;

  /// No description provided for @repeat.
  ///
  /// In en, this message translates to:
  /// **'Repeating Khatma'**
  String get repeat;

  /// No description provided for @noRepeat.
  ///
  /// In en, this message translates to:
  /// **'No repeat'**
  String get noRepeat;

  /// No description provided for @autoRepeatDescription.
  ///
  /// In en, this message translates to:
  /// **'Automatically restart when completed'**
  String get autoRepeatDescription;

  /// No description provided for @repeatEverySelectedDaysDescription.
  ///
  /// In en, this message translates to:
  /// **'Khatma will be repeated every {days} for evry {count} weeks'**
  String repeatEverySelectedDaysDescription(Object count, Object days);

  /// No description provided for @repeatEverySelectedDayDescription.
  ///
  /// In en, this message translates to:
  /// **'Khatma will be repeated every {days} for evry week'**
  String repeatEverySelectedDayDescription(Object days);

  /// No description provided for @repeatEveryTimePeriodsDescription.
  ///
  /// In en, this message translates to:
  /// **'Khatma will be repeated evry {count} {unit}s'**
  String repeatEveryTimePeriodsDescription(Object count, Object unit);

  /// No description provided for @repeatEveryTimePeriodDescription.
  ///
  /// In en, this message translates to:
  /// **'Khatma will be repeated evry {unit}'**
  String repeatEveryTimePeriodDescription(Object unit);

  /// No description provided for @noRepeatDescription.
  ///
  /// In en, this message translates to:
  /// **'Automatically restart when completed'**
  String get noRepeatDescription;

  /// No description provided for @repeatDescription.
  ///
  /// In en, this message translates to:
  /// **'Automatically restart when completed'**
  String get repeatDescription;

  /// No description provided for @repeatEvery.
  ///
  /// In en, this message translates to:
  /// **'Repeat very'**
  String get repeatEvery;

  /// No description provided for @icon.
  ///
  /// In en, this message translates to:
  /// **'Icon'**
  String get icon;

  /// No description provided for @color.
  ///
  /// In en, this message translates to:
  /// **'Color'**
  String get color;

  /// No description provided for @chooseColor.
  ///
  /// In en, this message translates to:
  /// **'Choose color'**
  String get chooseColor;

  /// No description provided for @chooseIcon.
  ///
  /// In en, this message translates to:
  /// **'Choose icon'**
  String get chooseIcon;

  /// No description provided for @khatmaList.
  ///
  /// In en, this message translates to:
  /// **'Khatma list'**
  String get khatmaList;

  /// No description provided for @quran.
  ///
  /// In en, this message translates to:
  /// **'Quran'**
  String get quran;

  /// No description provided for @khatma.
  ///
  /// In en, this message translates to:
  /// **'Khatma'**
  String get khatma;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @chooseLanguage.
  ///
  /// In en, this message translates to:
  /// **'Choose language'**
  String get chooseLanguage;

  /// No description provided for @chooseTheme.
  ///
  /// In en, this message translates to:
  /// **'Choose theme'**
  String get chooseTheme;

  /// No description provided for @readMode.
  ///
  /// In en, this message translates to:
  /// **'Read mode'**
  String get readMode;

  /// No description provided for @readLess.
  ///
  /// In en, this message translates to:
  /// **'Read less'**
  String get readLess;

  /// No description provided for @showMore.
  ///
  /// In en, this message translates to:
  /// **' show more'**
  String get showMore;

  /// No description provided for @showLess.
  ///
  /// In en, this message translates to:
  /// **' show less'**
  String get showLess;

  /// No description provided for @completed.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completed;

  /// No description provided for @completedParts.
  ///
  /// In en, this message translates to:
  /// **'Completed parts'**
  String get completedParts;

  /// No description provided for @remainingParts.
  ///
  /// In en, this message translates to:
  /// **'Remaining parts'**
  String get remainingParts;

  /// No description provided for @parts.
  ///
  /// In en, this message translates to:
  /// **'Parts'**
  String get parts;

  /// No description provided for @readedParts.
  ///
  /// In en, this message translates to:
  /// **'{count} parts'**
  String readedParts(Object count);

  /// No description provided for @confirmDelete.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this khatma?'**
  String get confirmDelete;

  /// No description provided for @successCompleteParts.
  ///
  /// In en, this message translates to:
  /// **'{count} parts completed successfully'**
  String successCompleteParts(Object count);

  /// No description provided for @remainingPartsOfTotal.
  ///
  /// In en, this message translates to:
  /// **'{remaining} of {total} parts'**
  String remainingPartsOfTotal(Object remaining, Object total);

  /// No description provided for @completeParts.
  ///
  /// In en, this message translates to:
  /// **'Complete ({count} parts)'**
  String completeParts(Object count);

  /// No description provided for @chooseKhatmaStyle.
  ///
  /// In en, this message translates to:
  /// **'Choose your khatma\'s style'**
  String get chooseKhatmaStyle;

  /// No description provided for @khatmaStyle.
  ///
  /// In en, this message translates to:
  /// **'Khatma style'**
  String get khatmaStyle;

  /// No description provided for @khatmaSplitUnit.
  ///
  /// In en, this message translates to:
  /// **'{unit, select, sourat{Sourat} juzz{Juzz} hizb{Hizb} half{Half-Hizb} rubue{Fourth-hizb} thumun{Eighth-hizb} other{}}'**
  String khatmaSplitUnit(String unit);

  /// No description provided for @khatmaSplitUnitDesc.
  ///
  /// In en, this message translates to:
  /// **'{unit, select, sourat{Sourat (114 parts)} juzz{Juzz (30 parts)} hizb{Hizb (60 parts)} half{Half-Hizb (120 parts)} rubue{Fourth-hizb (240 parts)} thumun{Eighth-hizb (480 parts)} other{}}'**
  String khatmaSplitUnitDesc(String unit);

  /// No description provided for @repeatInterval.
  ///
  /// In en, this message translates to:
  /// **'{recurrence, select, auto{Auto} daily{Day} weekly{Week} monthly{Month} yearly{Year} other{Other}}'**
  String repeatInterval(String recurrence);

  /// No description provided for @timePeriods.
  ///
  /// In en, this message translates to:
  /// **'{period, select, daily{Day} weekly{Week} monthly{Month} yearly{Year} other{}}'**
  String timePeriods(String period);

  /// No description provided for @weekDay.
  ///
  /// In en, this message translates to:
  /// **'{day, select,  1{Monday} 2{Tuesday} 3{Wednesday} 4{Thursday} 5{Friday} 6{Saturday} 7{Sunday} other{Other}}'**
  String weekDay(String day);

  /// No description provided for @shortWeekDay.
  ///
  /// In en, this message translates to:
  /// **'{day, select,  1{M} 2{T} 3{W} 4{T} 5{F} 6{S} 7{S} other{O}}'**
  String shortWeekDay(String day);

  /// No description provided for @repeatOption.
  ///
  /// In en, this message translates to:
  /// **'{scheduler, select, true{Auto-repeat is enabled} false{Auto-repeat is disabled} other{Other}}'**
  String repeatOption(String scheduler);

  /// No description provided for @shareVisibility.
  ///
  /// In en, this message translates to:
  /// **'{share, select, other{Private} public{Public} group{Group}}'**
  String shareVisibility(String share);

  /// No description provided for @shareVisibilityDesc.
  ///
  /// In en, this message translates to:
  /// **'{share, select, other{This khatma is private} public{Everyone can access and participate} group{Shared only by code or QR code}}'**
  String shareVisibilityDesc(String share);

  /// No description provided for @shareVisibilityDescription.
  ///
  /// In en, this message translates to:
  /// **'{share, select, other{The khatma will be kept private and exclusive to the organizer} public{Everyone is welcome to access and join the khatma} group{The khatma will be shared only with those who receive a specific number or QR code}}'**
  String shareVisibilityDescription(String share);

  /// No description provided for @maxParticipants.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No participants} =1{1 participant} other{# participants}}'**
  String maxParticipants(num count);

  /// No description provided for @maxPartToRead.
  ///
  /// In en, this message translates to:
  /// **'Max part to read'**
  String get maxPartToRead;

  /// No description provided for @maxPartToReserve.
  ///
  /// In en, this message translates to:
  /// **'Max part to reserve'**
  String get maxPartToReserve;

  /// No description provided for @title.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get title;

  /// No description provided for @areYouSure.
  ///
  /// In en, this message translates to:
  /// **'Are you sure?'**
  String get areYouSure;

  /// No description provided for @confirmDeleteKhatma.
  ///
  /// In en, this message translates to:
  /// **'After deleting, this khatma will be permanently deleted'**
  String get confirmDeleteKhatma;

  /// No description provided for @congratulation.
  ///
  /// In en, this message translates to:
  /// **'Congratulations!'**
  String get congratulation;

  /// No description provided for @emailInputLabel.
  ///
  /// In en, this message translates to:
  /// **'Enter your gemail'**
  String get emailInputLabel;

  /// No description provided for @passwordInputLabel.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get passwordInputLabel;

  /// No description provided for @themeMode.
  ///
  /// In en, this message translates to:
  /// **'{mode, select, light{Light} dark{Dark} system{System} other{System}}'**
  String themeMode(String mode);

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// Title for first onboarding screen about Khatma tracking
  ///
  /// In en, this message translates to:
  /// **'Complete Your Khatma'**
  String get onboarding1Title;

  /// No description provided for @onboarding1Description.
  ///
  /// In en, this message translates to:
  /// **'Track your daily Quran reading and visualize your progress toward completing the Holy Quran.'**
  String get onboarding1Description;

  /// No description provided for @onboarding2Title.
  ///
  /// In en, this message translates to:
  /// **'Beautiful Recitations'**
  String get onboarding2Title;

  /// No description provided for @onboarding2Description.
  ///
  /// In en, this message translates to:
  /// **'Immerse yourself with crystal-clear audio from renowned reciters with word-by-word highlighting.'**
  String get onboarding2Description;

  /// No description provided for @onboarding3Title.
  ///
  /// In en, this message translates to:
  /// **'Daily Reminders'**
  String get onboarding3Title;

  /// No description provided for @onboarding3Description.
  ///
  /// In en, this message translates to:
  /// **'Set spiritual reminders to maintain your connection with the Quran throughout your day.'**
  String get onboarding3Description;

  /// No description provided for @onboarding4Title.
  ///
  /// In en, this message translates to:
  /// **'Deep Understanding'**
  String get onboarding4Title;

  /// No description provided for @onboarding4Description.
  ///
  /// In en, this message translates to:
  /// **'Access multiple tafsir explanations and translations to enrich your Quranic knowledge.'**
  String get onboarding4Description;

  /// No description provided for @skipButton.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skipButton;

  /// No description provided for @continueButton.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueButton;

  /// No description provided for @startButton.
  ///
  /// In en, this message translates to:
  /// **'Begin Quran Journey'**
  String get startButton;

  /// No description provided for @errorAuthUserNotLoggedIn.
  ///
  /// In en, this message translates to:
  /// **'User not logged in.'**
  String get errorAuthUserNotLoggedIn;

  /// No description provided for @errorAuthAnonymousNotAllowed.
  ///
  /// In en, this message translates to:
  /// **'Anonymous login is not allowed.'**
  String get errorAuthAnonymousNotAllowed;

  /// No description provided for @errorAuthSessionExpired.
  ///
  /// In en, this message translates to:
  /// **'Session has expired.'**
  String get errorAuthSessionExpired;

  /// No description provided for @errorAuthPermissionDenied.
  ///
  /// In en, this message translates to:
  /// **'Permission denied.'**
  String get errorAuthPermissionDenied;

  /// No description provided for @errorAuthInvalidAccount.
  ///
  /// In en, this message translates to:
  /// **'Invalid account details.'**
  String get errorAuthInvalidAccount;

  /// No description provided for @errorNetConnectionFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to connect to the internet.'**
  String get errorNetConnectionFailed;

  /// No description provided for @errorNetTimeout.
  ///
  /// In en, this message translates to:
  /// **'Network request timed out.'**
  String get errorNetTimeout;

  /// No description provided for @errorNetServerError.
  ///
  /// In en, this message translates to:
  /// **'Server encountered an error.'**
  String get errorNetServerError;

  /// No description provided for @errorNetNotFound.
  ///
  /// In en, this message translates to:
  /// **'Requested resource not found.'**
  String get errorNetNotFound;

  /// No description provided for @errorNetUnauthorized.
  ///
  /// In en, this message translates to:
  /// **'Unauthorized access.'**
  String get errorNetUnauthorized;

  /// No description provided for @errorNetRateLimit.
  ///
  /// In en, this message translates to:
  /// **'Rate limit exceeded.'**
  String get errorNetRateLimit;

  /// No description provided for @errorNetBadRequest.
  ///
  /// In en, this message translates to:
  /// **'Bad request sent to server.'**
  String get errorNetBadRequest;

  /// No description provided for @errorNetUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Network service is unavailable.'**
  String get errorNetUnavailable;

  /// No description provided for @errorSyncGeneralFailure.
  ///
  /// In en, this message translates to:
  /// **'Synchronization failed.'**
  String get errorSyncGeneralFailure;

  /// No description provided for @errorSyncConflict.
  ///
  /// In en, this message translates to:
  /// **'Data conflict occurred during sync.'**
  String get errorSyncConflict;

  /// No description provided for @errorSyncCorruptData.
  ///
  /// In en, this message translates to:
  /// **'Data is corrupted and cannot be synced.'**
  String get errorSyncCorruptData;

  /// No description provided for @errorSyncInProgress.
  ///
  /// In en, this message translates to:
  /// **'A sync is already in progress.'**
  String get errorSyncInProgress;

  /// No description provided for @errorSyncPartialFailure.
  ///
  /// In en, this message translates to:
  /// **'Partial sync failure occurred.'**
  String get errorSyncPartialFailure;

  /// No description provided for @errorSyncStatusFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to retrieve sync status.'**
  String get errorSyncStatusFailed;

  /// No description provided for @errorStorageSaveFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to save data.'**
  String get errorStorageSaveFailed;

  /// No description provided for @errorStorageDeleteFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to delete data.'**
  String get errorStorageDeleteFailed;

  /// No description provided for @errorStorageLoadFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to load data.'**
  String get errorStorageLoadFailed;

  /// No description provided for @errorStorageFull.
  ///
  /// In en, this message translates to:
  /// **'Storage is full.'**
  String get errorStorageFull;

  /// No description provided for @errorStorageCorrupted.
  ///
  /// In en, this message translates to:
  /// **'Storage is corrupted.'**
  String get errorStorageCorrupted;

  /// No description provided for @errorStoragePermissionDenied.
  ///
  /// In en, this message translates to:
  /// **'Permission denied for storage access.'**
  String get errorStoragePermissionDenied;

  /// No description provided for @errorValidationInvalidData.
  ///
  /// In en, this message translates to:
  /// **'Invalid data provided.'**
  String get errorValidationInvalidData;

  /// No description provided for @errorValidationMissingFields.
  ///
  /// In en, this message translates to:
  /// **'Required fields are missing.'**
  String get errorValidationMissingFields;

  /// No description provided for @errorValidationInvalidFormat.
  ///
  /// In en, this message translates to:
  /// **'Invalid data format.'**
  String get errorValidationInvalidFormat;

  /// No description provided for @errorValidationOutOfRange.
  ///
  /// In en, this message translates to:
  /// **'Value is out of allowed range.'**
  String get errorValidationOutOfRange;

  /// No description provided for @errorValidationInvalidDate.
  ///
  /// In en, this message translates to:
  /// **'Invalid date provided.'**
  String get errorValidationInvalidDate;

  /// No description provided for @errorKhatmaNotFound.
  ///
  /// In en, this message translates to:
  /// **'Khatma not found.'**
  String get errorKhatmaNotFound;

  /// No description provided for @errorKhatmaAlreadyCompleted.
  ///
  /// In en, this message translates to:
  /// **'This Khatma is already completed.'**
  String get errorKhatmaAlreadyCompleted;

  /// No description provided for @errorKhatmaDeletionNotAllowed.
  ///
  /// In en, this message translates to:
  /// **'Cannot delete this Khatma.'**
  String get errorKhatmaDeletionNotAllowed;

  /// No description provided for @errorKhatmaArchiveFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to archive Khatma.'**
  String get errorKhatmaArchiveFailed;

  /// No description provided for @errorKhatmaInvalidParts.
  ///
  /// In en, this message translates to:
  /// **'Invalid Khatma parts.'**
  String get errorKhatmaInvalidParts;

  /// No description provided for @errorKhatmaMarkCompletedFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not mark Khatma as completed.'**
  String get errorKhatmaMarkCompletedFailed;

  /// No description provided for @errorKhatmaRepeatFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to repeat Khatma.'**
  String get errorKhatmaRepeatFailed;

  /// No description provided for @errorLimitKhatmaMaxReached.
  ///
  /// In en, this message translates to:
  /// **'Maximum number of Khatma reached.'**
  String get errorLimitKhatmaMaxReached;

  /// No description provided for @errorLimitStorageQuotaExceeded.
  ///
  /// In en, this message translates to:
  /// **'Storage quota exceeded.'**
  String get errorLimitStorageQuotaExceeded;

  /// No description provided for @errorLimitCreationNotAllowed.
  ///
  /// In en, this message translates to:
  /// **'Creation not allowed due to limits.'**
  String get errorLimitCreationNotAllowed;

  /// No description provided for @errorHistoryCreateFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to create history.'**
  String get errorHistoryCreateFailed;

  /// No description provided for @errorHistoryLoadFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to load history.'**
  String get errorHistoryLoadFailed;

  /// No description provided for @errorHistoryDeleteFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to delete history.'**
  String get errorHistoryDeleteFailed;

  /// No description provided for @errorHistoryNotFound.
  ///
  /// In en, this message translates to:
  /// **'History not found.'**
  String get errorHistoryNotFound;

  /// No description provided for @errorSearchFailed.
  ///
  /// In en, this message translates to:
  /// **'Search failed.'**
  String get errorSearchFailed;

  /// No description provided for @errorSearchNoResults.
  ///
  /// In en, this message translates to:
  /// **'No results found.'**
  String get errorSearchNoResults;

  /// No description provided for @errorSearchInvalidQuery.
  ///
  /// In en, this message translates to:
  /// **'Invalid search query.'**
  String get errorSearchInvalidQuery;

  /// No description provided for @errorSearchTimeout.
  ///
  /// In en, this message translates to:
  /// **'Search timed out.'**
  String get errorSearchTimeout;

  /// No description provided for @errorStatsCalculationFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to calculate statistics.'**
  String get errorStatsCalculationFailed;

  /// No description provided for @errorStatsNoData.
  ///
  /// In en, this message translates to:
  /// **'No data available for statistics.'**
  String get errorStatsNoData;

  /// No description provided for @errorStatsExportFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to export statistics.'**
  String get errorStatsExportFailed;

  /// No description provided for @errorGeneralUnknown.
  ///
  /// In en, this message translates to:
  /// **'An unknown error occurred.'**
  String get errorGeneralUnknown;

  /// No description provided for @errorGeneralCancelled.
  ///
  /// In en, this message translates to:
  /// **'The operation was cancelled.'**
  String get errorGeneralCancelled;

  /// No description provided for @errorGeneralInvalidOperation.
  ///
  /// In en, this message translates to:
  /// **'Invalid operation.'**
  String get errorGeneralInvalidOperation;

  /// No description provided for @errorGeneralUnavailableResource.
  ///
  /// In en, this message translates to:
  /// **'The resource is unavailable.'**
  String get errorGeneralUnavailableResource;

  /// No description provided for @errorGeneralTimeout.
  ///
  /// In en, this message translates to:
  /// **'The operation timed out.'**
  String get errorGeneralTimeout;

  /// No description provided for @errorGeneralOutOfMemory.
  ///
  /// In en, this message translates to:
  /// **'The system is out of memory.'**
  String get errorGeneralOutOfMemory;

  /// No description provided for @errorGeneralConfigError.
  ///
  /// In en, this message translates to:
  /// **'Configuration error occurred.'**
  String get errorGeneralConfigError;

  /// No description provided for @errorGeneralInitializationFailed.
  ///
  /// In en, this message translates to:
  /// **'Initialization failed.'**
  String get errorGeneralInitializationFailed;

  /// No description provided for @errorDateRangeInvalid.
  ///
  /// In en, this message translates to:
  /// **'The date range is invalid.'**
  String get errorDateRangeInvalid;

  /// No description provided for @errorDateFormatInvalid.
  ///
  /// In en, this message translates to:
  /// **'Date format is invalid.'**
  String get errorDateFormatInvalid;

  /// No description provided for @errorDateParsingFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to parse the date.'**
  String get errorDateParsingFailed;

  /// No description provided for @errorPermissionDenied.
  ///
  /// In en, this message translates to:
  /// **'Permission denied.'**
  String get errorPermissionDenied;

  /// No description provided for @errorPermissionFeatureDisabled.
  ///
  /// In en, this message translates to:
  /// **'Feature is disabled due to permissions.'**
  String get errorPermissionFeatureDisabled;

  /// No description provided for @errorPermissionInsufficient.
  ///
  /// In en, this message translates to:
  /// **'Insufficient permissions to proceed.'**
  String get errorPermissionInsufficient;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return AppLocalizationsAr();
    case 'en': return AppLocalizationsEn();
    case 'fr': return AppLocalizationsFr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
