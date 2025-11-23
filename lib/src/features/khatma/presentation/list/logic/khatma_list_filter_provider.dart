import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khatma/src/features/khatma/domain/khatma_enums.dart';

/// Filter type for khatma list
enum KhatmaListFilter {
  all,
  personal,
  shared,
}

/// Provider for khatma list filter state
/// Default to personal khatmas first
final khatmaListFilterProvider =
    StateProvider<KhatmaListFilter>((ref) => KhatmaListFilter.personal);

/// Extension to check if a KhatmaType matches the current filter
extension KhatmaListFilterExtension on KhatmaListFilter {
  bool matches(KhatmaType type) {
    return switch (this) {
      KhatmaListFilter.all => true,
      KhatmaListFilter.personal => type == KhatmaType.personal,
      KhatmaListFilter.shared => type == KhatmaType.shared,
    };
  }

  String getLabel() {
    return switch (this) {
      KhatmaListFilter.all => 'All',
      KhatmaListFilter.personal => 'Personal',
      KhatmaListFilter.shared => 'Shared',
    };
  }
}
