import 'package:khatma/src/common/utils/common.dart';
import 'package:khatma/src/features/khatma/domain/khatma.dart';
import 'package:khatma/src/features/khatma/presentation/widgets/khatma_images.dart';
import 'package:khatma/src/themes/theme.dart';
import 'package:random_string/random_string.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'khatma_form_provider.g.dart';

@Riverpod(keepAlive: true)
class FormKhatma extends _$FormKhatma {
  @override
  Khatma build() {
    return Khatma(
      code: randomAlphaNumeric(6).toUpperCase(),
      name: 'Khatma-${DateTime.now().toInt().toString()}',
      unit: SplitUnit.hizb,
      createDate: DateTime.now(),
      share: KhatmaShare(visibility: ShareVisibility.private),
      recurrence: Recurrence(
        repeat: true,
        startDate: DateTime.now(),
        endDate: DateTime.now().add(const Duration(days: 30)),
        unit: RepeatInterval.monthly,
        frequency: 1,
      ),
      style: KhatmaStyle(
        color: AppTheme.getTheme().primaryColor.toHex(),
        icon: khatmaIconsMap.entries.first.key,
      ),
    );
  }

  void update(Khatma updatedKhatma) {
    state = updatedKhatma;
  }
}
