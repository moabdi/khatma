import 'package:khatma/src/common_widgets/async_value_widget.dart';
import 'package:khatma/src/features/khatma/data/fake_khatma_repository.dart';
import 'package:khatma/src/features/khatma/domain/khatma.dart';
import 'package:khatma/src/features/khatma/presentation/khatma_list/khatma_card.dart';
import 'package:khatma/src/localization/string_hardcoded.dart';
import 'package:khatma/src/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// A widget that displays the list of khatmas that match the search query.
class KhatmatListView extends ConsumerWidget {
  const KhatmatListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final khatmatListValue = ref.watch(khatmasListStreamProvider);
    return AsyncValueWidget<List<Khatma>>(
      value: khatmatListValue,
      data: (khatmat) => khatmat.isEmpty
          ? Center(
              child: Text(
                'No khatma found'.hardcoded,
                style: Theme.of(context).textTheme.headline4,
              ),
            )
          : ListView.builder(
              shrinkWrap: true,
              primary: false,
              itemCount: khatmat.length,
              itemBuilder: (_, index) {
                final khatma = khatmat[index];
                return KhatmaCard(
                  khatma: khatma,
                  onPressed: () => context.goNamed(
                    AppRoute.khatmaDetails.name,
                    params: {'id': khatma.id!},
                  ),
                );
              },
            ),
    );
  }
}
