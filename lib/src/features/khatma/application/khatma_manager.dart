import 'package:khatma/src/features/authentication/application/account_manager.dart';
import 'package:khatma/src/features/khatma/data/repository/remote/khatmas_repository.dart';
import 'package:khatma/src/features/khatma/domain/khatma.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'khatma_manager.g.dart';

@Riverpod(keepAlive: true)
class KhatmaManager extends _$KhatmaManager {
  @override
  Khatma? build() {
    return null;
  }

  String get _userId => ref.read(userProvider)!.id;
  KhatmasRepository get _khatmasRepository =>
      ref.read(khatmasRepositoryProvider);

  void update(KhatmaBase updatedKhatma) {
    state = updatedKhatma;
  }

  Future<void> save(Khatma khatma) async {
    _khatmasRepository.create(_userId, khatma);
  }

  Future<void> delete(Khatma khatma) async {
    _khatmasRepository.delete(_userId, khatma);
  }
}
