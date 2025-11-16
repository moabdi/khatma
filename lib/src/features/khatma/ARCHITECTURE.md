# Khatma Feature Architecture

## Overview

This document describes the refactored Khatma feature architecture, which separates data transfer objects (DTOs) from domain models for better separation of concerns.

## Architecture Layers

### 1. Domain Layer (`domain/models/`)
**Clean domain models WITHOUT Freezed** - Pure business logic

#### Sealed Class Hierarchy
```dart
sealed class Khatma { ... }
  ├── PersonalKhatma extends Khatma
  ├── SharedKhatma extends Khatma
  └── HifzKhatma extends Khatma
```

**Benefits:**
- ✅ Type-safe pattern matching
- ✅ Exhaustiveness checking at compile time
- ✅ No external dependencies (no Freezed)
- ✅ Clean, readable business logic
- ✅ Immutable with manual `copyWith` methods

**Files:**
- `khatma.dart` - Main Khatma sealed class hierarchy
- `khatma_enums.dart` - All enums (KhatmaStatus, SplitUnit, etc.)
- `khatma_theme.dart` - Theme model
- `khatma_part.dart` - KhatmaPart for progress tracking
- `completion_history.dart` - Completion history model
- `validation_result.dart` - Validation results

### 2. Data Layer (`data/`)

#### DTOs (`data/model/`)
**WITH Freezed** - For data transfer and serialization

**Files:**
- `khatma_dto.dart` - Freezed DTOs with union types
  - `PersonalKhatmaDto`
  - `SharedKhatmaDto`
  - `HifzKhatmaDto`
- `completion_history_dto.dart` - CompletionHistoryDto with sync metadata

**Features:**
- ✅ JSON serialization (toJson/fromJson)
- ✅ Immutability via Freezed
- ✅ copyWith methods auto-generated
- ✅ Contains sync metadata (lastSync, needsSync)

#### Mappers (`data/mappers/`)
**Bidirectional conversion** between DTOs and Domain models

**Files:**
- `khatma_mappers.dart` - Khatma DTO ↔ Domain mappers
- `completion_history_mappers.dart` - CompletionHistory mappers

**Usage:**
```dart
// DTO → Domain
final PersonalKhatma khatma = dto.toDomain();

// Domain → DTO
final PersonalKhatmaDto dto = khatma.toDto(
  lastSync: DateTime.now(),
  needsSync: false,
);
```

#### Sync Models (`data/sync/`)
**Separate sync-related models** - Not mixed with domain

**Files:**
- `sync_models.dart`
  - `SyncMetadata` - Simple class for sync state
  - `SyncStatus` - Freezed model for sync status
  - `SyncResult` - Freezed model for sync results

### 3. Key Differences

| Aspect | Old Architecture | New Architecture |
|--------|-----------------|------------------|
| Domain Models | With Freezed | WITHOUT Freezed (clean) |
| DTOs | None (models used directly) | Separate with Freezed |
| Sync Properties | Mixed in domain | Separate SyncMetadata |
| Khatma Types | Separate classes | Sealed class hierarchy |
| Type Safety | Manual checks | Pattern matching |

## Usage Examples

### Creating a Personal Khatma (Domain)
```dart
final khatma = PersonalKhatma(
  id: 'khatma-1',
  code: 'K001',
  name: 'My Khatma',
  unit: SplitUnit.juzz,
  createDate: DateTime.now(),
  startDate: DateTime.now(),
  theme: KhatmaTheme(color: '#00A862', icon: 'kaaba.ico'),
  status: KhatmaStatus.active,
  readParts: [],
);
```

### Pattern Matching with Sealed Class
```dart
String getDescription(Khatma khatma) {
  return switch (khatma) {
    PersonalKhatma p => 'Personal: ${p.name} (${p.completionPercent}%)',
    SharedKhatma s => 'Shared: ${s.name} (${s.membersCount} members)',
    HifzKhatma h => 'Hifz: ${h.name} (${h.mode.displayName})',
  };
}
```

### Saving to Repository (using DTOs)
```dart
// Convert domain to DTO for persistence
final dto = khatma.toDto(
  lastSync: DateTime.now(),
  needsSync: false,
);

// Save to Firestore
await repository.save(dto);
```

### Loading from Repository
```dart
// Load DTO from Firestore
final dto = await repository.getById(id);

// Convert to domain model
final khatma = dto.toDomain();

// Use in business logic
if (khatma is PersonalKhatma) {
  print('Completion: ${khatma.completionPercent}%');
}
```

## Migration Guide

### For Repositories
1. Change return types to DTOs
2. Use mappers when converting to/from domain
3. Keep sync metadata in DTOs only

**Before:**
```dart
class KhatmasRepository {
  Future<Khatma> getById(String id) { ... }
}
```

**After:**
```dart
class KhatmasRepository {
  Future<KhatmaDto> getById(String id) { ... }
}
```

### For Providers/Business Logic
1. Import from `domain/domain.dart` (not old domain files)
2. Use domain models (Khatma, PersonalKhatma, etc.)
3. Convert DTOs to domain when receiving from repository
4. Convert domain to DTOs when saving

**Example:**
```dart
class KhatmatProvider {
  Future<void> loadKhatmas() async {
    // Get DTOs from repository
    final dtos = await repository.getAll();

    // Convert to domain models
    final khatmas = dtos.map((dto) => dto.toDomain()).toList();

    // Use domain models in business logic
    state = khatmas;
  }

  Future<void> saveKhatma(PersonalKhatma khatma) async {
    // Convert to DTO for persistence
    final dto = khatma.toDto(needsSync: true);

    // Save via repository
    await repository.save(dto);
  }
}
```

## Next Steps

1. **Run code generation:**
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

2. **Update repositories** to use DTOs for data layer

3. **Update providers** to use domain models for business logic

4. **Update UI** to work with domain models (minimal changes needed)

5. **Test thoroughly** - especially the mappers

## File Structure
```
lib/src/features/khatma/
├── data/
│   ├── model/                    # DTOs with Freezed
│   │   ├── khatma_dto.dart
│   │   └── completion_history_dto.dart
│   ├── mappers/                  # DTO ↔ Domain mappers
│   │   ├── khatma_mappers.dart
│   │   └── completion_history_mappers.dart
│   └── sync/                     # Sync models
│       └── sync_models.dart
├── domain/
│   ├── models/                   # Clean domain models (no Freezed)
│   │   ├── khatma.dart          # Sealed class hierarchy
│   │   ├── khatma_enums.dart
│   │   ├── khatma_theme.dart
│   │   ├── khatma_part.dart
│   │   ├── completion_history.dart
│   │   └── validation_result.dart
│   └── domain.dart              # Export file
└── ARCHITECTURE.md              # This file
```

## Benefits of This Architecture

1. **Clean Separation**: Domain logic separated from data persistence
2. **Type Safety**: Sealed classes provide exhaustive pattern matching
3. **Maintainability**: Easy to add new Khatma types
4. **Testability**: Domain models are pure Dart (no dependencies)
5. **Flexibility**: Can change persistence layer without affecting domain
6. **Immutability**: Both layers are immutable but use different mechanisms
