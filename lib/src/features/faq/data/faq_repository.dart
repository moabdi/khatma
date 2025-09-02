import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../service/faq_service.dart';
import '../domain/faq_entry.dart';

part 'faq_repository.g.dart';

@riverpod
FaqRepository faqRepository(Ref ref) {
  final service = ref.watch(faqServiceProvider);
  return FaqRepository(service);
}

class FaqRepository {
  final FaqService service;

  FaqRepository(this.service);

  Future<List<FaqEntry>> loadFaq(String locale) async {
    final fileName = _getFaqFileName(locale);

    try {
      final raw = await service.loadRawContent('assets/faq/$fileName');
      return service.parse(raw);
    } catch (_) {
      try {
        final raw = await service.loadRawContent('assets/faq/faq_en.md');
        return service.parse(raw);
      } catch (_) {
        return [
          const FaqEntry(
            question: 'Error loading FAQ',
            answer:
                'Please check if the FAQ files exist in assets/faq/ directory.',
          ),
        ];
      }
    }
  }

  String _getFaqFileName(String locale) {
    switch (locale) {
      case 'ar':
        return 'faq_ar.md';
      case 'fr':
        return 'faq_fr.md';
      default:
        return 'faq_en.md';
    }
  }
}
