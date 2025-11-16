/// Enums for Khatma domain models (without Freezed - clean domain)

/// Type of Khatma
enum KhatmaType {
  personal,
  shared,
  hifz;
}

/// Status of a Khatma
enum KhatmaStatus {
  active,
  completed,
  deleted;
}

/// Status of a KhatmaPart
enum KhatmaPartStatus {
  notStarted,
  reserved,
  inProgress,
  completed,
  overdue;
}

/// Units for splitting the Quran
enum SplitUnit {
  juzz(30),
  hizb(60);

  const SplitUnit(this.count);
  final int count;
}

/// Status of shared Khatma
enum SharedKhatmaStatus {
  active,
  completed,
  archived,
  deleted;
}

/// Role of participant in shared Khatma
enum ParticipantRole {
  member,
  moderator,
  admin;
}

/// Status of a unit in shared Khatma
enum UnitStatus {
  free,
  reserved,
  selected,
  completed;
}

/// Hifz mode
enum HifzMode {
  memorization,
  review,
  both;
}

/// Hifz section status
enum HifzStatus {
  notStarted,
  memorizing,
  reviewing,
  mastered;
}

/// Share visibility
enum ShareVisibility {
  private,
  group,
  public;
}

/// Repeat interval
enum RepeatInterval {
  auto,
  daily,
  weekly,
  monthly;
}

/// Time periods
enum TimePeriods {
  day,
  week,
  month,
  year;
}

/// Completion mode
enum CompletionMode {
  auto,
  manual;
}
