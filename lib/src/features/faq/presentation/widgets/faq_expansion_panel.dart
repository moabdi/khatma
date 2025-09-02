import 'package:flutter/material.dart';
import 'package:khatma/src/themes/theme.dart';

import '../../domain/faq_entry.dart';
import 'faq_header.dart';
import 'faq_content.dart';

class FaqExpansionPanel extends StatelessWidget {
  final FaqEntry entry;
  final int index;
  final bool isExpanded;
  final Animation<double> animation;
  final VoidCallback onToggle;

  const FaqExpansionPanel({
    super.key,
    required this.entry,
    required this.index,
    required this.isExpanded,
    required this.animation,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Card(
          elevation: isExpanded ? 4 : 2,
          shadowColor: context.colorScheme.primary.withOpacity(0.1),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Column(
              children: [
                FaqHeader(
                  question: entry.question,
                  index: index,
                  isExpanded: isExpanded,
                  animation: animation,
                  onToggle: onToggle,
                ),
                SizeTransition(
                  sizeFactor: animation,
                  child: FaqContent(
                    answer: entry.answer,
                    animation: animation,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
