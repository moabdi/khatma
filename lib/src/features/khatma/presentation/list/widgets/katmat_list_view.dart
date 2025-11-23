import 'package:khatma/src/features/khatma/presentation/list/widgets/welcome_home.dart';
import 'package:khatma/src/i18n/app_localizations_context.dart';
import 'package:khatma/src/themes/theme.dart';
import 'package:khatma_ui/components/animation/flashing_widget.dart';
import 'package:khatma_ui/constants/app_sizes.dart';
import 'package:khatma/src/widgets/async_value_widget.dart';
import 'package:khatma_ui/components/loading_list_tile.dart';
import 'package:khatma/src/features/khatma/application/khatma_manager.dart';
import 'package:khatma/src/features/khatma/domain/khatma.dart';
import 'package:khatma/src/features/khatma/presentation/list/widgets/improved_khatma_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class KhatmatListView extends ConsumerWidget {
  const KhatmatListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final khatmatListValue = ref.watch(khatmaManagerProvider).khatmas;
    return AsyncValueWidget<List<Khatma>>(
      loading: const LoadingListTile(itemCount: 10),
      value: khatmatListValue,
      data: (khatmat) => khatmat.isEmpty
          ? WelcomeHome()
          : buildKhatmaList(khatmat, context, ref),
    );
  }

  Widget buildKhatmaList(
      List<Khatma> khatmat, BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                context.loc.khatmaListSubtitle,
                style: context.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: context.colorScheme.onSurface,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: context.colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${khatmat.length}',
                  style: context.textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: context.colorScheme.onPrimaryContainer,
                  ),
                ),
              ),
            ],
          ),
        ),
        gapH8,
        ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          shrinkWrap: true,
          primary: false,
          itemCount: khatmat.length,
          itemBuilder: (_, index) {
            final khatma = khatmat[index];
            return buildCardKhatma(khatma, ref, context);
          },
        ),
        gapH16,
      ],
    );
  }

  Widget buildCardKhatma(Khatma khatma, WidgetRef ref, BuildContext context) {
    bool animate = DateTime.now().difference(khatma.startDate).inMinutes == 0;
    var khatmaTile = ImprovedKhatmaTile(
      khatma: khatma,
      onPressed: () {
        ref.read(khatmaManagerProvider.notifier).selectKhatma(khatma);
        // Navigate to the appropriate route based on khatma type
        final route = switch (khatma.type) {
          KhatmaType.shared => '/khatma/shared/${khatma.id!}',
          KhatmaType.hifz => '/khatma', // Fallback to home until hifz is implemented
          KhatmaType.personal => '/khatma/personal/${khatma.id!}',
        };
        context.go(route);
      },
    );
    return animate ? FlashingListTile(child: khatmaTile) : khatmaTile;
  }
}
