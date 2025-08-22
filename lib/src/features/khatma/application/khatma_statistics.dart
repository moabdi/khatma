import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:khatma/src/features/khatma/domain/khatma.dart';
import 'package:khatma/src/features/khatma/domain/completion_history.dart';
import 'dart:math' as math;
part 'khatma_statistics.freezed.dart';

@freezed
abstract class KhatmaStatistics with _$KhatmaStatistics {
  const factory KhatmaStatistics({
    required int totalKhatmas,
    required int activeKhatmas,
    required int completedKhatmas,
    required int totalPartsCompleted,
    required double averageCompletionRate,
    required Duration totalReadingTime,
    required int currentStreak,
    required int longestStreak,
    required Map<String, int> monthlyCompletions,
  }) = _KhatmaStatistics;

  static KhatmaStatistics fromData(
    List<Khatma> khatmas,
    List<CompletionHistory> history,
  ) {
    final active = khatmas.length;
    final completed = history.length;

    final totalParts = khatmas.fold<int>(
      0,
      (sum, k) => sum + k.completedPartIds.length,
    );

    final avgCompletion = khatmas.isEmpty
        ? 0.0
        : khatmas.fold<double>(0, (sum, k) => sum + k.completionPercent) /
            khatmas.length;

    // Calculate streaks and other metrics
    final streaks = _calculateStreaks(history);
    final monthlyStats = _calculateMonthlyStats(history);

    return KhatmaStatistics(
      totalKhatmas: khatmas.length,
      activeKhatmas: active,
      completedKhatmas: completed,
      totalPartsCompleted: totalParts,
      averageCompletionRate: avgCompletion,
      totalReadingTime: _calculateTotalReadingTime(khatmas),
      currentStreak: streaks.current,
      longestStreak: streaks.longest,
      monthlyCompletions: monthlyStats,
    );
  }

  static ({int current, int longest}) _calculateStreaks(
      List<CompletionHistory> history) {
    if (history.isEmpty) return (current: 0, longest: 0);

    // Sort by completion date
    final sortedHistory = history.toList()
      ..sort((a, b) => a.endDate.compareTo(b.endDate));

    int currentStreak = 0;
    int longestStreak = 0;
    int tempStreak = 0;
    DateTime? lastDate;

    for (final completion in sortedHistory) {
      if (lastDate == null) {
        tempStreak = 1;
      } else {
        final dayDiff = completion.endDate.difference(lastDate).inDays;
        if (dayDiff <= 1) {
          tempStreak++;
        } else {
          longestStreak = math.max(longestStreak, tempStreak);
          tempStreak = 1;
        }
      }
      lastDate = completion.endDate;
    }

    longestStreak = math.max(longestStreak, tempStreak);

    // Calculate current streak
    if (sortedHistory.isNotEmpty) {
      final now = DateTime.now();
      final lastCompletion = sortedHistory.last.endDate;
      final daysSinceLastCompletion = now.difference(lastCompletion).inDays;

      if (daysSinceLastCompletion <= 1) {
        currentStreak = tempStreak;
      }
    }

    return (current: currentStreak, longest: longestStreak);
  }

  static Map<String, int> _calculateMonthlyStats(
      List<CompletionHistory> history) {
    final monthlyStats = <String, int>{};

    for (final completion in history) {
      final monthKey =
          '${completion.endDate.year}-${completion.endDate.month.toString().padLeft(2, '0')}';
      monthlyStats[monthKey] = (monthlyStats[monthKey] ?? 0) + 1;
    }

    return monthlyStats;
  }

  static Duration _calculateTotalReadingTime(List<Khatma> khatmas) {
    num totalSeconds = 0;

    for (final khatma in khatmas) {
      for (final part in khatma.readParts ?? []) {
        final duration = part.readingDuration;
        if (duration != null) {
          totalSeconds += duration.inSeconds;
        }
      }
    }

    return Duration(seconds: totalSeconds.toInt());
  }
}
