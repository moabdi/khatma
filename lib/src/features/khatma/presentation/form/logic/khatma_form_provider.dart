import 'package:khatma/src/features/khatma/application/khatma_manager.dart';
import 'package:khatma/src/features/khatma/domain/khatma_domain.dart';
import 'package:random_string/random_string.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'khatma_form_provider.g.dart';

@Riverpod(keepAlive: true)
class KhatmaForm extends _$KhatmaForm {
  @override
  KhatmaBase build() {
    final code = randomAlphaNumeric(6).toUpperCase();
    final now = DateTime.now();

    return KhatmaBase(
      code: code,
      name: '',
      createDate: now,
      startDate: now,
    );
  }

  void update(KhatmaBase updatedKhatma) {
    state = updatedKhatma;
  }

  Future<void> save(Khatma khatma) async {
    ref.read(khatmaManagerProvider.notifier).save(khatma);
  }

  Future<void> delete(Khatma khatma) async {
    ref.read(khatmaManagerProvider.notifier).delete(khatma);
  }
}
