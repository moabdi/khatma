import 'package:khatma/src/features/khatma/domain/khatma.dart';

class KhatmaHistory {
  final String? id;
  final KhatmaID? khatmaId;
  final DateTime startDate;
  final DateTime endDate;
  final CompletionMode mode;
  final String? completion;

  const KhatmaHistory({
    this.id,
    this.khatmaId,
    required this.startDate,
    required this.endDate,
    this.mode = CompletionMode.manual,
    this.completion,
  });

  String? get partsRead {
    return completion?.split('/')[0];
  }

  String? get totalParts {
    return completion?.split('/')[1];
  }

  double get completionRatio {
    final read = partsRead;
    final total = totalParts;
    if (read == null || total == null || total == '0') return 1.0;
    return double.tryParse(completion!) ?? 1.0;
  }

  KhatmaHistory copyWith({
    String? id,
    KhatmaID? khatmaId,
    DateTime? startDate,
    DateTime? endDate,
    CompletionMode? mode,
    String? completion,
  }) {
    return KhatmaHistory(
      id: id ?? this.id,
      khatmaId: khatmaId ?? this.khatmaId,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      mode: mode ?? this.mode,
      completion: completion ?? this.completion,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is KhatmaHistory &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
