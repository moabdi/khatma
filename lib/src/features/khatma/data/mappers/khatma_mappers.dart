import 'package:khatma/src/features/khatma/data/model/khatma_dto.dart';
import 'package:khatma/src/features/khatma/domain/khatma.dart';
import 'package:khatma/src/features/khatma/domain/khatma_theme.dart';

/// Extension to map DTOs to Domain models
extension KhatmaDtoMapper on KhatmaDto {
  /// Convert DTO to Domain model
  Khatma toDomain() {
    return switch (this) {
      PersonalKhatmaDto dto => KhatmaPersonal(
          id: dto.id,
          code: dto.code,
          name: dto.name,
          description: dto.description,
          unit: _mapSplitUnit(dto.unit),
          createDate: dto.createDate,
          startDate: dto.startDate,
          endDate: dto.endDate,
          theme: _mapTheme(dto.themeColor, dto.themeIcon, dto.themeVariant),
          status: _mapKhatmaStatus(dto.status),
          lastUpdated: dto.lastUpdated,
          lastSync: dto.lastSync,
          needsSync: dto.needsSync,
          completedParts: dto.completedParts?? [],
          repeat: dto.repeat,
          repeats: dto.repeats,
          lastRead: dto.lastRead,
        ),
      SharedKhatmaDto dto => KhatmaShared(
          id: dto.id,
          code: '', // SharedKhatma doesn't have code in DTO
          name: dto.name,
          description: dto.description,
          unit: _mapSplitUnit(dto.unit),
          createDate: dto.createDate,
          startDate: dto.createDate, // Using createDate as startDate
          theme: kDefaultKhatmaTheme, // Shared khatma doesn't have theme
          status: _mapKhatmaStatus(dto.status),
          lastUpdated: dto.lastUpdated,
          lastSync: null, // Shared khatma may not have lastSync in DTO
          needsSync: false,
          creatorId: dto.creatorId,
          creatorName: dto.creatorName,
          config: const SharedConfig.defaults(), // Use default config
          participants: dto.participants.map((p) => p.toDomain()).toList(),
          units: dto.units.map((u) => u.toDomain()).toList(),
        ),
      HifzKhatmaDto dto => KhatmaHifz(
          id: dto.id,
          code: dto.code,
          name: dto.name,
          description: dto.description,
          unit: _mapSplitUnit(dto.unit),
          createDate: dto.createDate,
          startDate: dto.startDate,
          endDate: dto.endDate,
          theme: _mapTheme(dto.themeColor, dto.themeIcon, dto.themeVariant),
          status: _mapKhatmaStatus(dto.status),
          lastUpdated: dto.lastUpdated,
          lastSync: dto.lastSync,
          needsSync: dto.needsSync,
          config: HifzConfig(
            mode: _mapHifzMode(dto.mode),
            dailyGoal: 1, // Default value (DTO doesn't store this yet)
            reviewInterval: RepeatInterval.weekly, // Default value
            reviewIntervalDays: 7, // Default value
          ),
          sections: dto.sections?.map((s) => s.toDomain()).toList() ?? [],
          lastRead: dto.lastRead,
        ),
    };
  }
}

/// Extension to map Domain models to DTOs
extension KhatmaDomainMapper on Khatma {
  /// Convert Domain model to DTO
  KhatmaDto toDto() {
    return switch (this) {
      KhatmaPersonal khatma => PersonalKhatmaDto(
          id: khatma.id,
          code: khatma.code,
          name: khatma.name,
          unit: khatma.unit.name,
          createDate: khatma.createDate,
          startDate: khatma.startDate,
          description: khatma.description,
          repeat: khatma.repeat,
          repeats: khatma.repeats,
          themeColor: khatma.theme.color,
          themeIcon: khatma.theme.icon,
          themeVariant: khatma.theme.variant,
          endDate: khatma.endDate,
          lastRead: khatma.lastRead,
          completedParts: khatma.completedParts,
          lastUpdated: khatma.lastUpdated,
          lastSync: khatma.lastSync,
          needsSync: khatma.needsSync,
          status: khatma.status.name,
        ),
      KhatmaShared khatma => SharedKhatmaDto(
          id: khatma.id,
          name: khatma.name,
          description: khatma.description ?? '',
          unit: khatma.unit.name,
          createDate: khatma.createDate,
          creatorId: khatma.creatorId!,
          creatorName: khatma.creatorName,
          participants: khatma.participants.map((p) => p.toDto()).toList(),
          units: khatma.units.map((u) => u.toDto()).toList(),
          lastUpdated: khatma.lastUpdated,
          status: khatma.status.name,
          
        ),
      KhatmaHifz khatma => HifzKhatmaDto(
          id: khatma.id,
          code: khatma.code,
          name: khatma.name,
          unit: khatma.unit.name,
          createDate: khatma.createDate,
          startDate: khatma.startDate,
          description: khatma.description,
          themeColor: khatma.theme.color,
          themeIcon: khatma.theme.icon,
          themeVariant: khatma.theme.variant,
          endDate: khatma.endDate,
          lastRead: khatma.lastRead,
          sections: khatma.sections.map((s) => s.toDto()).toList(),
          mode: khatma.mode.name,
          lastUpdated: khatma.lastUpdated,
          lastSync: khatma.lastSync,
          needsSync: khatma.needsSync,
          status: khatma.status.name,
        ),
    };
  }
}

/// SharedKhatmaParticipant mappers
extension ParticipantDtoMapper on ParticipantDto {
  Participant toDomain() {
    return Participant(
      userId: userId,
      userName: userName,
      userPhotoUrl: userPhotoUrl,
      joinedDate: joinedDate,
      completedUnits: completedUnits,
      role: _mapParticipantRole(role),
    );
  }
}

extension ParticipantDomainMapper on Participant {
  ParticipantDto toDto() {
    return ParticipantDto(
      userId: userId,
      userName: userName,
      userPhotoUrl: userPhotoUrl,
      joinedDate: joinedDate,
      completedUnits: completedUnits,
      role: role.name,
    );
  }
}

/// SharedKhatmaUnit mappers
extension UnitDtoMapper on UnitDto {
  Unit toDomain() {
    return Unit(
      number: number,
      status: _mapUnitStatus(status),
      reservedBy: reservedBy,
      reservedByName: reservedByName,
      reservedDate: reservedDate,
      completedDate: completedDate,
      completedBy: completedBy,
      completedByName: completedByName,
      lastReminderSent: lastReminderSent,
      reminderCount: reminderCount,
    );
  }
}

extension UnitDomainMapper on Unit {
  

  UnitDto toDto() {
    return UnitDto(
      number: number,
      status: status.name,
      reservedBy: reservedBy,
      reservedByName: reservedByName,
      reservedDate: reservedDate,
      completedDate: completedDate,
      completedBy: completedBy,
      completedByName: completedByName,
      lastReminderSent: lastReminderSent,
      reminderCount: reminderCount,
    );
  }
}

/// HifzSection mappers
extension HifzSectionDtoMapper on HifzSectionDto {
  Section toDomain() {
    return Section(
      id: id,
      startVerse: startVerse,
      endVerse: endVerse,
      surah: surah,
      status: _mapHifzStatus(status),
      startDate: startDate,
      masteredDate: masteredDate,
      lastReviewDate: lastReviewDate,
      reviewCount: reviewCount,
      mistakeCount: mistakeCount,
    );
  }
}

extension HifzSectionDomainMapper on Section {
  HifzSectionDto toDto() {
    return HifzSectionDto(
      id: id,
      startVerse: startVerse,
      endVerse: endVerse,
      surah: surah,
      status: status.name,
      startDate: startDate,
      masteredDate: masteredDate,
      lastReviewDate: lastReviewDate,
      reviewCount: reviewCount,
      mistakeCount: mistakeCount,
    );
  }
}

// Helper functions for mapping enums and values
SplitUnit _mapSplitUnit(String unit) {
  return SplitUnit.values.firstWhere(
    (e) => e.name == unit,
    orElse: () => SplitUnit.juzz,
  );
}

KhatmaStatus _mapKhatmaStatus(String status) {
  return KhatmaStatus.values.firstWhere(
    (e) => e.name == status,
    orElse: () => KhatmaStatus.active,
  );
}

ParticipantRole _mapParticipantRole(String role) {
  return ParticipantRole.values.firstWhere(
    (e) => e.name == role,
    orElse: () => ParticipantRole.member,
  );
}

UnitStatus _mapUnitStatus(String status) {
  return UnitStatus.values.firstWhere(
    (e) => e.name == status,
    orElse: () => UnitStatus.free,
  );
}

HifzMode _mapHifzMode(String mode) {
  return HifzMode.values.firstWhere(
    (e) => e.name == mode,
    orElse: () => HifzMode.memorization,
  );
}

HifzStatus _mapHifzStatus(String status) {
  return HifzStatus.values.firstWhere(
    (e) => e.name == status,
    orElse: () => HifzStatus.notStarted,
  );
}

KhatmaTheme _mapTheme(String? color, String? icon, String variant) {
  return KhatmaTheme(
    color: color ?? kDefaultKhatmaTheme.color,
    icon: icon ?? kDefaultKhatmaTheme.icon,
    variant: variant,
  );
}
