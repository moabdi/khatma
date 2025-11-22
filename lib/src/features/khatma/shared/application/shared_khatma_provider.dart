import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khatma/src/features/authentication/data/auth_repository.dart';
import 'package:khatma/src/features/khatma/data/repository/remote/khatmas_repository.dart';
import 'package:khatma/src/features/khatma/domain/khatma_domain.dart';
import 'package:khatma/src/features/khatma/domain/khatma.dart';
import 'package:khatma/src/features/khatma/shared/application/khatma_shared_mocks.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'shared_khatma_provider.g.dart';

@riverpod
class SharedKhatmas extends _$SharedKhatmas {
  @override
  List<KhatmaShared> build() {
    // Initialize with mock data
    return KhatmaSharedMockData.getMockKhatmas();
  }

  void searchKhatmas(String query) {
    final allKhatmas = KhatmaSharedMockData.getMockKhatmas();

    if (query.isEmpty) {
      state = allKhatmas;
      return;
    }

    final filteredKhatmas = allKhatmas.where((khatma) {
      final lowercaseQuery = query.toLowerCase();
      return khatma.name.toLowerCase().contains(lowercaseQuery) ||
          khatma.description?.toLowerCase().contains(lowercaseQuery) == true;
    }).toList();

    state = filteredKhatmas;
  }

  void resetSearch() {
    state = KhatmaSharedMockData.getMockKhatmas();
  }

  KhatmaShared? getKhatmaById(String id) {
    try {
      return state.firstWhere((khatma) => khatma.id == id);
    } catch (e) {
      return null;
    }
  }

  Future<void> joinKhatma(String khatmaId, List<int> reservedUnits) async {
    // Get current user info
    final authRepository = ref.read(authRepositoryProvider);
    final currentUser = authRepository.currentUser;

    if (currentUser == null) {
      throw Exception('User must be authenticated to join a khatma');
    }

    // Find the khatma to update
    final khatma = state.firstWhere((k) => k.id == khatmaId);

    // Get current user's display name
    final userName = currentUser.displayName ?? currentUser.email ?? 'User';
    final userId = currentUser.uid;

    // Update units with reservations
    final updatedUnits = [...khatma.units];

    // Reserve selected units
    for (final unitNumber in reservedUnits) {
      final existingUnitIndex = updatedUnits.indexWhere((u) => u.number == unitNumber);

      if (existingUnitIndex != -1) {
        // Update existing unit
        updatedUnits[existingUnitIndex] = updatedUnits[existingUnitIndex].copyWith(
          status: UnitStatus.reserved,
          reservedBy: userId,
          reservedByName: userName,
          reservedDate: DateTime.now(),
        );
      } else {
        // Add new unit
        updatedUnits.add(Unit(
          number: unitNumber,
          status: UnitStatus.reserved,
          reservedBy: userId,
          reservedByName: userName,
          reservedDate: DateTime.now(),
        ));
      }
    }

    // Add current user to participants if not already present
    final updatedParticipants = [...khatma.participants];
    if (!updatedParticipants.any((p) => p.userId == userId)) {
      updatedParticipants.add(Participant(
        userId: userId,
        userName: userName,
        joinedDate: DateTime.now(),
      ));
    }

    // Create updated khatma
    final updatedKhatma = khatma.copyWith(
      units: updatedUnits,
      participants: updatedParticipants,
      lastUpdated: DateTime.now(),
    );

    // Save to Firebase
    final khatmasRepository = ref.read(khatmasRepositoryProvider);
    await khatmasRepository.update(userId, updatedKhatma);

    // Update local state
    state = state.map((k) {
      if (k.id == khatmaId) {
        return updatedKhatma;
      }
      return k;
    }).toList();
  }

  void reserveUnit(String khatmaId, int unitNumber) {
    state = state.map((khatma) {
      if (khatma.id == khatmaId) {
        final updatedUnits = khatma.units.map((unit) {
          if (unit.number == unitNumber && unit.isFree) {
            return unit.copyWith(
              status: UnitStatus.reserved,
              reservedBy: 'currentUser',
              reservedByName: 'You',
              reservedDate: DateTime.now(),
            );
          }
          return unit;
        }).toList();

        // Add unit if it doesn't exist
        if (!updatedUnits.any((u) => u.number == unitNumber)) {
          updatedUnits.add(Unit(
            number: unitNumber,
            status: UnitStatus.reserved,
            reservedBy: 'currentUser',
            reservedByName: 'You',
            reservedDate: DateTime.now(),
          ));
        }

        return khatma.copyWith(units: updatedUnits);
      }
      return khatma;
    }).toList();
  }

  void unreserveUnit(String khatmaId, int unitNumber) {
    state = state.map((khatma) {
      if (khatma.id == khatmaId) {
        final updatedUnits = khatma.units.map((unit) {
          if (unit.number == unitNumber && unit.isReserved) {
            return unit.copyWith(
              status: UnitStatus.free,
              reservedBy: null,
              reservedByName: null,
              reservedDate: null,
            );
          }
          return unit;
        }).toList();

        return khatma.copyWith(units: updatedUnits);
      }
      return khatma;
    }).toList();
  }
}

// Provider for searching khatmas
@riverpod
class KhatmaSearch extends _$KhatmaSearch {
  @override
  String build() {
    return '';
  }

  void updateQuery(String query) {
    state = query;
    ref.read(sharedKhatmasProvider.notifier).searchKhatmas(query);
  }

  void clearSearch() {
    state = '';
    ref.read(sharedKhatmasProvider.notifier).resetSearch();
  }
}

// Provider for getting a specific khatma by ID
@riverpod
KhatmaShared? khatmaById(Ref ref, String id) {
  final khatmas = ref.watch(sharedKhatmasProvider);
  try {
    return khatmas.firstWhere((khatma) => khatma.id == id);
  } catch (e) {
    return null;
  }
}

// Provider for managing khatma joining state
@riverpod
class KhatmaJoining extends _$KhatmaJoining {
  @override
  bool build() {
    return false;
  }

  Future<void> joinKhatma(String khatmaId, List<int> reservedUnits) async {
    state = true;
    try {
      await ref
          .read(sharedKhatmasProvider.notifier)
          .joinKhatma(khatmaId, reservedUnits);
    } finally {
      state = false;
    }
  }
}

// Provider for tracking reserved units for current user
@riverpod
List<Unit> userReservedUnits(
    Ref ref, String khatmaId) {
  final khatma = ref.watch(khatmaByIdProvider(khatmaId));
  if (khatma == null) return [];

  return khatma.units.where((unit) => unit.isReserved).toList();
}
