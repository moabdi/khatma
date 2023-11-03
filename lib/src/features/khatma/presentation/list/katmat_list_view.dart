import 'package:khatma/src/common/widgets/async_value_widget.dart';
import 'package:khatma/src/features/khatma/data/fake_khatma_repository.dart';
import 'package:khatma/src/features/khatma/data/khatma_notifier.dart';
import 'package:khatma/src/features/khatma/data/selected_items_notifier.dart';
import 'package:khatma/src/features/khatma/domain/khatma.dart';
import 'package:khatma/src/features/khatma/presentation/list/khatma_tile.dart';
import 'package:khatma/src/localization/string_hardcoded.dart';
import 'package:khatma/src/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class KhatmatListView extends ConsumerWidget {
  const KhatmatListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(formKhatmaProvider);
    final khatmatListValue = ref.watch(khatmasListStreamProvider);
    return AsyncValueWidget<List<Khatma>>(
      value: khatmatListValue,
      data: (khatmat) => khatmat.isEmpty
          ? buildNoFound(context)
          : buildKhatmaList(khatmat, context, ref),
    );
  }

  Center buildNoFound(BuildContext context) {
    return Center(
      child: Text(
        'No khatma found'.hardcoded,
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }

  ListView buildKhatmaList(
      List<Khatma> khatmat, BuildContext context, WidgetRef ref) {
    return ListView.builder(
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
              ref.read(formKhatmaProvider).updateKhatma(khatma);
              ref.read(selectedItemsNotifier.notifier).initSelection([]);
              context.goNamed(AppRoute.khatmaDetails.name,
                  pathParameters: {'id': khatma.id!});
            },
          ),
        );
      },
    );
  }
}
