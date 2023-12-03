import 'package:khatma/src/features/khatma/application/khatmat_provider.dart';
import 'package:khatma/src/features/khatma/domain/khatma.dart';
import 'package:khatma/src/features/khatma/presentation/form/khatma_form_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'khatma_controller.g.dart';

@riverpod
class KhatmaController extends _$KhatmaController {
  @override
  void build() {}
  void updateUnit(Khatma khatma, SplitUnit value) {
    if (khatma.share.maxPartToRead != null &&
        khatma.share.maxPartToRead! > value.count) {
      ref.read(formKhatmaProvider.notifier).update(khatma.copyWith(
              share: khatma.share.copyWith(
            maxPartToRead: 1,
            maxPartToReserve: 1,
          )));
    }
    ref.read(formKhatmaProvider.notifier).update(khatma.copyWith(unit: value));
  }

  void submit(String name, String description) {
    Khatma updatedKhatma = ref
        .read(formKhatmaProvider)
        .copyWith(name: name, description: description);
    ref.read(khatmaListProvider.notifier).updateKhatma(updatedKhatma);
    ref.read(currentKhatmaProvider.notifier).updateValue(updatedKhatma);
  }

  void delete(String khatmaId) {
    ref.read(khatmaListProvider.notifier).deleteById(khatmaId);
  }
}
