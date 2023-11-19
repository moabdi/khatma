import 'package:khatma/src/features/khatma/data/local/local_khatma_repository.dart';
import 'package:khatma/src/features/khatma/domain/khatma.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'khatma_provider.g.dart';

@riverpod
FutureOr<List<Khatma>> khatmat(KhatmatRef ref) {
  final provider = ref.watch(localKhatmaRepositoryProvider);
  return provider.fetchAll();
}
