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
  khatma,
  limit,
  history,
  search,
  stats,
  general,
  date,
  permission,
}

enum ErrorCode {
  noError(ErrorSeverity.info, ErrorCategory.general),
  authUserNotLoggedIn(ErrorSeverity.error, ErrorCategory.auth),
  authAnonymousNotAllowed(ErrorSeverity.warning, ErrorCategory.auth),
  authSessionExpired(ErrorSeverity.error, ErrorCategory.auth),
  authPermissionDenied(ErrorSeverity.error, ErrorCategory.auth),
  authInvalidAccount(ErrorSeverity.critical, ErrorCategory.auth),

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

  khatmaNotFound(ErrorSeverity.warning, ErrorCategory.khatma),
  khatmaAlreadyCompleted(ErrorSeverity.info, ErrorCategory.khatma),
  khatmaDeletionNotAllowed(ErrorSeverity.warning, ErrorCategory.khatma),
  khatmaArchiveFailed(ErrorSeverity.error, ErrorCategory.khatma),
  khatmaInvalidParts(ErrorSeverity.warning, ErrorCategory.khatma),
  khatmaMarkCompletedFailed(ErrorSeverity.error, ErrorCategory.khatma),
  khatmaRepeatFailed(ErrorSeverity.error, ErrorCategory.khatma),
  noPartsSelected(ErrorSeverity.warning, ErrorCategory.khatma),
  noKhatmaSelected(ErrorSeverity.warning, ErrorCategory.khatma),

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
  generalCancelled(ErrorSeverity.info, ErrorCategory.general),
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

  const ErrorCode(this.severity, this.category);

  final ErrorSeverity severity;
  final ErrorCategory category;

  bool get isAuthError => category == ErrorCategory.auth;
  bool get isNetworkError => category == ErrorCategory.network;
  bool get isSyncError => category == ErrorCategory.sync;
  bool get isCritical => severity == ErrorSeverity.critical;
  bool get isValidationError => category == ErrorCategory.validation;

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

  String translate(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return _getTranslation(l10n);
  }

  String translateWith(AppLocalizations l10n) {
    return _getTranslation(l10n);
  }

  String translateMessage(AppLocalizations l10n, ErrorCode key) {
    return key.translateWith(l10n);
  }

  String _getTranslation(AppLocalizations l10n) {
    switch (this) {
      case ErrorCode.authUserNotLoggedIn:
        return l10n.errorAuthUserNotLoggedIn;
      case ErrorCode.authAnonymousNotAllowed:
        return l10n.errorAuthAnonymousNotAllowed;
      case ErrorCode.authSessionExpired:
        return l10n.errorAuthSessionExpired;
      case ErrorCode.authPermissionDenied:
        return l10n.errorAuthPermissionDenied;
      case ErrorCode.authInvalidAccount:
        return l10n.errorAuthInvalidAccount;
      case ErrorCode.netConnectionFailed:
        return l10n.errorNetConnectionFailed;
      case ErrorCode.netTimeout:
        return l10n.errorNetTimeout;
      case ErrorCode.netServerError:
        return l10n.errorNetServerError;
      case ErrorCode.netNotFound:
        return l10n.errorNetNotFound;
      case ErrorCode.netUnauthorized:
        return l10n.errorNetUnauthorized;
      case ErrorCode.netRateLimit:
        return l10n.errorNetRateLimit;
      case ErrorCode.netBadRequest:
        return l10n.errorNetBadRequest;
      case ErrorCode.netUnavailable:
        return l10n.errorNetUnavailable;
      case ErrorCode.syncGeneralFailure:
        return l10n.errorSyncGeneralFailure;
      case ErrorCode.syncConflict:
        return l10n.errorSyncConflict;
      case ErrorCode.syncCorruptData:
        return l10n.errorSyncCorruptData;
      case ErrorCode.syncInProgress:
        return l10n.errorSyncInProgress;
      case ErrorCode.syncPartialFailure:
        return l10n.errorSyncPartialFailure;
      case ErrorCode.syncStatusFailed:
        return l10n.errorSyncStatusFailed;
      case ErrorCode.storageSaveFailed:
        return l10n.errorStorageSaveFailed;
      case ErrorCode.storageDeleteFailed:
        return l10n.errorStorageDeleteFailed;
      case ErrorCode.storageLoadFailed:
        return l10n.errorStorageLoadFailed;
      case ErrorCode.storageFull:
        return l10n.errorStorageFull;
      case ErrorCode.storageCorrupted:
        return l10n.errorStorageCorrupted;
      case ErrorCode.storagePermissionDenied:
        return l10n.errorStoragePermissionDenied;
      case ErrorCode.validationInvalidData:
        return l10n.errorValidationInvalidData;
      case ErrorCode.validationMissingFields:
        return l10n.errorValidationMissingFields;
      case ErrorCode.validationInvalidFormat:
        return l10n.errorValidationInvalidFormat;
      case ErrorCode.validationOutOfRange:
        return l10n.errorValidationOutOfRange;
      case ErrorCode.validationInvalidDate:
        return l10n.errorValidationInvalidDate;
      case ErrorCode.khatmaNotFound:
        return l10n.errorKhatmaNotFound;
      case ErrorCode.khatmaAlreadyCompleted:
        return l10n.errorKhatmaAlreadyCompleted;
      case ErrorCode.khatmaDeletionNotAllowed:
        return l10n.errorKhatmaDeletionNotAllowed;
      case ErrorCode.khatmaArchiveFailed:
        return l10n.errorKhatmaArchiveFailed;
      case ErrorCode.khatmaInvalidParts:
        return l10n.errorKhatmaInvalidParts;
      case ErrorCode.khatmaMarkCompletedFailed:
        return l10n.errorKhatmaMarkCompletedFailed;
      case ErrorCode.khatmaRepeatFailed:
        return l10n.errorKhatmaRepeatFailed;
      case ErrorCode.limitKhatmaMaxReached:
        return l10n.errorLimitKhatmaMaxReached;
      case ErrorCode.limitStorageQuotaExceeded:
        return l10n.errorLimitStorageQuotaExceeded;
      case ErrorCode.limitCreationNotAllowed:
        return l10n.errorLimitCreationNotAllowed;
      case ErrorCode.historyCreateFailed:
        return l10n.errorHistoryCreateFailed;
      case ErrorCode.historyLoadFailed:
        return l10n.errorHistoryLoadFailed;
      case ErrorCode.historyDeleteFailed:
        return l10n.errorHistoryDeleteFailed;
      case ErrorCode.historyNotFound:
        return l10n.errorHistoryNotFound;
      case ErrorCode.searchFailed:
        return l10n.errorSearchFailed;
      case ErrorCode.searchNoResults:
        return l10n.errorSearchNoResults;
      case ErrorCode.searchInvalidQuery:
        return l10n.errorSearchInvalidQuery;
      case ErrorCode.searchTimeout:
        return l10n.errorSearchTimeout;
      case ErrorCode.statsCalculationFailed:
        return l10n.errorStatsCalculationFailed;
      case ErrorCode.statsNoData:
        return l10n.errorStatsNoData;
      case ErrorCode.statsExportFailed:
        return l10n.errorStatsExportFailed;
      case ErrorCode.generalUnknown:
        return l10n.errorGeneralUnknown;
      case ErrorCode.generalCancelled:
        return l10n.errorGeneralCancelled;
      case ErrorCode.generalInvalidOperation:
        return l10n.errorGeneralInvalidOperation;
      case ErrorCode.generalUnavailableResource:
        return l10n.errorGeneralUnavailableResource;
      case ErrorCode.generalTimeout:
        return l10n.errorGeneralTimeout;
      case ErrorCode.generalOutOfMemory:
        return l10n.errorGeneralOutOfMemory;
      case ErrorCode.generalConfigError:
        return l10n.errorGeneralConfigError;
      case ErrorCode.generalInitializationFailed:
        return l10n.errorGeneralInitializationFailed;
      case ErrorCode.dateRangeInvalid:
        return l10n.errorDateRangeInvalid;
      case ErrorCode.dateFormatInvalid:
        return l10n.errorDateFormatInvalid;
      case ErrorCode.dateParsingFailed:
        return l10n.errorDateParsingFailed;
      case ErrorCode.permissionDenied:
        return l10n.errorPermissionDenied;
      case ErrorCode.permissionFeatureDisabled:
        return l10n.errorPermissionFeatureDisabled;
      case ErrorCode.permissionInsufficient:
        return l10n.errorPermissionInsufficient;
      case ErrorCode.noError:
        return "";
      case ErrorCode.noPartsSelected:
        return l10n.errorPermissionInsufficient;
      case ErrorCode.noKhatmaSelected:
        return l10n.errorPermissionInsufficient;
    }
  }
}
