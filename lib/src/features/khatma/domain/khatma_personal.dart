part of 'khatma.dart';

class KhatmaPersonal extends Khatma {
  final List<int> completedParts;
  final DateTime? lastRead;

  const KhatmaPersonal({
    super.id,
    required super.code,
    required super.name,
    super.description,
    required super.unit,
    required super.createDate,
    required super.startDate,
    super.endDate,
    required super.theme,
    super.status = KhatmaStatus.active,
    super.lastUpdated,
    super.lastSync,
    super.needsSync = false,
    super.creatorId,
    super.creatorName,
    super.updatedBy,
    super.repeat = false,
    super.repeats = 0,
    super.progress = 0.0,
    super.version = 1,
    this.completedParts = const [],
    this.lastRead,
  }) : super(type: KhatmaType.personal);

  // Computed properties
  double get completionPercent {
    if (completedParts.isEmpty) return 0.0;
    final uniqueCompleted = completedParts.toSet().length;
    return (uniqueCompleted / unit.count).clamp(0.0, 1.0);
  }

  Duration get duration {
    final baseDate = lastRead ?? createDate;
    return DateTime.now().difference(baseDate);
  }

  List<int> get completedPartIds => completedParts.toSet().toList();

  List<int> get remainingPartIds {
    final allParts = List.generate(unit.count, (index) => index + 1);
    final completed = completedParts.toSet();
    return allParts.where((part) => !completed.contains(part)).toList();
  }

  int get remainingPartsCount => remainingPartIds.length;

  // Helper method for updating reading progress with domain validation
  KhatmaPersonal addCompletedParts(List<int> partIds) {
    // Domain invariant: Cannot modify completed or deleted khatma
    assertActive();

    // Validate part numbers
    for (final partId in partIds) {
      if (partId < 1 || partId > unit.count) {
        throw InvalidPartNumberException(partId, unit.count);
      }
    }

    final alreadyCompleted = completedParts.toSet();
    final duplicates = partIds.where((id) => alreadyCompleted.contains(id)).toList();
    if (duplicates.isNotEmpty) {
      throw DuplicatePartException(duplicates);
    }

    final now = DateTime.now();
    final updatedCompletedParts = [...completedParts, ...partIds];

    final updated = copyWith(
      completedParts: updatedCompletedParts,
      lastRead: now,
      lastUpdated: now,
      needsSync: true,
    );

    // Auto-complete if all parts are done
    if (updated.completionPercent >= 1.0 && status == KhatmaStatus.active) {
      return updated.copyWith(
        endDate: now,
        status: KhatmaStatus.completed,
      );
    }

    return updated;
  }

  KhatmaPersonal copyWith({
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
    String? creatorId,
    String? creatorName,
    String? updatedBy,
    bool? repeat,
    int? repeats,
    double? progress,
    int? version,
    List<int>? completedParts,
    DateTime? lastRead,
  }) {
    return KhatmaPersonal(
      id: id ?? this.id,
      code: code ?? this.code,
      name: name ?? this.name,
      description: description ?? this.description,
      unit: unit ?? this.unit,
      createDate: createDate ?? this.createDate,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      theme: theme ?? this.theme,
      status: status ?? this.status,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      lastSync: lastSync ?? this.lastSync,
      needsSync: needsSync ?? this.needsSync,
      creatorId: creatorId ?? this.creatorId,
      creatorName: creatorName ?? this.creatorName,
      updatedBy: updatedBy ?? this.updatedBy,
      version: version ?? this.version,
      completedParts: completedParts ?? this.completedParts,
      repeat: repeat ?? this.repeat,
      repeats: repeats ?? this.repeats,
      lastRead: lastRead ?? this.lastRead,
      progress: progress ?? this.progress,
    );
  }
}
