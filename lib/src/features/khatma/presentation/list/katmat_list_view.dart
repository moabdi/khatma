import 'package:khatma/src/common/constants/app_sizes.dart';
import 'package:khatma/src/common/widgets/async_value_widget.dart';
import 'package:khatma/src/common/widgets/loading_list_tile.dart';
import 'package:khatma/src/features/khatma/application/khatmat_provider.dart';
import 'package:khatma/src/features/khatma/domain/khatma.dart';
import 'package:khatma/src/features/khatma/presentation/list/khatma_not_found.dart';
import 'package:khatma/src/features/khatma/presentation/list/khatma_tile.dart';
import 'package:khatma/src/features/khatma/presentation/list/top_list_khatma.dart';
import 'package:khatma/src/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class KhatmatListView extends ConsumerWidget {
  const KhatmatListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final khatmatListValue = ref.watch(khatmaListProvider);
    return AsyncValueWidget<List<Khatma>>(
      loading: const LoadingListTile(itemCount: 10),
      value: khatmatListValue,
      data: (khatmat) =>
          khatmat.isEmpty ? Frame313() : buildKhatmaList(khatmat, context, ref),
    );
  }

  Widget buildKhatmaList(
      List<Khatma> khatmat, BuildContext context, WidgetRef ref) {
    return Card(
      elevation: 0.1,
      color: Theme.of(context).colorScheme.background,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: [
            TopListKhatmat(),
            gapH8,
            ListView.builder(
              shrinkWrap: true,
              primary: false,
              itemCount: khatmat.length,
              itemBuilder: (_, index) {
                final khatma = khatmat[index];
                return Card(
                  elevation: 0.4,
                  clipBehavior: Clip.antiAlias,
                  child: KhatmaTile(
                    khatma: khatma,
                    onPressed: () {
                      ref
                          .read(currentKhatmaProvider.notifier)
                          .updateValue(khatma);
                      context.goNamed(AppRoute.khatmaDetails.name,
                          pathParameters: {'id': khatma.id!});
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
