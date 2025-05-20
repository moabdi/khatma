import 'package:khatma_ui/components/animation/flashing_widget.dart';
import 'package:khatma_ui/constants/app_sizes.dart';
import 'package:khatma/src/widgets/async_value_widget.dart';
import 'package:khatma_ui/components/loading_list_tile.dart';
import 'package:khatma/src/features/khatma/application/khatmat_provider.dart';
import 'package:khatma/src/features/khatma/domain/khatma.dart';
import 'package:khatma/src/features/khatma/presentation/list/ui/khatma_tile.dart';
import 'package:khatma/src/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class KhatmatListView extends ConsumerWidget {
  const KhatmatListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final khatmatListValue = ref.watch(khatmaListProvider);
    if (khatmatListValue.hasError) {
      return Center(
        child: const Card(
          child: Center(
            child: Text("Vous n'avez pas de khatma en cours"),
          ),
        ),
      );
    }
    return AsyncValueWidget<List<Khatma>>(
      loading: const LoadingListTile(itemCount: 10),
      value: khatmatListValue,
      data: (khatmat) => khatmat.isEmpty
          ? SizedBox.shrink()
          : buildKhatmaList(khatmat, context, ref),
    );
  }

  Widget buildKhatmaList(
      List<Khatma> khatmat, BuildContext context, WidgetRef ref) {
    return Card(
      color: Theme.of(context).primaryColor.withAlpha(51),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
            child: Text(
              "Khatmats en cours",
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Theme.of(context).primaryColor.withAlpha(230)),
            ),
          ),
          ListView.builder(
            padding: EdgeInsets.all(5),
            shrinkWrap: true,
            primary: false,
            itemCount: khatmat.length,
            itemBuilder: (_, index) {
              final khatma = khatmat[index];
              return buildCardKhatma(khatma, ref, context);
            },
          ),
          gapH8,
        ],
      ),
    );
  }

  Widget buildCardKhatma(Khatma khatma, WidgetRef ref, BuildContext context) {
    final now = DateTime.now();
    final differenceInMinutes = now.difference(khatma.startDate).inMinutes;
    bool animate = differenceInMinutes == 0;

    print('[buildCardKhatma] Now: $now');
    print('[buildCardKhatma] Khatma Start Date: ${khatma.startDate}');
    print('[buildCardKhatma] Difference in minutes: $differenceInMinutes');
    print('[buildCardKhatma] Animate: $animate');
    print('[buildCardKhatma] Khatma ID: ${khatma.id}');
    print('[buildCardKhatma] Khatma Name: ${khatma.name}');

    var khatmaTile = KhatmaTile(
      khatma: khatma,
      onPressed: () {
        print('[onPressed] Tapped Khatma: ${khatma.name} (${khatma.id})');

        ref.read(currentKhatmaProvider.notifier).updateValue(khatma);

        context.goNamed(
          AppRoute.khatmaDetails.name,
          pathParameters: {'id': khatma.id!},
        );
      },
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Card(
        elevation: 0.4,
        clipBehavior: Clip.antiAlias,
        child: animate ? FlashingListTile(child: khatmaTile) : khatmaTile,
      ),
    );
  }

}
