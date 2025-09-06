// lib/src/features/settings/data/about_service.dart
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:khatma/src/i18n/local_provider.dart';

part 'about_service.freezed.dart';

@freezed
abstract class AboutContent with _$AboutContent {
  const factory AboutContent({
    required String content,
    required String locale,
    required DateTime loadedAt,
  }) = _AboutContent;
}

class AboutService {
  static const String _basePath = 'assets/docs/about';

  /// Supported locales for about content
  static const List<String> supportedLocales = ['fr', 'en', 'ar'];

  /// Cache for loaded content to avoid repeated asset loading
  final Map<String, AboutContent> _cache = {};

  /// Get about content for a specific locale
  /// Falls back to English if locale not found
  /// Then falls back to French if English not found
  Future<AboutContent> getAboutContent(String locale) async {
    // Check cache first
    if (_cache.containsKey(locale)) {
      return _cache[locale]!;
    }

    String content;
    String actualLocale = locale;

    try {
      // Try to load content for requested locale
      content = await _loadAssetContent(locale);
    } catch (e) {
      try {
        // Fallback to English
        actualLocale = 'en';
        content = await _loadAssetContent('en');
      } catch (e2) {
        try {
          // Final fallback to French
          actualLocale = 'fr';
          content = await _loadAssetContent('fr');
        } catch (e3) {
          // If all fails, return error content
          content = _getErrorContent(locale);
          actualLocale = locale;
        }
      }
    }

    final aboutContent = AboutContent(
      content: content,
      locale: actualLocale,
      loadedAt: DateTime.now(),
    );

    // Cache the result
    _cache[locale] = aboutContent;

    return aboutContent;
  }

  /// Load content from assets
  Future<String> _loadAssetContent(String locale) async {
    final fileName = 'about_us_$locale.md';
    final path = '$_basePath/$fileName';

    return await rootBundle.loadString(path);
  }

  /// Get error content when files are not found
  String _getErrorContent(String locale) {
    return '''
# ✨ About Khatma

Welcome to Khatma, your spiritual companion for Quran reading.

## 📞 Contact Support

For any questions or support, please contact us:

**Email**: [support@khatma.app](mailto:support@khatma.app)

---

*The Khatma Team*
''';
  }

  /// Clear cache (useful for testing or manual refresh)
  void clearCache() {
    _cache.clear();
  }

  /// Check if content is cached for a locale
  bool isCached(String locale) {
    return _cache.containsKey(locale);
  }

  /// Get all cached locales
  List<String> getCachedLocales() {
    return _cache.keys.toList();
  }
}

// Riverpod Providers

/// Provider for AboutService instance
final aboutServiceProvider = Provider<AboutService>((ref) {
  return AboutService();
});

/// Provider for current locale about content
/// This will automatically react to locale changes
final aboutContentProvider = FutureProvider<AboutContent>((ref) async {
  final locale = ref.watch(localeProvider).languageCode;
  final service = ref.read(aboutServiceProvider);
  return await service.getAboutContent(locale);
});

/// Provider for about content cache status
final aboutCacheStatusProvider = StateProvider<Map<String, bool>>((ref) {
  return {};
});

/// Provider to clear about content cache
final clearAboutCacheProvider = Provider<void Function()>((ref) {
  return () {
    ref.read(aboutServiceProvider).clearCache();
    ref.invalidate(aboutContentProvider);
    ref.read(aboutCacheStatusProvider.notifier).state = {};
  };
});

/// Provider for checking if specific locale is supported
final isSupportedLocaleProvider = Provider.family<bool, String>((ref, locale) {
  return AboutService.supportedLocales.contains(locale);
});
