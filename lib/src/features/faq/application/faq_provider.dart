import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khatma/src/i18n/local_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../data/faq_repository.dart';
import '../domain/faq_entry.dart';

part 'faq_provider.g.dart';

// Cache provider - keeps FAQ data in memory
@riverpod
class FaqCache extends _$FaqCache {
  final Map<String, List<FaqEntry>> _cache = {};

  @override
  Map<String, List<FaqEntry>> build() {
    // Preload common locales on initialization
    _preloadFaqs();
    return _cache;
  }

  Future<void> _preloadFaqs() async {
    final repository = ref.watch(faqRepositoryProvider);

    // Preload common locales
    final commonLocales = ['en', 'ar', 'fr'];

    for (final locale in commonLocales) {
      try {
        final faqs = await repository.loadFaq(locale);
        _cache[locale] = faqs;
      } catch (e) {
        // Silently ignore preload errors
        print('Failed to preload FAQ for $locale: $e');
      }
    }

    // Notify listeners that cache is updated
    if (_cache.isNotEmpty) {
      state = Map.from(_cache);
    }
  }

  Future<List<FaqEntry>> getFaq(String locale) async {
    // Return from cache if available
    if (_cache.containsKey(locale)) {
      return _cache[locale]!;
    }

    // Load and cache if not available
    final repository = ref.watch(faqRepositoryProvider);
    final faqs = await repository.loadFaq(locale);
    _cache[locale] = faqs;
    state = Map.from(_cache);

    return faqs;
  }

  void invalidateLocale(String locale) {
    _cache.remove(locale);
    state = Map.from(_cache);
  }

  void clearCache() {
    _cache.clear();
    state = {};
  }
}

// Public provider - This is what UI should use
@riverpod
FutureOr<List<FaqEntry>> faq(Ref ref) async {
  final cache = ref.watch(faqCacheProvider.notifier);
  final locale = ref.watch(localeProvider).languageCode;
  return await cache.getFaq(locale);
}

// Preload provider - call this on app startup
@riverpod
Future<void> preloadFaq(Ref ref) async {
  // This will trigger the cache initialization
  ref.watch(faqCacheProvider);

  // Wait a bit to ensure preloading completes
  await Future.delayed(const Duration(milliseconds: 500));
}

// Optional: Provider for current locale FAQ if you have a locale provider
@riverpod
FutureOr<List<FaqEntry>> currentFaq(Ref ref) async {
  return ref.watch(faqProvider.future);
}
