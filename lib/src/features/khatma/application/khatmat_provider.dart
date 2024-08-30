import 'package:khatma/src/features/authentication/data/auth_repository.dart';
import 'package:khatma/src/features/khatma/data/remote/khatmas_repository.dart';
import 'package:khatma/src/features/khatma/domain/khatma.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'khatmat_provider.g.dart';

@riverpod
class KhatmaList extends _$KhatmaList {
  @override
  FutureOr<List<Khatma>> build() async {
    state = const AsyncValue.loading();
    return _fetchAll();
  }

  FutureOr<List<Khatma>> _fetchAll() async {
    String userUid = _getUserId();
    final provider = ref.watch(khatmasRepositoryProvider);
    return provider.fetchKhatmasList(userUid);
  }

  FutureOr<void> saveOrUpdate(Khatma khatma) async {
    state = const AsyncValue.loading();
    String userUid = _getUserId();
    if (khatma.id == null) {
      await ref.read(khatmasRepositoryProvider).create(userUid, khatma);
    } else {
      await ref.read(khatmasRepositoryProvider).update(userUid, khatma);
    }
    var values = await _fetchAll();
    state = AsyncValue.data(values);
  }

  String _getUserId() {
    String userUid = ref.read(authRepositoryProvider).currentUser!.uid;
    return userUid;
  }

  Khatma getById(String id) {
    return state.value!.firstWhere((khatma) => khatma.id == id);
  }

  void deleteById(KhatmaID khatmaId) async {
    String userUid = ref.read(authRepositoryProvider).currentUser!.uid;
    await ref.read(khatmasRepositoryProvider).deleteById(userUid, khatmaId);
    state.value!.removeWhere((khatma) => khatma.id == khatmaId);
    state = state;
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
