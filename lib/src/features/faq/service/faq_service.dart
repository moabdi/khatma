import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../domain/faq_entry.dart';

part 'faq_service.g.dart';

@riverpod
FaqService faqService(Ref ref) {
  return FaqService();
}

class FaqService {
  Future<String> loadRawContent(String path) async {
    return await rootBundle.loadString(path);
  }

  List<FaqEntry> parse(String content) {
    final faqs = <FaqEntry>[];
    final lines = content.split('\n');

    String? currentQuestion;
    List<String> currentAnswer = [];

    for (final line in lines) {
      if (line.startsWith('# ') && line.length > 2) {
        if (currentQuestion != null && currentAnswer.isNotEmpty) {
          faqs.add(FaqEntry(
            question: currentQuestion,
            answer: currentAnswer.join('\n').trim(),
          ));
        }
        currentQuestion = line.substring(2).trim();
        currentAnswer = [];
      } else if (currentQuestion != null) {
        currentAnswer.add(line);
      }
    }

    if (currentQuestion != null && currentAnswer.isNotEmpty) {
      faqs.add(FaqEntry(
        question: currentQuestion,
        answer: currentAnswer.join('\n').trim(),
      ));
    }

    return faqs;
  }
}
