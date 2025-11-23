// lib/src/features/authentication/data/google_signin_config.dart

/// Configuration pour Google Sign-In
///
/// Instructions pour obtenir les Client IDs:
/// 1. Allez sur Firebase Console (https://console.firebase.google.com)
/// 2. Sélectionnez votre projet Khatma
/// 3. Cliquez sur l'icône ⚙️ (Project Settings)
/// 4. Onglet "General" > section "Your apps"
/// 5. Copiez les Client IDs correspondants
class GoogleSignInConfig {
  /// Web Client ID - Obligatoire pour le web
  /// Format: "123456789012-abcdefghijklmnopqrstuvwxyz123456.apps.googleusercontent.com"
  ///
  /// Comment l'obtenir:
  /// Firebase Console > Project Settings > General > Your apps > Web app
  static const String webClientId =
      'YOUR_WEB_CLIENT_ID.apps.googleusercontent.com';

  /// iOS Client ID - Optionnel (peut être lu depuis GoogleService-Info.plist)
  /// Format: "123456789012-abcdefghijklmnopqrstuvwxyz123456.apps.googleusercontent.com"
  ///
  /// Comment l'obtenir:
  /// Firebase Console > Project Settings > General > Your apps > iOS app
  static const String iosClientId =
      'YOUR_IOS_CLIENT_ID.apps.googleusercontent.com';

  /// Android Client ID - Généralement lu automatiquement depuis google-services.json
  /// Mais peut être spécifié explicitement si nécessaire
  static const String? androidClientId = null; // Optionnel

  /// Scopes demandés lors de la connexion Google
  static const List<String> scopes = [
    'email',
    'profile',
  ];

  /// Configuration par défaut selon la plateforme
  static GoogleSignInConfig get defaultConfig => GoogleSignInConfig._();

  GoogleSignInConfig._();

  /// Validation de la configuration
  static bool get isWebConfigured =>
      webClientId != 'YOUR_WEB_CLIENT_ID.apps.googleusercontent.com' &&
      webClientId.isNotEmpty &&
      webClientId.contains('.apps.googleusercontent.com');

  static bool get isIosConfigured =>
      iosClientId != 'YOUR_IOS_CLIENT_ID.apps.googleusercontent.com' &&
      iosClientId.isNotEmpty &&
      iosClientId.contains('.apps.googleusercontent.com');

  /// Messages d'aide pour la configuration
  static String get configurationHelp => '''
🔧 Configuration Google Sign-In

1. Allez sur Firebase Console: https://console.firebase.google.com
2. Sélectionnez votre projet Khatma
3. Cliquez sur ⚙️ (Project Settings)
4. Onglet "General" > section "Your apps"
5. Copiez les Client IDs et remplacez dans GoogleSignInConfig

Web Client ID: Nécessaire pour le web
iOS Client ID: Optionnel (lu depuis GoogleService-Info.plist si absent)
Android Client ID: Optionnel (lu depuis google-services.json)
''';
}

/// Extension pour faciliter l'utilisation
extension GoogleSignInConfigExtension on GoogleSignInConfig {
  /// Client ID à utiliser selon la plateforme
  String? getClientIdForCurrentPlatform() {
    if (identical(0, 0.0)) {
      // Web detection trick
      return GoogleSignInConfig.isWebConfigured
          ? GoogleSignInConfig.webClientId
          : null;
    } else {
      // Mobile - retourne null pour utiliser les fichiers de config par défaut
      // ou retourne le clientId spécifique si configuré
      return null;
    }
  }
}

/// Classe d'aide pour les erreurs de configuration
class GoogleSignInConfigError {
  static Exception webClientIdNotSet() =>
      Exception('Web Client ID not configured.\n\n'
          '${GoogleSignInConfig.configurationHelp}\n\n'
          'Current webClientId: "${GoogleSignInConfig.webClientId}"');

  static Exception invalidClientIdFormat(String clientId) =>
      Exception('Invalid Client ID format: "$clientId"\n\n'
          'Client ID should end with ".apps.googleusercontent.com"');
}
