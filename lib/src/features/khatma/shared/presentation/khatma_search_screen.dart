// lib/src/features/shared_khatma/presentation/khatma_search_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:khatma/src/features/khatma/domain/khatma.dart';
import 'package:khatma/src/features/khatma/shared/application/shared_khatma_provider.dart';
import 'package:khatma/src/i18n/app_localizations_context.dart';
import 'package:khatma/src/i18n/generated/app_localizations.dart';
import 'package:khatma/src/themes/theme.dart';
import 'package:khatma_ui/constants/app_sizes.dart';

class KhatmaSearchScreen extends ConsumerStatefulWidget {
  const KhatmaSearchScreen({super.key});

  @override
  ConsumerState<KhatmaSearchScreen> createState() => _KhatmaSearchScreenState();
}

class _KhatmaSearchScreenState extends ConsumerState<KhatmaSearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sharedKhatmas = ref.watch(sharedKhatmasProvider);
    final filteredKhatmas = _filterKhatmas(sharedKhatmas, _searchQuery);

    return Scaffold(
      appBar: AppBar(
        title: Text(context.loc.khatma_search_title),
        backgroundColor: Theme.of(context).colorScheme.surface,
        foregroundColor: Theme.of(context).colorScheme.onSurface,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Search TextField
            Container(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: context.loc.khatma_search_hint,
                  prefixIcon: Icon(
                    Icons.search,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  suffixIcon: _searchQuery.isNotEmpty
                      ? IconButton(
                          onPressed: () {
                            setState(() {
                              _searchController.clear();
                              _searchQuery = '';
                            });
                          },
                          icon: Icon(
                            Icons.clear,
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                        )
                      : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  filled: true,
                  fillColor:
                      Theme.of(context).colorScheme.surfaceContainerHighest,
                ),
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
              ),
            ),

            // Search Results
            Expanded(
              child: filteredKhatmas.isEmpty
                  ? _buildEmptyState(context)
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      itemCount: filteredKhatmas.length,
                      itemBuilder: (context, index) {
                        final khatma = filteredKhatmas[index];
                        return _KhatmaSearchItem(
                          khatma: khatma,
                          onTap: () => _navigateToDetails(context, khatma),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  List<KhatmaShared> _filterKhatmas(List<KhatmaShared> khatmas, String query) {
    if (query.isEmpty) return khatmas;

    final lowercaseQuery = query.toLowerCase();
    return khatmas.where((khatma) {
      return khatma.name.toLowerCase().contains(lowercaseQuery) ||
          (khatma.description?.toLowerCase().contains(lowercaseQuery) ?? false);
    }).toList();
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 64,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          gapH16,
          Text(
            _searchQuery.isEmpty
                ? context.loc.khatma_search_empty_default
                : context.loc.khatma_search_no_results,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  void _navigateToDetails(BuildContext context, KhatmaShared khatma) {
    context.push('/khatma-search-details/${khatma.id}', extra: khatma);
  }
}

class _KhatmaSearchItem extends StatelessWidget {
  final KhatmaShared khatma;
  final VoidCallback onTap;

  const _KhatmaSearchItem({
    required this.khatma,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final completionPercent = khatma.completionPercent;

    return Card(
      margin: const EdgeInsets.only(bottom: 12.0),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: Theme.of(context).colorScheme.outlineVariant.withValues(alpha: 0.5),
          width: 1,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Row - Icon with circular progress and Name/Creator
              Row(
                children: [
                  // Icon with circular progress (ready for custom color/icon)
                  SizedBox(
                    width: 48,
                    height: 48,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Circular progress indicator
                        SizedBox(
                          width: 48,
                          height: 48,
                          child: CircularProgressIndicator(
                            value: completionPercent.clamp(0.0, 1.0),
                            strokeWidth: 3,
                            // TODO: Use khatma.color when available
                            backgroundColor: context.colorScheme.primary.withValues(alpha: 0.15),
                            valueColor: AlwaysStoppedAnimation<Color>(
                              context.colorScheme.primary,
                            ),
                            strokeCap: StrokeCap.round,
                          ),
                        ),
                        // Icon (ready for custom icon per khatma)
                        Icon(
                          // TODO: Use khatma.icon when available
                          Icons.menu_book_rounded,
                          color: context.colorScheme.primary,
                          size: 22,
                        ),
                      ],
                    ),
                  ),
                  gapW12,
                  // Name and Creator
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          khatma.name,
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        if (khatma.creatorName != null) ...[
                          const SizedBox(height: 2),
                          Text(
                            khatma.creatorName!,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurfaceVariant,
                                  fontSize: 11,
                                ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),

              // Description
              if (khatma.description?.isNotEmpty ?? false) ...[
                gapH8,
                Text(
                  khatma.description ?? '',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                        height: 1.3,
                      ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],

              gapH12,

              // Bottom Row - Stats chips and Join button
              Row(
                children: [
                  _CompactChip(
                    icon: Icons.people_rounded,
                    label: '${khatma.membersCount}',
                  ),
                  gapW8,
                  _CompactChip(
                    icon: Icons.check_circle_outline_rounded,
                    label: '${khatma.unitsAvailable} libres',
                  ),
                  const Spacer(),
                  // Join Button
                  FilledButton.tonal(
                    onPressed: onTap,
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      minimumSize: const Size(0, 32),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      context.loc.khatma_join_button,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CompactChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _CompactChip({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 14,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.w500,
                  fontSize: 11,
                ),
          ),
        ],
      ),
    );
  }
}

// Extension for missing localization strings (you should add these to your .arb files)
extension KhatmaSearchLocalizations on AppLocalizations {
  String get khatma_search_title => 'Rechercher une Khatma';
  String get khatma_search_hint => 'Nom ou description';
  String get khatma_join_button => 'Rejoindre';
  String get khatma_search_empty_default =>
      'Découvrez les Khatmas publiques disponibles';
  String get khatma_search_no_results =>
      'Aucune Khatma trouvée pour votre recherche';
}
