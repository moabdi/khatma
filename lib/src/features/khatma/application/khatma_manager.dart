import 'package:khatma/src/features/authentication/application/account_manager.dart';
import 'package:khatma/src/features/authentication/domain/app_user.dart';
import 'package:khatma/src/features/khatma/data/repository/local/local_khatma_repository.dart';
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

  AppUser? get _user => ref.read(userProvider);
  KhatmasRepository get _khatmasRepository =>
      ref.read(khatmasRepositoryProvider);
  LocalKhatmaRepository get _localKhatmasRepository =>
      ref.read(localKhatmaRepositoryProvider);

  void update(Khatma updatedKhatma) {
    state = updatedKhatma;
  }

  Future<void> save(Khatma khatma) async {
    if (_user == null) {
      await _localKhatmasRepository.save(khatma);
    } else {
      await _khatmasRepository.create(_user!.id, khatma);
    }
  }

  Future<void> delete(Khatma khatma) async {
    _khatmasRepository.delete(_user!.id, khatma);
  }
}
