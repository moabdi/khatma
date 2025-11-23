part of 'khatma.dart';

// ============================================================================
// HIFZ KHATMA - CONFIGURATION
// ============================================================================

/// Configuration for Hifz-specific settings
class HifzConfig {
  final HifzMode mode;
  final int dailyGoal;
  final DateTime? targetCompletionDate;
  final RepeatInterval reviewInterval;
  final int reviewIntervalDays;

  const HifzConfig({
    required this.mode,
    required this.dailyGoal,
    this.targetCompletionDate,
    required this.reviewInterval,
    required this.reviewIntervalDays,
  });

  const HifzConfig.defaults()
      : mode = HifzMode.memorization,
        dailyGoal = 1,
        targetCompletionDate = null,
        reviewInterval = RepeatInterval.weekly,
        reviewIntervalDays = 7;

  HifzConfig copyWith({
    HifzMode? mode,
    int? dailyGoal,
    DateTime? targetCompletionDate,
    RepeatInterval? reviewInterval,
    int? reviewIntervalDays,
  }) {
    return HifzConfig(
      mode: mode ?? this.mode,
      dailyGoal: dailyGoal ?? this.dailyGoal,
      targetCompletionDate: targetCompletionDate ?? this.targetCompletionDate,
      reviewInterval: reviewInterval ?? this.reviewInterval,
      reviewIntervalDays: reviewIntervalDays ?? this.reviewIntervalDays,
    );
  }
}

// ============================================================================
// HIFZ KHATMA - DOMAIN MODEL
// ============================================================================

/// Hifz Khatma - Quran memorization tracking
class KhatmaHifz extends Khatma {
  final HifzConfig config;
  final List<Section> sections;
  final DateTime? lastRead;

  const KhatmaHifz({
    super.id,
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
    this.config = const HifzConfig.defaults(),
    this.sections = const [],
    this.lastRead,
  }) : super(type: KhatmaType.hifz);

  // Convenience getters for config fields
  HifzMode get mode => config.mode;
  int get dailyGoal => config.dailyGoal;
  DateTime? get targetCompletionDate => config.targetCompletionDate;
  RepeatInterval get reviewInterval => config.reviewInterval;
  int get reviewIntervalDays => config.reviewIntervalDays;

  // Computed properties
  double get completionPercent {
    if (sections.isEmpty) return 0.0;
    final masteredCount =
        sections.where((s) => s.status == HifzStatus.mastered).length;
    return (masteredCount / sections.length).clamp(0.0, 1.0);
  }

  int get sectionsMemorized =>
      sections.where((s) => s.status == HifzStatus.memorizing).length;

  int get sectionsReviewing =>
      sections.where((s) => s.status == HifzStatus.reviewing).length;

  int get sectionsMastered =>
      sections.where((s) => s.status == HifzStatus.mastered).length;

  List<Section> get sectionsDueForReview {
    if (reviewIntervalDays <= 0) return [];
    final now = DateTime.now();
    return sections.where((section) {
      if (section.lastReviewDate == null) return false;
      final daysSinceReview = now.difference(section.lastReviewDate!).inDays;
      return daysSinceReview >= reviewIntervalDays;
    }).toList();
  }

  List<Section> get weakSections {
    return sections.where((section) => section.isWeak).toList();
  }

  List<Section> get strongSections {
    return sections.where((section) => section.isStrong).toList();
  }

  double get averageConfidence {
    if (sections.isEmpty) return 0.0;
    final totalConfidence = sections.fold<double>(
      0.0,
      (sum, section) => sum + section.confidenceLevel,
    );
    return totalConfidence / sections.length;
  }

  bool get isOnTrack {
    if (targetCompletionDate == null) return true;
    if (sections.isEmpty) return true;

    final now = DateTime.now();
    final daysRemaining = targetCompletionDate!.difference(now).inDays;
    if (daysRemaining <= 0) return false;

    final sectionsRemaining = sections.length - sectionsMastered;
    final requiredDailyPace = sectionsRemaining / daysRemaining;

    return requiredDailyPace <= dailyGoal;
  }

  KhatmaHifz copyWith({
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
    HifzConfig? config,
    List<Section>? sections,
    DateTime? lastRead,
  }) {
    return KhatmaHifz(
      id: id ?? this.id,
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
      repeat: repeat ?? this.repeat,
      repeats: repeats ?? this.repeats,
      progress: progress ?? this.progress,
      version: version ?? this.version,
      config: config ?? this.config,
      sections: sections ?? this.sections,
      lastRead: lastRead ?? this.lastRead,
    );
  }
}

// ============================================================================
// HIFZ KHATMA - VALUE OBJECTS
// ============================================================================

/// Section for hifz (memorization) tracking
class Section {
  final int id;
  final int startVerse;
  final int endVerse;
  final int surah;
  final HifzStatus status;
  final DateTime? startDate;
  final DateTime? masteredDate;
  final DateTime? lastReviewDate;
  final DateTime? nextReviewDate;
  final int reviewCount;
  final int mistakeCount;
  final int consecutiveSuccessfulReviews;
  final double confidenceLevel;

  const Section({
    required this.id,
    required this.startVerse,
    required this.endVerse,
    required this.surah,
    this.status = HifzStatus.notStarted,
    this.startDate,
    this.masteredDate,
    this.lastReviewDate,
    this.nextReviewDate,
    this.reviewCount = 0,
    this.mistakeCount = 0,
    this.consecutiveSuccessfulReviews = 0,
    this.confidenceLevel = 0.0,
  });

  bool get needsReview {
    if (nextReviewDate == null) return false;
    return DateTime.now().isAfter(nextReviewDate!);
  }

  bool get isStrong => confidenceLevel >= 0.8 && consecutiveSuccessfulReviews >= 3;
  bool get isWeak => confidenceLevel < 0.5 || mistakeCount > reviewCount * 0.3;

  Duration? get timeSinceLastReview {
    if (lastReviewDate == null) return null;
    return DateTime.now().difference(lastReviewDate!);
  }

  Section copyWith({
    int? id,
    int? startVerse,
    int? endVerse,
    int? surah,
    HifzStatus? status,
    DateTime? startDate,
    DateTime? masteredDate,
    DateTime? lastReviewDate,
    DateTime? nextReviewDate,
    int? reviewCount,
    int? mistakeCount,
    int? consecutiveSuccessfulReviews,
    double? confidenceLevel,
  }) {
    return Section(
      id: id ?? this.id,
      startVerse: startVerse ?? this.startVerse,
      endVerse: endVerse ?? this.endVerse,
      surah: surah ?? this.surah,
      status: status ?? this.status,
      startDate: startDate ?? this.startDate,
      masteredDate: masteredDate ?? this.masteredDate,
      lastReviewDate: lastReviewDate ?? this.lastReviewDate,
      nextReviewDate: nextReviewDate ?? this.nextReviewDate,
      reviewCount: reviewCount ?? this.reviewCount,
      mistakeCount: mistakeCount ?? this.mistakeCount,
      consecutiveSuccessfulReviews:
          consecutiveSuccessfulReviews ?? this.consecutiveSuccessfulReviews,
      confidenceLevel: confidenceLevel ?? this.confidenceLevel,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Section && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
