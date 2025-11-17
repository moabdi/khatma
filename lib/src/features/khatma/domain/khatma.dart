import 'dart:ui';

import 'package:khatma/src/features/khatma/domain/khatma_enums.dart';
import 'package:khatma/src/features/khatma/domain/khatma_theme.dart';
import 'package:khatma/src/features/khatma/domain/khatma_exceptions.dart';
export 'package:khatma/src/features/khatma/domain/khatma_enums.dart';

part 'khatma_base.dart';
part 'khatma_personal.dart';
part 'khatma_shared.dart';
part 'khatma_hifz.dart';

typedef KhatmaID = String;

// ============================================================================
// BASE KHATMA (SEALED CLASS)
// ============================================================================

sealed class Khatma {
  final KhatmaID? id;
  final KhatmaType type;
  final String code;
  final String name;
  final String? description;
  final SplitUnit unit;
  final DateTime createDate;
  final DateTime startDate;
  final DateTime? endDate;
  final KhatmaTheme theme;
  final KhatmaStatus status;
  final DateTime? lastUpdated;
  final DateTime? lastSync;
  final bool needsSync;
  final String? createdBy;
  final String? updatedBy;
  final bool repeat;
  final int repeats;
  final int version;
  final double progress;

  const Khatma({
    this.id,
    required this.type,
    required this.code,
    required this.name,
    this.description,
    required this.unit,
    required this.createDate,
    required this.startDate,
    this.endDate,
    required this.theme,
    required this.status,
    this.lastUpdated,
    this.lastSync,
    this.needsSync = false,
    this.createdBy,
    this.updatedBy,
    this.repeat = false,
    this.repeats = 0,
    this.version = 1,
    this.progress = 0.0,
  });

  bool get isRepeat => repeat;
  bool get isStarted => startDate.isBefore(DateTime.now()) || startDate.isAtSameMomentAs(DateTime.now());
  bool get isCompleted => status == KhatmaStatus.completed;
  bool get isActive => status == KhatmaStatus.active;
  bool get isDeleted => status == KhatmaStatus.deleted;

  bool get isPersonal => type == KhatmaType.personal;
  bool get isShared => type == KhatmaType.shared;
  bool get isHifz => type == KhatmaType.hifz;

  KhatmaTheme get effectiveTheme => theme;

  // Domain invariant checks
  void assertNotCompleted() {
    if (isCompleted) {
      throw const KhatmaCompletedException('Cannot modify a completed khatma');
    }
  }

  void assertNotDeleted() {
    if (isDeleted) {
      throw const KhatmaDeletedException('Cannot perform operations on a deleted khatma');
    }
  }

  void assertActive() {
    assertNotCompleted();
    assertNotDeleted();
  }

  // Parent copyWith method for all common Khatma fields
  Khatma copyWith({
    KhatmaID? id,
    String? code,
    String? name,
    String? description,
    SplitUnit? unit,
    DateTime? createDate,
    DateTime? startDate,
    DateTime? endDate,
    KhatmaTheme? theme,
    KhatmaStatus? status,
    DateTime? lastUpdated,
    DateTime? lastSync,
    bool? needsSync,
    String? createdBy,
    String? updatedBy,
    bool? repeat,
    int? repeats,
    int? version,
  }) {
    return switch (this) {
      KhatmaPersonal k => k.copyWith(
          id: id,
          code: code,
          name: name,
          description: description,
          unit: unit,
          createDate: createDate,
          startDate: startDate,
          endDate: endDate,
          theme: theme,
          status: status,
          lastUpdated: lastUpdated,
          lastSync: lastSync,
          needsSync: needsSync,
          createdBy: createdBy,
          updatedBy: updatedBy,
          repeat: repeat,
          repeats: repeats,
          version: version,
        ),
      KhatmaShared k => k.copyWith(
          id: id,
          code: code,
          name: name,
          description: description,
          unit: unit,
          createDate: createDate,
          startDate: startDate,
          endDate: endDate,
          theme: theme,
          status: status,
          lastUpdated: lastUpdated,
          lastSync: lastSync,
          needsSync: needsSync,
          createdBy: createdBy,
          updatedBy: updatedBy,
          repeat: repeat,
          repeats: repeats,
          version: version,
        ),
      KhatmaHifz k => k.copyWith(
          id: id,
          code: code,
          name: name,
          description: description,
          unit: unit,
          createDate: createDate,
          startDate: startDate,
          endDate: endDate,
          theme: theme,
          status: status,
          lastUpdated: lastUpdated,
          lastSync: lastSync,
          needsSync: needsSync,
          createdBy: createdBy,
          updatedBy: updatedBy,
          version: version,
        ),
      KhatmaBase k => k.copyWith(
          id: id,
          code: code,
          name: name,
          description: description,
          unit: unit,
          createDate: createDate,
          startDate: startDate,
          endDate: endDate,
          theme: theme,
          status: status,
          lastUpdated: lastUpdated,
          lastSync: lastSync,
          needsSync: needsSync,
          createdBy: createdBy,
          updatedBy: updatedBy,
          repeat: repeat,
          repeats: repeats,
          version: version,
        ),
    };
  }

  // Domain method to increment version
  Khatma bumpVersion(String userId) {
    return copyWith(
      version: version + 1,
      updatedBy: userId,
      lastUpdated: DateTime.now(),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Khatma &&
        other.id == id &&
        other.type == type &&
        other.code == code;
  }

  @override
  int get hashCode => Object.hash(id, type, code);

  double get completionPercent {
    return switch (this) {
      KhatmaPersonal k => k.completionPercent,
      KhatmaShared k => k.completionPercent,
      KhatmaHifz k => k.completionPercent,
      KhatmaBase _ => 0.0,
    };
  }


}


extension KhatmaThemeExtensions on Khatma {
  Color get color => theme.hexColor;
  String get icon => theme.icon;
  String get variant => theme.variant;
  KhatmaTheme get style => theme;
}