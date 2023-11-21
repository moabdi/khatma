import 'package:khatma/src/features/khatma/domain/khatma.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'khatma_provider.g.dart';

@riverpod
class KhatmaNotifier extends _$KhatmaNotifier {
  @override
  Khatma build() {
    return Khatma(
      name: '',
      unit: SplitUnit.hizb,
      createDate: DateTime.now(),
      share: KhatmaShare(visibility: ShareVisibility.private),
      recurrence: Recurrence(
        repeat: true,
        startDate: DateTime.now(),
        endDate: DateTime.now().add(const Duration(days: 30)),
        unit: RepeatInterval.monthly,
        frequency: 0,
      ),
      style: const KhatmaStyle(
        color: '',
        icon: '',
      ),
    );
  }

  void update(Khatma khatma) {
    state = khatma;
  }
}
