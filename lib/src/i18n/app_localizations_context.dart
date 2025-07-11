// lib/src/localization/app_localizations_context.dart

import 'package:flutter/material.dart';
import 'package:khatma/src/i18n/generated/app_localizations.dart';

/// Extension pour faciliter l'accès aux traductions via le contexte
extension AppLocalizationsX on BuildContext {
  /// Raccourci pour accéder aux traductions
  /// Usage: context.loc.myTranslationKey
  AppLocalizations get loc => AppLocalizations.of(this);
}
