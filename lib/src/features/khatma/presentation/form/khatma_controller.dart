import 'package:khatma/src/features/khatma/application/khatmat_provider.dart';
import 'package:khatma/src/features/khatma/domain/khatma.dart';
import 'package:khatma/src/features/khatma/presentation/form/khatma_form_provider.dart';
import 'package:khatma/src/features/khatma/presentation/widgets/khatma_images.dart';
import 'package:khatma/src/themes/theme.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'khatma_controller.g.dart';

@riverpod
class KhatmaController extends _$KhatmaController {
  @override
  void build() {}
  void updateUnit(Khatma khatma, SplitUnit value) {
    if (khatma.share != null &&
        khatma.share!.maxPartToRead != null &&
        khatma.share!.maxPartToRead! > value.count) {
      ref.read(formKhatmaProvider.notifier).update(khatma.copyWith(
              share: khatma.share!.copyWith(
            maxPartToRead: 1,
            maxPartToReserve: 1,
          )));
    }
    ref.read(formKhatmaProvider.notifier).update(khatma.copyWith(unit: value));
  }

  void submit() {
    Khatma khatma = ref.read(formKhatmaProvider);

    final recurrence =
        (khatma.recurrence?.repeat ?? false) ? khatma.recurrence : null;
    final share = (khatma.share?.visibility == ShareVisibility.private)
        ? null
        : khatma.share;

    final shouldClearTheme = khatma.share != null &&
        khatma.theme?.icon == khatmaIconsMap.entries.first.key &&
        khatma.theme?.color == AppTheme.getTheme().primaryColor.toHex();

    final theme = shouldClearTheme ? null : khatma.theme;

    khatma = khatma.copyWith(
      recurrence: recurrence,
      share: share,
      theme: theme,
    );

    ref.read(khatmaListProvider.notifier).saveOrUpdate(khatma);
    ref.read(currentKhatmaProvider.notifier).updateValue(khatma);
  }

  Future<void> delete(String khatmaId) async {
    return ref.read(khatmaListProvider.notifier).deleteById(khatmaId);
  }
}
