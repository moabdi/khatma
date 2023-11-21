import 'package:khatma/src/features/khatma/data/local/local_khatma_repository.dart';
import 'package:khatma/src/features/khatma/domain/khatma.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'khatmat_provider.g.dart';

@riverpod
class AsyncKhatmat extends _$AsyncKhatmat {
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
