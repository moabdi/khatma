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
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
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

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Khatma'**
  String get appName;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @apply.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get apply;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @change.
  ///
  /// In en, this message translates to:
  /// **'Change'**
  String get change;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

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

  /// No description provided for @create.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get create;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @finish.
  ///
  /// In en, this message translates to:
  /// **'Finish'**
  String get finish;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @previous.
  ///
  /// In en, this message translates to:
  /// **'Previous'**
  String get previous;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @submit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @or.
  ///
  /// In en, this message translates to:
  /// **'Or'**
  String get or;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @yesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get yesterday;

  /// No description provided for @daysAgo.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{Today} =1{Yesterday} other{{count} days ago}}'**
  String daysAgo(num count);

  /// No description provided for @monthsAgo.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{This month} one{Last month} other{{count} months ago}}'**
  String monthsAgo(num count);

  /// No description provided for @monthName.
  ///
  /// In en, this message translates to:
  /// **'{month, select, 1{January} 2{February} 3{March} 4{April} 5{May} 6{June} 7{July} 8{August} 9{September} 10{October} 11{November} 12{December} other{}}'**
  String monthName(String month);

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signIn;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign up'**
  String get signUp;

  /// No description provided for @signOut.
  ///
  /// In en, this message translates to:
  /// **'Sign Out'**
  String get signOut;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome!'**
  String get welcome;

  /// No description provided for @joinUs.
  ///
  /// In en, this message translates to:
  /// **'Join us!'**
  String get joinUs;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get createAccount;

  /// No description provided for @createAnAccount.
  ///
  /// In en, this message translates to:
  /// **'Create an account'**
  String get createAnAccount;

  /// No description provided for @createAccountToStart.
  ///
  /// In en, this message translates to:
  /// **'Create your account to get started'**
  String get createAccountToStart;

  /// No description provided for @createMyAccount.
  ///
  /// In en, this message translates to:
  /// **'Create my account'**
  String get createMyAccount;

  /// No description provided for @signInToContinue.
  ///
  /// In en, this message translates to:
  /// **'Sign in to continue'**
  String get signInToContinue;

  /// No description provided for @haveAccountSignIn.
  ///
  /// In en, this message translates to:
  /// **'Have an account? Sign in'**
  String get haveAccountSignIn;

  /// No description provided for @needAccountRegister.
  ///
  /// In en, this message translates to:
  /// **'Need an account? Register'**
  String get needAccountRegister;

  /// No description provided for @noAccountYet.
  ///
  /// In en, this message translates to:
  /// **'No account yet? '**
  String get noAccountYet;

  /// No description provided for @orContinueWith.
  ///
  /// In en, this message translates to:
  /// **'Or continue with'**
  String get orContinueWith;

  /// No description provided for @continueWithGoogle.
  ///
  /// In en, this message translates to:
  /// **'Continue with Google'**
  String get continueWithGoogle;

  /// No description provided for @continueAsGuest.
  ///
  /// In en, this message translates to:
  /// **'Continue as guest'**
  String get continueAsGuest;

  /// No description provided for @backToLogin.
  ///
  /// In en, this message translates to:
  /// **'Retour à la page de connexion'**
  String get backToLogin;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @displayName.
  ///
  /// In en, this message translates to:
  /// **'Display Name'**
  String get displayName;

  /// No description provided for @fullNameOrNickname.
  ///
  /// In en, this message translates to:
  /// **'Full name or nickname'**
  String get fullNameOrNickname;

  /// No description provided for @fullNameOrNicknameHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your full name or nickname'**
  String get fullNameOrNicknameHint;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @emailHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your email address'**
  String get emailHint;

  /// No description provided for @emailInputLabel.
  ///
  /// In en, this message translates to:
  /// **'Enter your gemail'**
  String get emailInputLabel;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @yourPassword.
  ///
  /// In en, this message translates to:
  /// **'Your password'**
  String get yourPassword;

  /// No description provided for @passwordInputLabel.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get passwordInputLabel;

  /// No description provided for @passwordWith8Characters.
  ///
  /// In en, this message translates to:
  /// **'Password (8+ characters)'**
  String get passwordWith8Characters;

  /// No description provided for @atLeast8Characters.
  ///
  /// In en, this message translates to:
  /// **'At least 8 characters'**
  String get atLeast8Characters;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// No description provided for @retypePassword.
  ///
  /// In en, this message translates to:
  /// **'Retype your password'**
  String get retypePassword;

  /// No description provided for @currentPassword.
  ///
  /// In en, this message translates to:
  /// **'Current Password'**
  String get currentPassword;

  /// No description provided for @newPassword.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get newPassword;

  /// No description provided for @confirmNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm New Password'**
  String get confirmNewPassword;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get forgotPassword;

  /// No description provided for @forgotPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password'**
  String get forgotPasswordTitle;

  /// No description provided for @forgotPasswordDescription.
  ///
  /// In en, this message translates to:
  /// **'Enter your email address to receive a password reset link.'**
  String get forgotPasswordDescription;

  /// No description provided for @sendPasswordResetEmail.
  ///
  /// In en, this message translates to:
  /// **'Send Password Reset Email'**
  String get sendPasswordResetEmail;

  /// No description provided for @createNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Create a new password'**
  String get createNewPassword;

  /// No description provided for @newPasswordDescription.
  ///
  /// In en, this message translates to:
  /// **'Enter a new password to reset your account.'**
  String get newPasswordDescription;

  /// No description provided for @updatePassword.
  ///
  /// In en, this message translates to:
  /// **'Update Password'**
  String get updatePassword;

  /// No description provided for @changePassword.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get changePassword;

  /// No description provided for @changePasswordSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Change your password to keep your account secure.'**
  String get changePasswordSubtitle;

  /// No description provided for @updateYourPassword.
  ///
  /// In en, this message translates to:
  /// **'Update your password'**
  String get updateYourPassword;

  /// No description provided for @passwordResetEmailSent.
  ///
  /// In en, this message translates to:
  /// **'Password reset email sent'**
  String get passwordResetEmailSent;

  /// No description provided for @passwordResetEmailSentDescription.
  ///
  /// In en, this message translates to:
  /// **'A password reset email has been sent to your email address. Please check your inbox and follow the instructions to reset your password.'**
  String get passwordResetEmailSentDescription;

  /// No description provided for @checkInboxForPasswordReset.
  ///
  /// In en, this message translates to:
  /// **'Please check your inbox for the password reset email.'**
  String get checkInboxForPasswordReset;

  /// No description provided for @checkSpamFolder.
  ///
  /// In en, this message translates to:
  /// **'If you don\'t see the email, check your spam or junk folder.'**
  String get checkSpamFolder;

  /// No description provided for @resendEmail.
  ///
  /// In en, this message translates to:
  /// **'Resend Email'**
  String get resendEmail;

  /// No description provided for @emailSent.
  ///
  /// In en, this message translates to:
  /// **'Email sent'**
  String get emailSent;

  /// No description provided for @passwordUpdated.
  ///
  /// In en, this message translates to:
  /// **'Password updated successfully!'**
  String get passwordUpdated;

  /// No description provided for @passwordUpdatedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Password updated successfully!'**
  String get passwordUpdatedSuccessfully;

  /// No description provided for @passwordUpdatedDescription.
  ///
  /// In en, this message translates to:
  /// **'Your password has been updated successfully. You can now log in with your new password.'**
  String get passwordUpdatedDescription;

  /// No description provided for @rememberPasswordBackToLogin.
  ///
  /// In en, this message translates to:
  /// **'Remembered your password? Back to login'**
  String get rememberPasswordBackToLogin;

  /// No description provided for @redirectingToLogin.
  ///
  /// In en, this message translates to:
  /// **'Redirecting to login...'**
  String get redirectingToLogin;

  /// No description provided for @goToLoginPage.
  ///
  /// In en, this message translates to:
  /// **'Go to Login Page'**
  String get goToLoginPage;

  /// No description provided for @show.
  ///
  /// In en, this message translates to:
  /// **'Afficher'**
  String get show;

  /// No description provided for @hide.
  ///
  /// In en, this message translates to:
  /// **'Masquer'**
  String get hide;

  /// No description provided for @passwordRequirements.
  ///
  /// In en, this message translates to:
  /// **'Password Requirements'**
  String get passwordRequirements;

  /// No description provided for @passwordCriteria.
  ///
  /// In en, this message translates to:
  /// **'Password criteria:'**
  String get passwordCriteria;

  /// No description provided for @atLeast8CharsCriterion.
  ///
  /// In en, this message translates to:
  /// **'At least 8 characters'**
  String get atLeast8CharsCriterion;

  /// No description provided for @oneUppercaseCriterion.
  ///
  /// In en, this message translates to:
  /// **'One uppercase letter'**
  String get oneUppercaseCriterion;

  /// No description provided for @oneLowercaseCriterion.
  ///
  /// In en, this message translates to:
  /// **'One lowercase letter'**
  String get oneLowercaseCriterion;

  /// No description provided for @oneDigitCriterion.
  ///
  /// In en, this message translates to:
  /// **'One digit'**
  String get oneDigitCriterion;

  /// No description provided for @passwordsMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords match'**
  String get passwordsMatch;

  /// No description provided for @passwordStrengthWeak.
  ///
  /// In en, this message translates to:
  /// **'Strength'**
  String get passwordStrengthWeak;

  /// No description provided for @passwordStrengthMedium.
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get passwordStrengthMedium;

  /// No description provided for @passwordStrengthGood.
  ///
  /// In en, this message translates to:
  /// **'Good'**
  String get passwordStrengthGood;

  /// No description provided for @passwordStrengthStrong.
  ///
  /// In en, this message translates to:
  /// **'Strong'**
  String get passwordStrengthStrong;

  /// No description provided for @acceptTerms.
  ///
  /// In en, this message translates to:
  /// **'I accept the '**
  String get acceptTerms;

  /// No description provided for @termsOfService.
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get termsOfService;

  /// No description provided for @andThe.
  ///
  /// In en, this message translates to:
  /// **' and the '**
  String get andThe;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @termsAndConditions.
  ///
  /// In en, this message translates to:
  /// **'Terms and Conditions'**
  String get termsAndConditions;

  /// No description provided for @legalNotices.
  ///
  /// In en, this message translates to:
  /// **'Legal Notices'**
  String get legalNotices;

  /// No description provided for @mustAcceptTerms.
  ///
  /// In en, this message translates to:
  /// **'You must accept the terms of service'**
  String get mustAcceptTerms;

  /// No description provided for @myAccount.
  ///
  /// In en, this message translates to:
  /// **'My Account'**
  String get myAccount;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @editProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editProfile;

  /// No description provided for @accountSettings.
  ///
  /// In en, this message translates to:
  /// **'Account Settings'**
  String get accountSettings;

  /// No description provided for @changeDisplayName.
  ///
  /// In en, this message translates to:
  /// **'Change Display Name'**
  String get changeDisplayName;

  /// No description provided for @changeDisplayNameSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Change your display name to personalize your account.'**
  String get changeDisplayNameSubtitle;

  /// No description provided for @verifyEmail.
  ///
  /// In en, this message translates to:
  /// **'Verify Email'**
  String get verifyEmail;

  /// No description provided for @confirmEmailAddress.
  ///
  /// In en, this message translates to:
  /// **'Confirm Email Address'**
  String get confirmEmailAddress;

  /// No description provided for @refreshData.
  ///
  /// In en, this message translates to:
  /// **'Refresh Data'**
  String get refreshData;

  /// No description provided for @updateAccountInformation.
  ///
  /// In en, this message translates to:
  /// **'Update Account Information'**
  String get updateAccountInformation;

  /// No description provided for @profileUpdatedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Profile updated successfully!'**
  String get profileUpdatedSuccessfully;

  /// No description provided for @dataRefreshed.
  ///
  /// In en, this message translates to:
  /// **'Data refreshed successfully!'**
  String get dataRefreshed;

  /// No description provided for @security.
  ///
  /// In en, this message translates to:
  /// **'Security'**
  String get security;

  /// No description provided for @dangerZone.
  ///
  /// In en, this message translates to:
  /// **'Danger Zone'**
  String get dangerZone;

  /// No description provided for @deleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get deleteAccount;

  /// No description provided for @permanentlyDeleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Permanently delete your account'**
  String get permanentlyDeleteAccount;

  /// No description provided for @deleteAccountWarning.
  ///
  /// In en, this message translates to:
  /// **'This action will permanently delete your account and all associated data. This action cannot be undone.'**
  String get deleteAccountWarning;

  /// No description provided for @confirmWithPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm with your password'**
  String get confirmWithPassword;

  /// No description provided for @accountDeletedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Your account has been deleted successfully.'**
  String get accountDeletedSuccessfully;

  /// No description provided for @deletePermantly.
  ///
  /// In en, this message translates to:
  /// **'Delete Permanently'**
  String get deletePermantly;

  /// No description provided for @confirmSignOut.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to sign out?'**
  String get confirmSignOut;

  /// No description provided for @closeYourSession.
  ///
  /// In en, this message translates to:
  /// **'Close your session'**
  String get closeYourSession;

  /// No description provided for @becomeMember.
  ///
  /// In en, this message translates to:
  /// **'Become a member'**
  String get becomeMember;

  /// No description provided for @anonymousUser.
  ///
  /// In en, this message translates to:
  /// **'Anonymous User'**
  String get anonymousUser;

  /// No description provided for @anonymous.
  ///
  /// In en, this message translates to:
  /// **'Anonymous'**
  String get anonymous;

  /// No description provided for @guest.
  ///
  /// In en, this message translates to:
  /// **'Guest'**
  String get guest;

  /// No description provided for @user.
  ///
  /// In en, this message translates to:
  /// **'User'**
  String get user;

  /// No description provided for @guestAccount.
  ///
  /// In en, this message translates to:
  /// **'Guest Account'**
  String get guestAccount;

  /// No description provided for @userAccount.
  ///
  /// In en, this message translates to:
  /// **'User Account'**
  String get userAccount;

  /// No description provided for @verifiedUser.
  ///
  /// In en, this message translates to:
  /// **'Verified User'**
  String get verifiedUser;

  /// No description provided for @unverifiedUser.
  ///
  /// In en, this message translates to:
  /// **'Unverified User'**
  String get unverifiedUser;

  /// No description provided for @emailVerified.
  ///
  /// In en, this message translates to:
  /// **'Email Verified'**
  String get emailVerified;

  /// No description provided for @emailNotVerified.
  ///
  /// In en, this message translates to:
  /// **'Email Not Verified'**
  String get emailNotVerified;

  /// No description provided for @verified.
  ///
  /// In en, this message translates to:
  /// **'Verified'**
  String get verified;

  /// No description provided for @unverified.
  ///
  /// In en, this message translates to:
  /// **'Unverified'**
  String get unverified;

  /// No description provided for @verificationEmailSent.
  ///
  /// In en, this message translates to:
  /// **'A verification email has been sent to your email address. Please check your inbox and follow the instructions to verify your email.'**
  String get verificationEmailSent;

  /// No description provided for @unlockAllFeatures.
  ///
  /// In en, this message translates to:
  /// **'Unlock all features'**
  String get unlockAllFeatures;

  /// No description provided for @signInOrSignUp.
  ///
  /// In en, this message translates to:
  /// **'Sign in or sign up'**
  String get signInOrSignUp;

  /// No description provided for @manageYourAccount.
  ///
  /// In en, this message translates to:
  /// **'Manage your account'**
  String get manageYourAccount;

  /// No description provided for @accessYourData.
  ///
  /// In en, this message translates to:
  /// **'Access your data'**
  String get accessYourData;

  /// No description provided for @nameCannotBeEmpty.
  ///
  /// In en, this message translates to:
  /// **'Name cannot be empty'**
  String get nameCannotBeEmpty;

  /// No description provided for @nameMinLength.
  ///
  /// In en, this message translates to:
  /// **'Name must be at least 2 characters long'**
  String get nameMinLength;

  /// No description provided for @displayNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Display name is required'**
  String get displayNameRequired;

  /// No description provided for @displayNameTooShort.
  ///
  /// In en, this message translates to:
  /// **'Display name must be at least 2 characters'**
  String get displayNameTooShort;

  /// No description provided for @emailCannotBeEmpty.
  ///
  /// In en, this message translates to:
  /// **'Email cannot be empty'**
  String get emailCannotBeEmpty;

  /// No description provided for @invalidEmailFormat.
  ///
  /// In en, this message translates to:
  /// **'Invalid email format'**
  String get invalidEmailFormat;

  /// No description provided for @loginEmailCannotBeEmpty.
  ///
  /// In en, this message translates to:
  /// **'Email cannot be empty'**
  String get loginEmailCannotBeEmpty;

  /// No description provided for @loginInvalidEmailFormat.
  ///
  /// In en, this message translates to:
  /// **'Invalid email format'**
  String get loginInvalidEmailFormat;

  /// No description provided for @passwordCannotBeEmpty.
  ///
  /// In en, this message translates to:
  /// **'Password cannot be empty'**
  String get passwordCannotBeEmpty;

  /// No description provided for @passwordMinLength.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters long'**
  String get passwordMinLength;

  /// No description provided for @passwordMustBeAtLeast8Characters.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters long'**
  String get passwordMustBeAtLeast8Characters;

  /// No description provided for @passwordTooShort.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters'**
  String get passwordTooShort;

  /// No description provided for @passwordTooWeak.
  ///
  /// In en, this message translates to:
  /// **'Password is too weak. Please use a stronger password'**
  String get passwordTooWeak;

  /// No description provided for @passwordComplexityRequirement.
  ///
  /// In en, this message translates to:
  /// **'Password must contain at least one uppercase letter, one lowercase letter, and one digit'**
  String get passwordComplexityRequirement;

  /// No description provided for @passwordMustContainUpperLowerAndDigit.
  ///
  /// In en, this message translates to:
  /// **'Password must contain at least one uppercase letter, one lowercase letter, and one digit'**
  String get passwordMustContainUpperLowerAndDigit;

  /// No description provided for @passwordNeedsLowercase.
  ///
  /// In en, this message translates to:
  /// **'Password must contain at least one lowercase letter'**
  String get passwordNeedsLowercase;

  /// No description provided for @passwordNeedsUppercase.
  ///
  /// In en, this message translates to:
  /// **'Password must contain at least one uppercase letter'**
  String get passwordNeedsUppercase;

  /// No description provided for @passwordNeedsDigit.
  ///
  /// In en, this message translates to:
  /// **'Password must contain at least one digit'**
  String get passwordNeedsDigit;

  /// No description provided for @pleaseConfirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Please confirm your password'**
  String get pleaseConfirmPassword;

  /// No description provided for @pleaseConfirmYourPassword.
  ///
  /// In en, this message translates to:
  /// **'Please confirm your password'**
  String get pleaseConfirmYourPassword;

  /// No description provided for @passwordsDoNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordsDoNotMatch;

  /// No description provided for @currentPasswordRequired.
  ///
  /// In en, this message translates to:
  /// **'Current password is required'**
  String get currentPasswordRequired;

  /// No description provided for @newPasswordRequired.
  ///
  /// In en, this message translates to:
  /// **'New password is required'**
  String get newPasswordRequired;

  /// No description provided for @confirmPasswordRequired.
  ///
  /// In en, this message translates to:
  /// **'Please confirm your password'**
  String get confirmPasswordRequired;

  /// No description provided for @incorrectCurrentPassword.
  ///
  /// In en, this message translates to:
  /// **'Current password is incorrect'**
  String get incorrectCurrentPassword;

  /// No description provided for @loginPasswordCannotBeEmpty.
  ///
  /// In en, this message translates to:
  /// **'Password cannot be empty'**
  String get loginPasswordCannotBeEmpty;

  /// No description provided for @loginPasswordTooShort.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters long'**
  String get loginPasswordTooShort;

  /// No description provided for @fixErrorsBeforeSubmitting.
  ///
  /// In en, this message translates to:
  /// **'Please fix the errors before submitting.'**
  String get fixErrorsBeforeSubmitting;

  /// No description provided for @invalidDisplayName.
  ///
  /// In en, this message translates to:
  /// **'Invalid display name'**
  String get invalidDisplayName;

  /// No description provided for @areYouSure.
  ///
  /// In en, this message translates to:
  /// **'Are you sure?'**
  String get areYouSure;

  /// No description provided for @confirmAction.
  ///
  /// In en, this message translates to:
  /// **'Please confirm your action'**
  String get confirmAction;

  /// No description provided for @confirmDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Deletion'**
  String get confirmDeleteTitle;

  /// No description provided for @confirmLogoutTitle.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get confirmLogoutTitle;

  /// No description provided for @confirmExitTitle.
  ///
  /// In en, this message translates to:
  /// **'Exit'**
  String get confirmExitTitle;

  /// No description provided for @confirmDelete.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this item?'**
  String get confirmDelete;

  /// No description provided for @confirmDeleteItem.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete {itemName}?'**
  String confirmDeleteItem(Object itemName);

  /// No description provided for @confirmDeleteKhatma.
  ///
  /// In en, this message translates to:
  /// **'After deleting, this khatma will be permanently deleted'**
  String get confirmDeleteKhatma;

  /// No description provided for @confirmLogout.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to log out?'**
  String get confirmLogout;

  /// No description provided for @confirmExitApp.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to exit the app?'**
  String get confirmExitApp;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @exitApp.
  ///
  /// In en, this message translates to:
  /// **'Exit App'**
  String get exitApp;

  /// No description provided for @exit.
  ///
  /// In en, this message translates to:
  /// **'Exit'**
  String get exit;

  /// No description provided for @terminate.
  ///
  /// In en, this message translates to:
  /// **'Terminate'**
  String get terminate;

  /// No description provided for @khatmaFinishedMessage.
  ///
  /// In en, this message translates to:
  /// **'You have just finished your khatma in {timeAgo}.'**
  String khatmaFinishedMessage(Object timeAgo);

  /// No description provided for @completion.
  ///
  /// In en, this message translates to:
  /// **'Completion'**
  String get completion;

  /// No description provided for @khatmaHistory.
  ///
  /// In en, this message translates to:
  /// **'Khatma History'**
  String get khatmaHistory;

  /// No description provided for @congratulations.
  ///
  /// In en, this message translates to:
  /// **'Congratulations'**
  String get congratulations;

  /// No description provided for @khatmaListTitle.
  ///
  /// In en, this message translates to:
  /// **'Khatma List'**
  String get khatmaListTitle;

  /// No description provided for @khatmaListSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your ongoing khatmas'**
  String get khatmaListSubtitle;

  /// No description provided for @noKhatmaYet.
  ///
  /// In en, this message translates to:
  /// **'You have no khatmas yet ?'**
  String get noKhatmaYet;

  /// No description provided for @createKhatmaToStart.
  ///
  /// In en, this message translates to:
  /// **'Create a khatma to start'**
  String get createKhatmaToStart;

  /// No description provided for @success.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get success;

  /// No description provided for @congratulation.
  ///
  /// In en, this message translates to:
  /// **'Congratulations!'**
  String get congratulation;

  /// No description provided for @accountCreatedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Account created successfully!'**
  String get accountCreatedSuccessfully;

  /// No description provided for @successCompleteParts.
  ///
  /// In en, this message translates to:
  /// **'{count} parts completed successfully'**
  String successCompleteParts(Object count);

  /// No description provided for @signInFailed.
  ///
  /// In en, this message translates to:
  /// **'Sign in failed'**
  String get signInFailed;

  /// No description provided for @loginFailed.
  ///
  /// In en, this message translates to:
  /// **'Login failed'**
  String get loginFailed;

  /// No description provided for @registrationFailed.
  ///
  /// In en, this message translates to:
  /// **'Registration failed. Please try again later.'**
  String get registrationFailed;

  /// No description provided for @anonymousSignInFailed.
  ///
  /// In en, this message translates to:
  /// **'Anonymous sign-in failed'**
  String get anonymousSignInFailed;

  /// No description provided for @googleSignInFailed.
  ///
  /// In en, this message translates to:
  /// **'Google sign-in failed'**
  String get googleSignInFailed;

  /// No description provided for @updateProfileError.
  ///
  /// In en, this message translates to:
  /// **'Failed to update profile. Please try again'**
  String get updateProfileError;

  /// No description provided for @errorLoadingProfile.
  ///
  /// In en, this message translates to:
  /// **'Error loading profile. Please try again later.'**
  String get errorLoadingProfile;

  /// No description provided for @networkError.
  ///
  /// In en, this message translates to:
  /// **'Network error. Please check your connection'**
  String get networkError;

  /// No description provided for @permissionDenied.
  ///
  /// In en, this message translates to:
  /// **'Permission denied'**
  String get permissionDenied;

  /// No description provided for @pleaseTryAgain.
  ///
  /// In en, this message translates to:
  /// **'Please try again.'**
  String get pleaseTryAgain;

  /// No description provided for @criticalError.
  ///
  /// In en, this message translates to:
  /// **'Critical Error'**
  String get criticalError;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @errorCode.
  ///
  /// In en, this message translates to:
  /// **'Error Code'**
  String get errorCode;

  /// No description provided for @cannotUpdateKhatmaWhileStarted.
  ///
  /// In en, this message translates to:
  /// **'Cannot update khatma while it is started'**
  String get cannotUpdateKhatmaWhileStarted;

  /// No description provided for @failedToSaveKhatma.
  ///
  /// In en, this message translates to:
  /// **'Failed to save khatma. Please try again.'**
  String get failedToSaveKhatma;

  /// No description provided for @failedToLoadKhatma.
  ///
  /// In en, this message translates to:
  /// **'Failed to load khatma. Please try again.'**
  String get failedToLoadKhatma;

  /// No description provided for @failedToDeleteKhatma.
  ///
  /// In en, this message translates to:
  /// **'Failed to delete khatma. Please try again.'**
  String get failedToDeleteKhatma;

  /// No description provided for @failedToShareKhatma.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this item?'**
  String get failedToShareKhatma;

  /// No description provided for @errorOccurred.
  ///
  /// In en, this message translates to:
  /// **'An error occurred'**
  String get errorOccurred;

  /// No description provided for @pageNotFound.
  ///
  /// In en, this message translates to:
  /// **'Page Not Found'**
  String get pageNotFound;

  /// No description provided for @pageNotFound404.
  ///
  /// In en, this message translates to:
  /// **'404 - Page not found!'**
  String get pageNotFound404;

  /// No description provided for @notImplemented.
  ///
  /// In en, this message translates to:
  /// **'Not implemented'**
  String get notImplemented;

  /// No description provided for @goToHome.
  ///
  /// In en, this message translates to:
  /// **'Go to Home'**
  String get goToHome;

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

  /// No description provided for @errorAuthAccountExistsWithDifferentCredentials.
  ///
  /// In en, this message translates to:
  /// **'An account already exists with different credentials.'**
  String get errorAuthAccountExistsWithDifferentCredentials;

  /// No description provided for @errorAuthInvalidCredentials.
  ///
  /// In en, this message translates to:
  /// **'Invalid credentials provided.'**
  String get errorAuthInvalidCredentials;

  /// No description provided for @errorAuthInvalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Invalid email address.'**
  String get errorAuthInvalidEmail;

  /// No description provided for @errorAuthOperationNotAllowed.
  ///
  /// In en, this message translates to:
  /// **'Operation not allowed.'**
  String get errorAuthOperationNotAllowed;

  /// No description provided for @errorAuthUserDisabled.
  ///
  /// In en, this message translates to:
  /// **'User account is disabled.'**
  String get errorAuthUserDisabled;

  /// No description provided for @errorAuthUserNotFound.
  ///
  /// In en, this message translates to:
  /// **'User not found.'**
  String get errorAuthUserNotFound;

  /// No description provided for @errorAuthEmailAlreadyInUse.
  ///
  /// In en, this message translates to:
  /// **'Email address is already in use.'**
  String get errorAuthEmailAlreadyInUse;

  /// No description provided for @errorAuthWeakPassword.
  ///
  /// In en, this message translates to:
  /// **'Weak password provided.'**
  String get errorAuthWeakPassword;

  /// No description provided for @errorAuthRequiresRecentLogin.
  ///
  /// In en, this message translates to:
  /// **'Recent login required.'**
  String get errorAuthRequiresRecentLogin;

  /// No description provided for @errorAuthTooManyRequests.
  ///
  /// In en, this message translates to:
  /// **'Too many requests made.'**
  String get errorAuthTooManyRequests;

  /// No description provided for @errorAuthNetworkRequestFailed.
  ///
  /// In en, this message translates to:
  /// **'Network request failed.'**
  String get errorAuthNetworkRequestFailed;

  /// No description provided for @errorAuthPopupBlocked.
  ///
  /// In en, this message translates to:
  /// **'Popup blocked by browser.'**
  String get errorAuthPopupBlocked;

  /// No description provided for @errorAuthPopClosedByUser.
  ///
  /// In en, this message translates to:
  /// **'Popup closed by user.'**
  String get errorAuthPopClosedByUser;

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

  /// No description provided for @errorAuthActionCancelled.
  ///
  /// In en, this message translates to:
  /// **'The authentication action was cancelled.'**
  String get errorAuthActionCancelled;

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

  /// No description provided for @errorValidationInvalidOperation.
  ///
  /// In en, this message translates to:
  /// **'Invalid operation attempted.'**
  String get errorValidationInvalidOperation;

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

  /// No description provided for @errorNoPartsSelected.
  ///
  /// In en, this message translates to:
  /// **'No parts selected.'**
  String get errorNoPartsSelected;

  /// No description provided for @errorNoKhatmaSelected.
  ///
  /// In en, this message translates to:
  /// **'No Khatma selected.'**
  String get errorNoKhatmaSelected;

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

  /// No description provided for @khatma.
  ///
  /// In en, this message translates to:
  /// **'Khatma'**
  String get khatma;

  /// No description provided for @khatmaList.
  ///
  /// In en, this message translates to:
  /// **'Khatma list'**
  String get khatmaList;

  /// No description provided for @shareKhatma.
  ///
  /// In en, this message translates to:
  /// **'Share khatma'**
  String get shareKhatma;

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

  /// No description provided for @quran.
  ///
  /// In en, this message translates to:
  /// **'Quran'**
  String get quran;

  /// No description provided for @title.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get title;

  /// No description provided for @nameHint.
  ///
  /// In en, this message translates to:
  /// **'Enter the name of the Khatma'**
  String get nameHint;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @descriptionHint.
  ///
  /// In en, this message translates to:
  /// **'Enter a description (optional)'**
  String get descriptionHint;

  /// No description provided for @icon.
  ///
  /// In en, this message translates to:
  /// **'Icon'**
  String get icon;

  /// No description provided for @chooseIcon.
  ///
  /// In en, this message translates to:
  /// **'Choose icon'**
  String get chooseIcon;

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

  /// No description provided for @khatmaSplitUnit.
  ///
  /// In en, this message translates to:
  /// **'{unit, select, sourat{Sourat} juzz{Juzz} hizb{Hizb} half{Half-Hizb} rubue{Fourth-hizb} thumun{Eighth-hizb} other{}}'**
  String khatmaSplitUnit(String unit);

  /// No description provided for @khatmaSplitUnitWithDef.
  ///
  /// In en, this message translates to:
  /// **'{unit, select, sourat{the surah} juzz{the juzz} hizb{the hizb} half{half the hizb} rubue{quarter the hizb} thumun{one-eighth the hizb} other{}}'**
  String khatmaSplitUnitWithDef(String unit);

  /// No description provided for @khatmaSplitUnitDesc.
  ///
  /// In en, this message translates to:
  /// **'{unit, select, sourat{Sourat (114 parts)} juzz{Juzz (30 parts)} hizb{Hizb (60 parts)} half{Half-Hizb (120 parts)} rubue{Fourth-hizb (240 parts)} thumun{Eighth-hizb (480 parts)} other{}}'**
  String khatmaSplitUnitDesc(String unit);

  /// No description provided for @ordinalPartNumber.
  ///
  /// In en, this message translates to:
  /// **'{num, select, 1{The first} 2{The second} 3{The third} 4{The fourth} 5{The fifth} 6{The sixth} 7{The seventh} 8{The eighth} 9{The ninth} 10{The tenth} 11{The eleventh} 12{The twelfth} 13{The thirteenth} 14{The fourteenth} 15{The fifteenth} 16{The sixteenth} 17{The seventeenth} 18{The eighteenth} 19{The nineteenth} 20{The twentieth} 21{The twenty-first} 22{The twenty-second} 23{The twenty-third} 24{The twenty-fourth} 25{The twenty-fifth} 26{The twenty-sixth} 27{The twenty-seventh} 28{The twenty-eighth} 29{The twenty-ninth} 30{The thirtieth} 31{The thirty-first} 32{The thirty-second} 33{The thirty-third} 34{The thirty-fourth} 35{The thirty-fifth} 36{The thirty-sixth} 37{The thirty-seventh} 38{The thirty-eighth} 39{The thirty-ninth} 40{The fortieth} 41{The forty-first} 42{The forty-second} 43{The forty-third} 44{The forty-fourth} 45{The forty-fifth} 46{The forty-sixth} 47{The forty-seventh} 48{The forty-eighth} 49{The forty-ninth} 50{The fiftieth} 51{The fifty-first} 52{The fifty-second} 53{The fifty-third} 54{The fifty-fourth} 55{The fifty-fifth} 56{The fifty-sixth} 57{The fifty-seventh} 58{The fifty-eighth} 59{The fifty-ninth} 60{The sixtieth} other{}}'**
  String ordinalPartNumber(String num);

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

  /// No description provided for @repeatEvery.
  ///
  /// In en, this message translates to:
  /// **'Repeat very'**
  String get repeatEvery;

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

  /// No description provided for @appPreferences.
  ///
  /// In en, this message translates to:
  /// **'App Preferences'**
  String get appPreferences;

  /// No description provided for @aboutUs.
  ///
  /// In en, this message translates to:
  /// **'About Us'**
  String get aboutUs;

  /// No description provided for @learnMoreAboutApp.
  ///
  /// In en, this message translates to:
  /// **'Learn more about the app'**
  String get learnMoreAboutApp;

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

  /// No description provided for @riwaya.
  ///
  /// In en, this message translates to:
  /// **'Riwaya'**
  String get riwaya;

  /// No description provided for @chooseRiwaya.
  ///
  /// In en, this message translates to:
  /// **'Choose Riwaya'**
  String get chooseRiwaya;

  /// No description provided for @recitation.
  ///
  /// In en, this message translates to:
  /// **'Récitation'**
  String get recitation;

  /// No description provided for @hafs.
  ///
  /// In en, this message translates to:
  /// **'Hafs'**
  String get hafs;

  /// No description provided for @hafsDescription.
  ///
  /// In en, this message translates to:
  /// **'La récitation la plus répandue dans le monde musulman, notamment au Moyen-Orient.'**
  String get hafsDescription;

  /// No description provided for @warsh.
  ///
  /// In en, this message translates to:
  /// **'Warsh'**
  String get warsh;

  /// No description provided for @warshDescription.
  ///
  /// In en, this message translates to:
  /// **'Courante en Afrique du Nord. Légères différences de prononciation et d\'orthographe.'**
  String get warshDescription;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @chooseTheme.
  ///
  /// In en, this message translates to:
  /// **'Choose theme'**
  String get chooseTheme;

  /// No description provided for @themeMode.
  ///
  /// In en, this message translates to:
  /// **'{mode, select, light{Light} dark{Dark} system{System} other{System}}'**
  String themeMode(String mode);

  /// No description provided for @faq.
  ///
  /// In en, this message translates to:
  /// **'Common Questions'**
  String get faq;

  /// No description provided for @frequentlyAskedQuestions.
  ///
  /// In en, this message translates to:
  /// **'Frequently Asked Questions'**
  String get frequentlyAskedQuestions;

  /// No description provided for @contactSupport.
  ///
  /// In en, this message translates to:
  /// **'Contact Support'**
  String get contactSupport;

  /// No description provided for @questionsAndSuggestions.
  ///
  /// In en, this message translates to:
  /// **'Questions and suggestions'**
  String get questionsAndSuggestions;

  /// No description provided for @onboarding1Title.
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

  /// No description provided for @registration_validation.
  ///
  /// In en, this message translates to:
  /// **'Registration validation messages'**
  String get registration_validation;

  /// No description provided for @login_validation.
  ///
  /// In en, this message translates to:
  /// **'Login validation messages'**
  String get login_validation;

  /// No description provided for @registration_ui.
  ///
  /// In en, this message translates to:
  /// **'Registration interface'**
  String get registration_ui;

  /// No description provided for @login_ui.
  ///
  /// In en, this message translates to:
  /// **'Login interface'**
  String get login_ui;

  /// No description provided for @form_types.
  ///
  /// In en, this message translates to:
  /// **'Form types'**
  String get form_types;

  /// No description provided for @shared_fields.
  ///
  /// In en, this message translates to:
  /// **'Shared fields'**
  String get shared_fields;

  /// No description provided for @validation_messages.
  ///
  /// In en, this message translates to:
  /// **'Validation messages'**
  String get validation_messages;

  /// No description provided for @password_criteria.
  ///
  /// In en, this message translates to:
  /// **'Password criteria'**
  String get password_criteria;

  /// No description provided for @terms_and_actions.
  ///
  /// In en, this message translates to:
  /// **'Terms and actions'**
  String get terms_and_actions;

  /// No description provided for @rememberMe.
  ///
  /// In en, this message translates to:
  /// **'Remember me'**
  String get rememberMe;

  /// No description provided for @ui_labels.
  ///
  /// In en, this message translates to:
  /// **'UI labels'**
  String get ui_labels;

  /// No description provided for @openSettings.
  ///
  /// In en, this message translates to:
  /// **'Open Settings'**
  String get openSettings;

  /// No description provided for @tryAgain.
  ///
  /// In en, this message translates to:
  /// **'Try Again'**
  String get tryAgain;

  /// No description provided for @authenticationError.
  ///
  /// In en, this message translates to:
  /// **'Authentication Error'**
  String get authenticationError;

  /// No description provided for @syncError.
  ///
  /// In en, this message translates to:
  /// **'Sync Error'**
  String get syncError;

  /// No description provided for @storageError.
  ///
  /// In en, this message translates to:
  /// **'Storage Error'**
  String get storageError;

  /// No description provided for @validationError.
  ///
  /// In en, this message translates to:
  /// **'Validation Error'**
  String get validationError;

  /// No description provided for @khatmaError.
  ///
  /// In en, this message translates to:
  /// **'Khatma Error'**
  String get khatmaError;

  /// No description provided for @limitError.
  ///
  /// In en, this message translates to:
  /// **'Limit Reached'**
  String get limitError;

  /// No description provided for @historyError.
  ///
  /// In en, this message translates to:
  /// **'History Error'**
  String get historyError;

  /// No description provided for @searchError.
  ///
  /// In en, this message translates to:
  /// **'Search Error'**
  String get searchError;

  /// No description provided for @statsError.
  ///
  /// In en, this message translates to:
  /// **'Statistics Error'**
  String get statsError;

  /// No description provided for @dateError.
  ///
  /// In en, this message translates to:
  /// **'Date Error'**
  String get dateError;

  /// No description provided for @permissionError.
  ///
  /// In en, this message translates to:
  /// **'Permission Error'**
  String get permissionError;

  /// No description provided for @errorDialogExamples.
  ///
  /// In en, this message translates to:
  /// **'Error Dialog Examples'**
  String get errorDialogExamples;

  /// No description provided for @networkErrors.
  ///
  /// In en, this message translates to:
  /// **'Network Errors'**
  String get networkErrors;

  /// No description provided for @authenticationErrors.
  ///
  /// In en, this message translates to:
  /// **'Authentication Errors'**
  String get authenticationErrors;

  /// No description provided for @storageErrors.
  ///
  /// In en, this message translates to:
  /// **'Storage Errors'**
  String get storageErrors;

  /// No description provided for @validationErrors.
  ///
  /// In en, this message translates to:
  /// **'Validation Errors'**
  String get validationErrors;

  /// No description provided for @khatmaErrors.
  ///
  /// In en, this message translates to:
  /// **'Khatma Errors'**
  String get khatmaErrors;

  /// No description provided for @connectionFailed.
  ///
  /// In en, this message translates to:
  /// **'Connection Failed'**
  String get connectionFailed;

  /// No description provided for @timeout.
  ///
  /// In en, this message translates to:
  /// **'Timeout'**
  String get timeout;

  /// No description provided for @serverError.
  ///
  /// In en, this message translates to:
  /// **'Server Error'**
  String get serverError;

  /// No description provided for @userNotLoggedIn.
  ///
  /// In en, this message translates to:
  /// **'User Not Logged In'**
  String get userNotLoggedIn;

  /// No description provided for @sessionExpired.
  ///
  /// In en, this message translates to:
  /// **'Session Expired'**
  String get sessionExpired;

  /// No description provided for @storageFull.
  ///
  /// In en, this message translates to:
  /// **'Storage Full'**
  String get storageFull;

  /// No description provided for @storageCorrupted.
  ///
  /// In en, this message translates to:
  /// **'Storage Corrupted'**
  String get storageCorrupted;

  /// No description provided for @saveFailed.
  ///
  /// In en, this message translates to:
  /// **'Save Failed'**
  String get saveFailed;

  /// No description provided for @invalidData.
  ///
  /// In en, this message translates to:
  /// **'Invalid Data'**
  String get invalidData;

  /// No description provided for @missingFields.
  ///
  /// In en, this message translates to:
  /// **'Missing Fields'**
  String get missingFields;

  /// No description provided for @invalidDate.
  ///
  /// In en, this message translates to:
  /// **'Invalid Date'**
  String get invalidDate;

  /// No description provided for @khatmaNotFound.
  ///
  /// In en, this message translates to:
  /// **'Khatma Not Found'**
  String get khatmaNotFound;

  /// No description provided for @alreadyCompleted.
  ///
  /// In en, this message translates to:
  /// **'Already Completed'**
  String get alreadyCompleted;

  /// No description provided for @invalidParts.
  ///
  /// In en, this message translates to:
  /// **'Invalid Parts'**
  String get invalidParts;

  /// No description provided for @retrying.
  ///
  /// In en, this message translates to:
  /// **'Retrying...'**
  String get retrying;

  /// No description provided for @openingSignIn.
  ///
  /// In en, this message translates to:
  /// **'Opening sign in...'**
  String get openingSignIn;

  /// No description provided for @openingSettings.
  ///
  /// In en, this message translates to:
  /// **'Opening settings...'**
  String get openingSettings;

  /// No description provided for @actionPerformed.
  ///
  /// In en, this message translates to:
  /// **'Action performed'**
  String get actionPerformed;

  /// No description provided for @displayNameTooLong.
  ///
  /// In en, this message translates to:
  /// **'Display name must be less than 50 characters'**
  String get displayNameTooLong;

  /// No description provided for @displayNameInvalidCharacters.
  ///
  /// In en, this message translates to:
  /// **'Display name contains invalid characters'**
  String get displayNameInvalidCharacters;

  /// No description provided for @unexpectedError.
  ///
  /// In en, this message translates to:
  /// **'An unexpected error occurred'**
  String get unexpectedError;

  /// No description provided for @contactUs.
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
  String get contactUs;

  /// No description provided for @contactType.
  ///
  /// In en, this message translates to:
  /// **'Contact Type'**
  String get contactType;

  /// No description provided for @bugReport.
  ///
  /// In en, this message translates to:
  /// **'Bug Report'**
  String get bugReport;

  /// No description provided for @bugReportDescription.
  ///
  /// In en, this message translates to:
  /// **'Report technical issues or problems with the app'**
  String get bugReportDescription;

  /// No description provided for @suggestion.
  ///
  /// In en, this message translates to:
  /// **'Suggestion'**
  String get suggestion;

  /// No description provided for @suggestionDescription.
  ///
  /// In en, this message translates to:
  /// **'Share ideas to improve the app experience'**
  String get suggestionDescription;

  /// No description provided for @feedback.
  ///
  /// In en, this message translates to:
  /// **'Feedback'**
  String get feedback;

  /// No description provided for @feedbackDescription.
  ///
  /// In en, this message translates to:
  /// **'General feedback about your app experience'**
  String get feedbackDescription;

  /// No description provided for @other.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get other;

  /// No description provided for @otherDescription.
  ///
  /// In en, this message translates to:
  /// **'Any other inquiries or questions'**
  String get otherDescription;

  /// No description provided for @yourName.
  ///
  /// In en, this message translates to:
  /// **'Your Name'**
  String get yourName;

  /// No description provided for @enterYourName.
  ///
  /// In en, this message translates to:
  /// **'Enter your name'**
  String get enterYourName;

  /// No description provided for @enterYourEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter your email address'**
  String get enterYourEmail;

  /// No description provided for @message.
  ///
  /// In en, this message translates to:
  /// **'Message'**
  String get message;

  /// No description provided for @writeYourMessage.
  ///
  /// In en, this message translates to:
  /// **'Write your message'**
  String get writeYourMessage;

  /// No description provided for @sendMessage.
  ///
  /// In en, this message translates to:
  /// **'Send Message'**
  String get sendMessage;

  /// No description provided for @contactViaEmail.
  ///
  /// In en, this message translates to:
  /// **'Contact via Email'**
  String get contactViaEmail;

  /// No description provided for @pleaseEnterYourName.
  ///
  /// In en, this message translates to:
  /// **'Please enter your name'**
  String get pleaseEnterYourName;

  /// No description provided for @nameMustBeAtLeast2Characters.
  ///
  /// In en, this message translates to:
  /// **'Name must be at least 2 characters'**
  String get nameMustBeAtLeast2Characters;

  /// No description provided for @pleaseEnterYourEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email'**
  String get pleaseEnterYourEmail;

  /// No description provided for @pleaseEnterValidEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email address'**
  String get pleaseEnterValidEmail;

  /// No description provided for @pleaseEnterYourMessage.
  ///
  /// In en, this message translates to:
  /// **'Please enter your message'**
  String get pleaseEnterYourMessage;

  /// No description provided for @messageMustBeAtLeast10Characters.
  ///
  /// In en, this message translates to:
  /// **'Message must be at least 10 characters'**
  String get messageMustBeAtLeast10Characters;

  /// No description provided for @pleaseFillAllFieldsValid.
  ///
  /// In en, this message translates to:
  /// **'Please fill in all fields with valid information.'**
  String get pleaseFillAllFieldsValid;

  /// No description provided for @messageSentSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Message sent successfully!'**
  String get messageSentSuccessfully;

  /// No description provided for @failedToSendMessage.
  ///
  /// In en, this message translates to:
  /// **'Failed to send message. Please try again.'**
  String get failedToSendMessage;

  /// No description provided for @contactFormSubject.
  ///
  /// In en, this message translates to:
  /// **'[{contactType}]: '**
  String contactFormSubject(String contactType);

  /// No description provided for @sentViaKhatmaApp.
  ///
  /// In en, this message translates to:
  /// **'Sent via Khatma App'**
  String get sentViaKhatmaApp;

  /// No description provided for @chooseContactMethod.
  ///
  /// In en, this message translates to:
  /// **'Choose Contact Method'**
  String get chooseContactMethod;

  /// No description provided for @selectContactTypeDescription.
  ///
  /// In en, this message translates to:
  /// **'Select the type of inquiry to get better assistance'**
  String get selectContactTypeDescription;

  /// No description provided for @directEmailContact.
  ///
  /// In en, this message translates to:
  /// **'Direct Email Contact'**
  String get directEmailContact;

  /// No description provided for @openEmailApp.
  ///
  /// In en, this message translates to:
  /// **'Email support'**
  String get openEmailApp;

  /// No description provided for @unableToOpenEmail.
  ///
  /// In en, this message translates to:
  /// **'Unable to open email app'**
  String get unableToOpenEmail;

  /// No description provided for @emailNotAvailable.
  ///
  /// In en, this message translates to:
  /// **'Email app not available on this device'**
  String get emailNotAvailable;

  /// No description provided for @refresh.
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get refresh;

  /// No description provided for @failedToLoadFaq.
  ///
  /// In en, this message translates to:
  /// **'Failed to load FAQ'**
  String get failedToLoadFaq;

  /// No description provided for @noFaqAvailable.
  ///
  /// In en, this message translates to:
  /// **'No FAQ available'**
  String get noFaqAvailable;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
