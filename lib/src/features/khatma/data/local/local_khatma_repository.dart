import 'package:khatma/src/features/khatma/data/local/have_khatma_repository.dart';
import 'package:khatma/src/features/khatma/domain/khatma.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'local_khatma_repository.g.dart';

abstract class LocalKhatmaRepository {
  Future<void> save(Khatma khatma);

  Future<Khatma?> getById(String id);

  Future<void> deleteById(String id);

  Future<List<Khatma>> fetchAll();
}

@Riverpod(keepAlive: true)
LocalKhatmaRepository localKhatmaRepository(LocalKhatmaRepositoryRef ref) {
  return HaveKhatmaRepository();
}
