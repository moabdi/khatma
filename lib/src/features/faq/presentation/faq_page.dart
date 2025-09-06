import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khatma/src/i18n/app_localizations_context.dart';
import 'package:khatma_ui/components/loading_list_tile.dart';

import '../application/faq_provider.dart';
import 'widgets/faq_error_view.dart';
import 'widgets/faq_list_view.dart';
import 'widgets/faq_app_bar.dart';

class FaqPage extends ConsumerWidget {
  const FaqPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final faqAsync = ref.watch(faqProvider);

    return Scaffold(
      appBar: FaqAppBar(
        onRefresh: () => ref.invalidate(faqProvider),
      ),
      body: faqAsync.when(
        loading: () => const LoadingListTile(itemCount: 10),
        error: (error, _) => FaqErrorView(
          message: '${context.loc.failedToLoadFaq}: $error',
        ),
        data: (faqs) {
          if (faqs.isEmpty) {
            return FaqErrorView(message: context.loc.noFaqAvailable);
          }
          return FaqListView(faqs: faqs);
        },
      ),
    );
  }
}
