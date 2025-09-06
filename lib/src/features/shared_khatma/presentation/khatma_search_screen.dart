// lib/src/features/shared_khatma/presentation/khatma_search_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:khatma/src/features/shared_khatma/domain/shared_khatma.dart';
import 'package:khatma/src/features/shared_khatma/application/shared_khatma_provider.dart';
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

  List<SharedKhatma> _filterKhatmas(List<SharedKhatma> khatmas, String query) {
    if (query.isEmpty) return khatmas;

    final lowercaseQuery = query.toLowerCase();
    return khatmas.where((khatma) {
      return khatma.name.toLowerCase().contains(lowercaseQuery) ||
          khatma.description.toLowerCase().contains(lowercaseQuery);
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

  void _navigateToDetails(BuildContext context, SharedKhatma khatma) {
    context.push('/khatma-search-details/${khatma.id}', extra: khatma);
  }
}

class _KhatmaSearchItem extends StatelessWidget {
  final SharedKhatma khatma;
  final VoidCallback onTap;

  const _KhatmaSearchItem({
    required this.khatma,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12.0),
      elevation: 2,
      child: ListTile(
        contentPadding: const EdgeInsets.all(16.0),
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: context.colorScheme.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(50),
          ),
          child: Icon(
            Icons.menu_book,
            color: context.colorScheme.primary,
            size: 28,
          ),
        ),
        title: Text(
          khatma.name,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            gapH4,
            Text(
              khatma.description,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            gapH8,
            Wrap(
              spacing: 8,
              children: [
                _InfoChip(
                  icon: Icons.group,
                  label: '${khatma.membersCount}',
                  context: context,
                ),
                _InfoChip(
                  icon: Icons.book,
                  label: '${khatma.unitsAvailable}/${khatma.totalUnits}',
                  context: context,
                ),
              ],
            ),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: onTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: context.colorScheme.primary,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                minimumSize: const Size(0, 36),
              ),
              child: Text(
                context.loc.khatma_join_button,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        onTap: onTap,
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final BuildContext context;

  const _InfoChip({
    required this.icon,
    required this.label,
    required this.context,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 14,
            color: Theme.of(context).colorScheme.onSecondaryContainer,
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSecondaryContainer,
                  fontWeight: FontWeight.w500,
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
