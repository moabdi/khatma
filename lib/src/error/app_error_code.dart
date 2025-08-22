import 'package:flutter/material.dart';
import 'package:khatma/src/i18n/generated/app_localizations.dart';

enum ErrorSeverity {
  info,
  warning,
  error,
  critical,
}

enum ErrorCategory {
  auth,
  network,
  sync,
  storage,
  validation,
  business,
  limit,
  history,
  search,
  stats,
  general,
  date,
  permission,
}

enum AppErrorCode {
  noError(ErrorSeverity.info, ErrorCategory.general),
  authUserNotLoggedIn(ErrorSeverity.error, ErrorCategory.auth),
  authAnonymousNotAllowed(ErrorSeverity.warning, ErrorCategory.auth),
  authSessionExpired(ErrorSeverity.error, ErrorCategory.auth),
  authPermissionDenied(ErrorSeverity.error, ErrorCategory.auth),
  authInvalidAccount(ErrorSeverity.error, ErrorCategory.auth),
  authAccountExistsWithDifferentCredential(
      ErrorSeverity.error, ErrorCategory.auth),
  authInvalidCredential(ErrorSeverity.error, ErrorCategory.auth),
  authInvalidEmail(ErrorSeverity.error, ErrorCategory.auth),
  authOperationNotAllowed(ErrorSeverity.error, ErrorCategory.auth),
  authUserDisabled(ErrorSeverity.error, ErrorCategory.auth),
  authUserNotFound(ErrorSeverity.error, ErrorCategory.auth),
  authEmailAlreadyInUse(ErrorSeverity.error, ErrorCategory.auth),
  authWeakPassword(ErrorSeverity.error, ErrorCategory.auth),
  authRequiresRecentLogin(ErrorSeverity.error, ErrorCategory.auth),
  authTooManyRequests(ErrorSeverity.error, ErrorCategory.auth),
  authNetworkRequestFailed(ErrorSeverity.error, ErrorCategory.auth),
  authPopupBlocked(ErrorSeverity.error, ErrorCategory.auth),
  authPopClosedByUser(ErrorSeverity.error, ErrorCategory.auth),
  authActionCancelled(ErrorSeverity.info, ErrorCategory.auth),

  netConnectionFailed(ErrorSeverity.error, ErrorCategory.network),
  netTimeout(ErrorSeverity.warning, ErrorCategory.network),
  netServerError(ErrorSeverity.error, ErrorCategory.network),
  netNotFound(ErrorSeverity.warning, ErrorCategory.network),
  netUnauthorized(ErrorSeverity.error, ErrorCategory.network),
  netRateLimit(ErrorSeverity.warning, ErrorCategory.network),
  netBadRequest(ErrorSeverity.error, ErrorCategory.network),
  netUnavailable(ErrorSeverity.error, ErrorCategory.network),

  syncGeneralFailure(ErrorSeverity.warning, ErrorCategory.sync),
  syncConflict(ErrorSeverity.warning, ErrorCategory.sync),
  syncCorruptData(ErrorSeverity.critical, ErrorCategory.sync),
  syncInProgress(ErrorSeverity.info, ErrorCategory.sync),
  syncPartialFailure(ErrorSeverity.warning, ErrorCategory.sync),
  syncStatusFailed(ErrorSeverity.warning, ErrorCategory.sync),

  storageSaveFailed(ErrorSeverity.error, ErrorCategory.storage),
  storageDeleteFailed(ErrorSeverity.error, ErrorCategory.storage),
  storageLoadFailed(ErrorSeverity.error, ErrorCategory.storage),
  storageFull(ErrorSeverity.error, ErrorCategory.storage),
  storageCorrupted(ErrorSeverity.critical, ErrorCategory.storage),
  storagePermissionDenied(ErrorSeverity.error, ErrorCategory.storage),

  validationInvalidData(ErrorSeverity.warning, ErrorCategory.validation),
  validationMissingFields(ErrorSeverity.warning, ErrorCategory.validation),
  validationInvalidFormat(ErrorSeverity.warning, ErrorCategory.validation),
  validationOutOfRange(ErrorSeverity.warning, ErrorCategory.validation),
  validationInvalidDate(ErrorSeverity.warning, ErrorCategory.validation),
  validationInvalidOperation(ErrorSeverity.warning, ErrorCategory.validation),
  khatmaNotFound(ErrorSeverity.warning, ErrorCategory.business),
  khatmaAlreadyCompleted(ErrorSeverity.info, ErrorCategory.business),
  khatmaDeletionNotAllowed(ErrorSeverity.warning, ErrorCategory.business),
  khatmaArchiveFailed(ErrorSeverity.error, ErrorCategory.business),
  khatmaInvalidParts(ErrorSeverity.warning, ErrorCategory.business),
  khatmaMarkCompletedFailed(ErrorSeverity.error, ErrorCategory.business),
  khatmaRepeatFailed(ErrorSeverity.error, ErrorCategory.business),
  noPartsSelected(ErrorSeverity.warning, ErrorCategory.business),
  noKhatmaSelected(ErrorSeverity.warning, ErrorCategory.business),

  limitKhatmaMaxReached(ErrorSeverity.warning, ErrorCategory.limit),
  limitStorageQuotaExceeded(ErrorSeverity.error, ErrorCategory.limit),
  limitCreationNotAllowed(ErrorSeverity.warning, ErrorCategory.limit),

  historyCreateFailed(ErrorSeverity.warning, ErrorCategory.history),
  historyLoadFailed(ErrorSeverity.warning, ErrorCategory.history),
  historyDeleteFailed(ErrorSeverity.warning, ErrorCategory.history),
  historyNotFound(ErrorSeverity.info, ErrorCategory.history),

  searchFailed(ErrorSeverity.warning, ErrorCategory.search),
  searchNoResults(ErrorSeverity.info, ErrorCategory.search),
  searchInvalidQuery(ErrorSeverity.warning, ErrorCategory.search),
  searchTimeout(ErrorSeverity.warning, ErrorCategory.search),

  statsCalculationFailed(ErrorSeverity.warning, ErrorCategory.stats),
  statsNoData(ErrorSeverity.info, ErrorCategory.stats),
  statsExportFailed(ErrorSeverity.warning, ErrorCategory.stats),

  generalUnknown(ErrorSeverity.error, ErrorCategory.general),
  generalInvalidOperation(ErrorSeverity.warning, ErrorCategory.general),
  generalUnavailableResource(ErrorSeverity.warning, ErrorCategory.general),
  generalTimeout(ErrorSeverity.warning, ErrorCategory.general),
  generalOutOfMemory(ErrorSeverity.critical, ErrorCategory.general),
  generalConfigError(ErrorSeverity.critical, ErrorCategory.general),
  generalInitializationFailed(ErrorSeverity.critical, ErrorCategory.general),

  dateRangeInvalid(ErrorSeverity.warning, ErrorCategory.date),
  dateFormatInvalid(ErrorSeverity.warning, ErrorCategory.date),
  dateParsingFailed(ErrorSeverity.warning, ErrorCategory.date),

  permissionDenied(ErrorSeverity.error, ErrorCategory.permission),
  permissionFeatureDisabled(ErrorSeverity.warning, ErrorCategory.permission),
  permissionInsufficient(ErrorSeverity.error, ErrorCategory.permission);

  const AppErrorCode(this.severity, this.category);

  final ErrorSeverity severity;
  final ErrorCategory category;

  bool get isAuthError => category == ErrorCategory.auth;
  bool get isNetworkError => category == ErrorCategory.network;
  bool get isSyncError => category == ErrorCategory.sync;
  bool get isCritical => severity == ErrorSeverity.critical;
  bool get isValidationError => category == ErrorCategory.validation;

  IconData getIconForCategory() {
    return _categoryIcons[category] ?? Icons.error;
  }

  Color get severityColor {
    switch (severity) {
      case ErrorSeverity.info:
        return Colors.blue;
      case ErrorSeverity.warning:
        return Colors.orange;
      case ErrorSeverity.error:
        return Colors.red;
      case ErrorSeverity.critical:
        return Colors.red.shade800;
    }
  }

  Duration get displayDuration {
    switch (severity) {
      case ErrorSeverity.info:
        return const Duration(seconds: 3);
      case ErrorSeverity.warning:
        return const Duration(seconds: 5);
      case ErrorSeverity.error:
        return const Duration(seconds: 7);
      case ErrorSeverity.critical:
        return const Duration(seconds: 10);
    }
  }

  static const Map<ErrorCategory, IconData> _categoryIcons = {
    ErrorCategory.auth: Icons.security,
    ErrorCategory.network: Icons.wifi_off,
    ErrorCategory.sync: Icons.sync_problem,
    ErrorCategory.storage: Icons.storage,
    ErrorCategory.validation: Icons.error_outline,
    ErrorCategory.business: Icons.menu_book,
    ErrorCategory.limit: Icons.block,
    ErrorCategory.history: Icons.history,
    ErrorCategory.search: Icons.search_off,
    ErrorCategory.stats: Icons.analytics,
    ErrorCategory.date: Icons.date_range,
    ErrorCategory.permission: Icons.lock,
    ErrorCategory.general: Icons.error,
  };

  String getTitle(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    switch (category) {
      case ErrorCategory.auth:
        return l10n.authenticationError;
      case ErrorCategory.network:
        return l10n.networkError;
      case ErrorCategory.sync:
        return l10n.syncError;
      case ErrorCategory.storage:
        return l10n.storageError;
      case ErrorCategory.validation:
        return l10n.validationError;
      case ErrorCategory.business:
        return l10n.khatmaError;
      case ErrorCategory.limit:
        return l10n.limitError;
      case ErrorCategory.history:
        return l10n.historyError;
      case ErrorCategory.search:
        return l10n.searchError;
      case ErrorCategory.stats:
        return l10n.statsError;
      case ErrorCategory.date:
        return l10n.dateError;
      case ErrorCategory.permission:
        return l10n.permissionError;
      case ErrorCategory.general:
        return l10n.error;
    }
  }

  String translate(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return translateWith(l10n);
  }

  String translateWith(AppLocalizations l10n) {
    switch (this) {
      case AppErrorCode.authUserNotLoggedIn:
        return l10n.errorAuthUserNotLoggedIn;
      case AppErrorCode.authAnonymousNotAllowed:
        return l10n.errorAuthAnonymousNotAllowed;
      case AppErrorCode.authSessionExpired:
        return l10n.errorAuthSessionExpired;
      case AppErrorCode.authPermissionDenied:
        return l10n.errorAuthPermissionDenied;
      case AppErrorCode.authInvalidAccount:
        return l10n.errorAuthInvalidAccount;
      case AppErrorCode.authAccountExistsWithDifferentCredential:
        return l10n.errorAuthAccountExistsWithDifferentCredentials;
      case AppErrorCode.authInvalidCredential:
        return l10n.errorAuthInvalidCredentials;
      case AppErrorCode.authInvalidEmail:
        return l10n.errorAuthInvalidEmail;
      case AppErrorCode.authOperationNotAllowed:
        return l10n.errorAuthOperationNotAllowed;
      case AppErrorCode.authUserDisabled:
        return l10n.errorAuthUserDisabled;
      case AppErrorCode.authUserNotFound:
        return l10n.errorAuthUserNotFound;
      case AppErrorCode.authEmailAlreadyInUse:
        return l10n.errorAuthEmailAlreadyInUse;
      case AppErrorCode.authWeakPassword:
        return l10n.errorAuthWeakPassword;
      case AppErrorCode.authRequiresRecentLogin:
        return l10n.errorAuthRequiresRecentLogin;
      case AppErrorCode.authTooManyRequests:
        return l10n.errorAuthTooManyRequests;
      case AppErrorCode.authNetworkRequestFailed:
        return l10n.errorAuthNetworkRequestFailed;
      case AppErrorCode.authPopupBlocked:
        return l10n.errorAuthPopupBlocked;
      case AppErrorCode.authPopClosedByUser:
        return l10n.errorAuthPopClosedByUser;
      case AppErrorCode.netConnectionFailed:
        return l10n.errorNetConnectionFailed;
      case AppErrorCode.netTimeout:
        return l10n.errorNetTimeout;
      case AppErrorCode.netServerError:
        return l10n.errorNetServerError;
      case AppErrorCode.netNotFound:
        return l10n.errorNetNotFound;
      case AppErrorCode.netUnauthorized:
        return l10n.errorNetUnauthorized;
      case AppErrorCode.netRateLimit:
        return l10n.errorNetRateLimit;
      case AppErrorCode.netBadRequest:
        return l10n.errorNetBadRequest;
      case AppErrorCode.netUnavailable:
        return l10n.errorNetUnavailable;
      case AppErrorCode.syncGeneralFailure:
        return l10n.errorSyncGeneralFailure;
      case AppErrorCode.syncConflict:
        return l10n.errorSyncConflict;
      case AppErrorCode.syncCorruptData:
        return l10n.errorSyncCorruptData;
      case AppErrorCode.syncInProgress:
        return l10n.errorSyncInProgress;
      case AppErrorCode.syncPartialFailure:
        return l10n.errorSyncPartialFailure;
      case AppErrorCode.syncStatusFailed:
        return l10n.errorSyncStatusFailed;
      case AppErrorCode.storageSaveFailed:
        return l10n.errorStorageSaveFailed;
      case AppErrorCode.storageDeleteFailed:
        return l10n.errorStorageDeleteFailed;
      case AppErrorCode.storageLoadFailed:
        return l10n.errorStorageLoadFailed;
      case AppErrorCode.storageFull:
        return l10n.errorStorageFull;
      case AppErrorCode.storageCorrupted:
        return l10n.errorStorageCorrupted;
      case AppErrorCode.storagePermissionDenied:
        return l10n.errorStoragePermissionDenied;
      case AppErrorCode.validationInvalidData:
        return l10n.errorValidationInvalidData;
      case AppErrorCode.validationMissingFields:
        return l10n.errorValidationMissingFields;
      case AppErrorCode.validationInvalidFormat:
        return l10n.errorValidationInvalidFormat;
      case AppErrorCode.validationOutOfRange:
        return l10n.errorValidationOutOfRange;
      case AppErrorCode.validationInvalidDate:
        return l10n.errorValidationInvalidDate;
      case AppErrorCode.validationInvalidOperation:
        return l10n.errorValidationInvalidOperation;
      case AppErrorCode.khatmaNotFound:
        return l10n.errorKhatmaNotFound;
      case AppErrorCode.khatmaAlreadyCompleted:
        return l10n.errorKhatmaAlreadyCompleted;
      case AppErrorCode.khatmaDeletionNotAllowed:
        return l10n.errorKhatmaDeletionNotAllowed;
      case AppErrorCode.khatmaArchiveFailed:
        return l10n.errorKhatmaArchiveFailed;
      case AppErrorCode.khatmaInvalidParts:
        return l10n.errorKhatmaInvalidParts;
      case AppErrorCode.khatmaMarkCompletedFailed:
        return l10n.errorKhatmaMarkCompletedFailed;
      case AppErrorCode.khatmaRepeatFailed:
        return l10n.errorKhatmaRepeatFailed;
      case AppErrorCode.limitKhatmaMaxReached:
        return l10n.errorLimitKhatmaMaxReached;
      case AppErrorCode.limitStorageQuotaExceeded:
        return l10n.errorLimitStorageQuotaExceeded;
      case AppErrorCode.limitCreationNotAllowed:
        return l10n.errorLimitCreationNotAllowed;
      case AppErrorCode.historyCreateFailed:
        return l10n.errorHistoryCreateFailed;
      case AppErrorCode.historyLoadFailed:
        return l10n.errorHistoryLoadFailed;
      case AppErrorCode.historyDeleteFailed:
        return l10n.errorHistoryDeleteFailed;
      case AppErrorCode.historyNotFound:
        return l10n.errorHistoryNotFound;
      case AppErrorCode.searchFailed:
        return l10n.errorSearchFailed;
      case AppErrorCode.searchNoResults:
        return l10n.errorSearchNoResults;
      case AppErrorCode.searchInvalidQuery:
        return l10n.errorSearchInvalidQuery;
      case AppErrorCode.searchTimeout:
        return l10n.errorSearchTimeout;
      case AppErrorCode.statsCalculationFailed:
        return l10n.errorStatsCalculationFailed;
      case AppErrorCode.statsNoData:
        return l10n.errorStatsNoData;
      case AppErrorCode.statsExportFailed:
        return l10n.errorStatsExportFailed;
      case AppErrorCode.generalUnknown:
        return l10n.errorGeneralUnknown;
      case AppErrorCode.authActionCancelled:
        return l10n.errorAuthActionCancelled;
      case AppErrorCode.generalInvalidOperation:
        return l10n.errorGeneralInvalidOperation;
      case AppErrorCode.generalUnavailableResource:
        return l10n.errorGeneralUnavailableResource;
      case AppErrorCode.generalTimeout:
        return l10n.errorGeneralTimeout;
      case AppErrorCode.generalOutOfMemory:
        return l10n.errorGeneralOutOfMemory;
      case AppErrorCode.generalConfigError:
        return l10n.errorGeneralConfigError;
      case AppErrorCode.generalInitializationFailed:
        return l10n.errorGeneralInitializationFailed;
      case AppErrorCode.dateRangeInvalid:
        return l10n.errorDateRangeInvalid;
      case AppErrorCode.dateFormatInvalid:
        return l10n.errorDateFormatInvalid;
      case AppErrorCode.dateParsingFailed:
        return l10n.errorDateParsingFailed;
      case AppErrorCode.permissionDenied:
        return l10n.errorPermissionDenied;
      case AppErrorCode.permissionFeatureDisabled:
        return l10n.errorPermissionFeatureDisabled;
      case AppErrorCode.permissionInsufficient:
        return l10n.errorPermissionInsufficient;
      case AppErrorCode.noPartsSelected:
        return l10n.errorNoPartsSelected;
      case AppErrorCode.noKhatmaSelected:
        return l10n.errorNoKhatmaSelected;
      case AppErrorCode.noError:
        return "";
    }
  }
}
