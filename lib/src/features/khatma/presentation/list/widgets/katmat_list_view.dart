import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:khatma/src/features/khatma/application/khatma_manager.dart';
import 'package:khatma/src/features/khatma/domain/khatma.dart';
import 'package:khatma/src/features/khatma/presentation/list/logic/khatma_list_filter_provider.dart';
import 'package:khatma/src/features/khatma/presentation/list/widgets/khatma_tile.dart';
import 'package:khatma/src/features/khatma/presentation/list/widgets/welcome_home.dart';
import 'package:khatma/src/i18n/app_localizations_context.dart';
import 'package:khatma/src/themes/theme.dart';
import 'package:khatma/src/widgets/async_value_widget.dart';
import 'package:khatma_ui/khatma_ui.dart';

class KhatmatListView extends ConsumerWidget {
  const KhatmatListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final khatmatListValue = ref.watch(khatmaManagerProvider).khatmas;
    final currentFilter = ref.watch(khatmaListFilterProvider);

    return AsyncValueWidget<List<Khatma>>(
      loading: const LoadingListTile(itemCount: 10),
      value: khatmatListValue,
      data: (khatmat) {
        // Apply filter
        final filteredKhatmat = khatmat
            .where((khatma) => currentFilter.matches(khatma.type))
            .toList();

        return khatmat.isEmpty
            ? WelcomeHome()
            : buildKhatmaList(khatmat, filteredKhatmat, context, ref);
      },
    );
  }

  Widget buildKhatmaList(
      List<Khatma> allKhatmat,
      List<Khatma> filteredKhatmat,
      BuildContext context,
      WidgetRef ref) {
    final currentFilter = ref.watch(khatmaListFilterProvider);

    // Count khatmas by type for filter badges
    final personalCount =
        allKhatmat.where((k) => k.type == KhatmaType.personal).length;
    final sharedCount =
        allKhatmat.where((k) => k.type == KhatmaType.shared).length;

    // Auto-switch filter if current filter has no results
    // This prevents showing "No X khatmas" when the other type exists
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (filteredKhatmat.isEmpty && allKhatmat.isNotEmpty) {
        // Current filter is empty but we have khatmas of other type
        if (currentFilter == KhatmaListFilter.personal && sharedCount > 0) {
          // Switch to shared
          ref.read(khatmaListFilterProvider.notifier).state =
              KhatmaListFilter.shared;
        } else if (currentFilter == KhatmaListFilter.shared &&
            personalCount > 0) {
          // Switch to personal
          ref.read(khatmaListFilterProvider.notifier).state =
              KhatmaListFilter.personal;
        } else if (currentFilter == KhatmaListFilter.all &&
            allKhatmat.isEmpty) {
          // This shouldn't happen, but handle it gracefully
          if (personalCount > 0) {
            ref.read(khatmaListFilterProvider.notifier).state =
                KhatmaListFilter.personal;
          } else if (sharedCount > 0) {
            ref.read(khatmaListFilterProvider.notifier).state =
                KhatmaListFilter.shared;
          }
        }
      }
    });

    // Determine if we should show filters (only if there are multiple types)
    final hasMultipleTypes = personalCount > 0 && sharedCount > 0;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header with title and count
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: context.colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${filteredKhatmat.length}',
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

        // Filter chips (only show if there are multiple types)
        if (hasMultipleTypes) ...[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  KhatmaFilterChip(
                    label: 'All',
                    icon: Icons.grid_view_rounded,
                    isSelected: currentFilter == KhatmaListFilter.all,
                    count: allKhatmat.length,
                    onTap: () {
                      ref.read(khatmaListFilterProvider.notifier).state =
                          KhatmaListFilter.all;
                    },
                  ),
                  gapW8,
                  KhatmaFilterChip(
                    label: 'Personal',
                    icon: Icons.person_rounded,
                    isSelected: currentFilter == KhatmaListFilter.personal,
                    count: personalCount,
                    isEnabled: personalCount > 0,
                    onTap: () {
                      ref.read(khatmaListFilterProvider.notifier).state =
                          KhatmaListFilter.personal;
                    },
                  ),
                  gapW8,
                  KhatmaFilterChip(
                    label: 'Shared',
                    icon: Icons.people_rounded,
                    isSelected: currentFilter == KhatmaListFilter.shared,
                    count: sharedCount,
                    isEnabled: sharedCount > 0,
                    onTap: () {
                      ref.read(khatmaListFilterProvider.notifier).state =
                          KhatmaListFilter.shared;
                    },
                  ),
                ],
              ),
            ),
          ),
          gapH16,
        ],

        // List of khatmas
        filteredKhatmat.isEmpty
            ? Padding(
                padding: const EdgeInsets.all(32.0),
                child: Center(
                  child: Column(
                    children: [
                      Icon(
                        Icons.filter_list_off,
                        size: 64,
                        color: context.colorScheme.onSurfaceVariant
                            .withValues(alpha: 0.5),
                      ),
                      gapH16,
                      Text(
                        'No ${currentFilter.getLabel().toLowerCase()} khatmas',
                        style: context.textTheme.titleMedium?.copyWith(
                          color: context.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                shrinkWrap: true,
                primary: false,
                itemCount: filteredKhatmat.length,
                itemBuilder: (_, index) {
                  final khatma = filteredKhatmat[index];
                  return buildCardKhatma(khatma, ref, context);
                },
              ),
        gapH16,
      ],
    );
  }

  Widget buildCardKhatma(Khatma khatma, WidgetRef ref, BuildContext context) {
    bool animate = khatma.startDate != null && DateTime.now().difference(khatma.startDate!).inMinutes == 0;
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
