import 'dart:ui';

import 'package:khatma/src/features/khatma/domain/khatma_domain.dart';
import 'package:khatma/src/features/khatma/domain/khatma_theme.dart';

/// Creator information for creating a new Khatma
class KhatmaCreator {
  final String creatorId;
  final String? creatorName;

  const KhatmaCreator({
    required this.creatorId,
    this.creatorName,
  });
}

/// Unified form data model that works with all Khatma types
/// Uses the original Khatma as a base and only tracks form-editable fields
class KhatmaFormData {
  // Store the original khatma (or null for new khatmas)
  final Khatma? _original;

  // Type for new khatmas (ignored when editing)
  final KhatmaType _type;

  // Only track fields that the form can edit
  final String code;
  final String name;
  final String description;
  final SplitUnit unit;
  final KhatmaTheme theme;
  final bool repeat;
  final DateTime startDate;
  final DateTime? endDate;

  // Optional configurations for creating new khatmas
  final KhatmaCreator? creator;
  final SharedConfig? sharedConfig;
  final HifzConfig? hifzConfig;

  const KhatmaFormData._({
    required Khatma? original,
    required KhatmaType type,
    required this.code,
    required this.name,
    required this.description,
    required this.unit,
    required this.theme,
    required this.repeat,
    required this.startDate,
    this.endDate,
    this.creator,
    this.sharedConfig,
    this.hifzConfig,
  })  : _original = original,
        _type = type;

  /// Create form for a new Khatma
  factory KhatmaFormData.blank({
    required String code,
    KhatmaType type = KhatmaType.personal,
  }) {
    // Provide default creator for shared/hifz khatmas
    // In production, this should come from the authenticated user
    final defaultCreator = KhatmaCreator(
      creatorId: 'local-user', // Placeholder - should be replaced with actual user ID
      creatorName: 'Local User', // Placeholder - should be replaced with actual user name
    );

    return KhatmaFormData._(
      original: null,
      type: type,
      code: code,
      name: '',
      description: '',
      unit: SplitUnit.juzz,
      theme: kDefaultKhatmaTheme,
      repeat: false,
      startDate: DateTime.now(),
      endDate: null,
      creator: defaultCreator,
    );
  }

  /// Load existing Khatma for editing
  factory KhatmaFormData.fromKhatma(Khatma khatma) {
    return KhatmaFormData._(
      original: khatma,
      type: khatma.type,
      code: khatma.code,
      name: khatma.name,
      description: khatma.description ?? '',
      unit: khatma.unit,
      theme: khatma.theme,
      repeat: khatma.repeat,
      startDate: khatma.startDate,
      endDate: khatma.endDate,
    );
  }

  /// Convert to domain Khatma (create new or update existing)
  Khatma toKhatma() {
    if (_original != null) {
      // Editing: use the type's copyWith to preserve all type-specific fields
      return _original!.copyWith(
        code: code,
        name: name,
        description: description,
        unit: unit,
        theme: theme,
        repeat: repeat,
        startDate: startDate,
        endDate: endDate,
      );
    } else {
      // Creating new: use the type to determine which Khatma to create
      final now = DateTime.now();

      return switch (_type) {
        KhatmaType.shared => KhatmaShared(
            code: code,
            name: name,
            description: description,
            unit: unit,
            createDate: now,
            startDate: startDate,
            endDate: endDate,
            theme: theme,
            repeat: repeat,
            creatorId: creator!.creatorId,
            creatorName: creator!.creatorName,
            config: sharedConfig ?? const SharedConfig.defaults(),
            // Initialize with creator as first participant
            participants: [
              Participant(
                userId: creator!.creatorId,
                userName: creator!.creatorName ?? 'Creator',
                joinedDate: now,
                completedUnits: 0,
                role: ParticipantRole.admin,
              ),
            ],
            // Initialize empty units list (will be populated when users reserve)
            units: const [],
          ),
        KhatmaType.hifz => KhatmaHifz(
            code: code,
            name: name,
            description: description,
            unit: unit,
            createDate: now,
            startDate: startDate,
            endDate: endDate,
            theme: theme,
            creatorId: creator?.creatorId,
            creatorName: creator?.creatorName,
            config: hifzConfig ?? const HifzConfig.defaults(),
          ),
        KhatmaType.personal => KhatmaPersonal(
            code: code,
            name: name,
            description: description,
            unit: unit,
            createDate: now,
            startDate: startDate,
            endDate: endDate,
            theme: theme,
            repeat: repeat,
            creatorId: creator?.creatorId,
            creatorName: creator?.creatorName,
          ),
      };
    }
  }

  KhatmaFormData copyWith({
    KhatmaType? type,
    String? code,
    String? name,
    String? description,
    SplitUnit? unit,
    KhatmaTheme? theme,
    bool? repeat,
    DateTime? startDate,
    DateTime? endDate,
    KhatmaCreator? creator,
    SharedConfig? sharedConfig,
    HifzConfig? hifzConfig,
  }) {
    return KhatmaFormData._(
      original: _original,
      // Only allow type change when creating new khatma
      type: _original == null ? (type ?? _type) : _type,
      code: code ?? this.code,
      name: name ?? this.name,
      description: description ?? this.description,
      unit: unit ?? this.unit,
      theme: theme ?? this.theme,
      repeat: repeat ?? this.repeat,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      creator: creator ?? this.creator,
      sharedConfig: sharedConfig ?? this.sharedConfig,
      hifzConfig: hifzConfig ?? this.hifzConfig,
    );
  }

  // Getters that work with both new and existing khatmas
  KhatmaID? get id => _original?.id;
  KhatmaType get type => _original?.type ?? _type;
  KhatmaStatus get status => _original?.status ?? KhatmaStatus.active;
  DateTime get createDate => _original?.createDate ?? DateTime.now();
  int get version => _original?.version ?? 1;

  // Convenience getters
  bool get isRepeat => repeat;
  bool get isStarted =>
      startDate.isBefore(DateTime.now()) ||
      startDate.isAtSameMomentAs(DateTime.now());
  bool get isCompleted => status == KhatmaStatus.completed;
  bool get isActive => status == KhatmaStatus.active;
  bool get isDeleted => status == KhatmaStatus.deleted;
  bool get isEditing => _original != null;

  // Theme accessors (for UI components)
  KhatmaTheme get style => theme;
  Color get color => theme.hexColor;
  String get icon => theme.icon;
  String get variant => theme.variant;
}
