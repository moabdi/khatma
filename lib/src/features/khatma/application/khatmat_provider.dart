import 'package:khatma/src/features/khatma/data/local/local_khatma_repository.dart';
import 'package:khatma/src/features/khatma/domain/khatma.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'khatmat_provider.g.dart';

@riverpod
class KhatmaList extends _$KhatmaList {
  FutureOr<List<Khatma>> _fetchAll() async {
    final provider = ref.watch(localKhatmaRepositoryProvider);
    return provider.fetchAll();
  }

  @override
  FutureOr<List<Khatma>> build() async {
    state = const AsyncValue.loading();
    return _fetchAll();
  }

  FutureOr<void> updateKhatma(Khatma khatma) async {
    state = const AsyncValue.loading();
    await ref.read(localKhatmaRepositoryProvider).save(khatma);
    var values = await ref.read(localKhatmaRepositoryProvider).fetchAll();
    state = AsyncValue.data(values);
  }
}

@Riverpod(keepAlive: true)
class CurrentKhatma extends _$CurrentKhatma {
  @override
  Khatma? build() {
    return null;
  }

  void updateValue(Khatma khatma) {
    state = khatma;
  }
}
