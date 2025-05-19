import 'package:khatma/src/features/authentication/data/auth_repository.dart';
import 'package:khatma/src/features/khatma/data/local/local_khatma_repository.dart';
import 'package:khatma/src/features/khatma/data/remote/khatma_history_repository.dart';
import 'package:khatma/src/features/khatma/data/remote/khatmas_repository.dart';
import 'package:khatma/src/features/khatma/domain/khatma.dart';
import 'package:khatma/src/features/khatma/domain/khatma_history.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'khatmat_provider.g.dart';

@riverpod
class KhatmaList extends _$KhatmaList {
  final bool _useLocal = true; // Set this flag to true to use local storage

  @override
  FutureOr<List<Khatma>> build() async {
    state = const AsyncValue.loading();
    return _fetchAll();
  }

  FutureOr<List<Khatma>> _fetchAll() async {
    if (_useLocal) {
      final localRepo = ref.read(localKhatmaRepositoryProvider);
      return localRepo.fetchAll();
    } else {
      final userUid = _getUserId();
      final remoteRepo = ref.read(khatmasRepositoryProvider);
      return remoteRepo.fetchKhatmasList(userUid);
    }
  }

  FutureOr<void> saveOrUpdate(Khatma khatma) async {
    state = const AsyncValue.loading();
    print('[save] Called with khatma: ${khatma.toString()}');

    if (_useLocal) {
      // ✅ Assign ID if missing
      if (khatma.id == null) {
        final newId = const Uuid().v4();
        khatma = khatma.copyWith(id: newId);
        print('[saveOrUpdate] Assigned new ID: $newId');
      }
      print('[save] Called local with khatma: ${khatma.toString()}');

      await ref.read(localKhatmaRepositoryProvider).save(khatma);
    } else {
      String userUid = _getUserId();

      if (khatma.id == null) {
        await ref.read(khatmasRepositoryProvider).create(userUid, khatma);
      } else {
        await ref.read(khatmasRepositoryProvider).update(userUid, khatma);
      }
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
    state = const AsyncValue.loading();

    if (_useLocal) {
      await ref.read(localKhatmaRepositoryProvider).deleteById(khatmaId);
    } else {
      String userUid = _getUserId();
      await ref.read(khatmasRepositoryProvider).deleteById(userUid, khatmaId);
    }

    var values = await _fetchAll();
    state = AsyncValue.data(values);
  }

  void complete(KhatmaID id, bool repeat) async {
    state = const AsyncValue.loading();

    final all = await _fetchAll();
    final khatma = all.firstWhere((k) => k.id == id);

    if (_useLocal) {
      if (repeat) {
        await ref.read(localKhatmaRepositoryProvider).save(
              khatma.copyWith(
                startDate: DateTime.now(),
                repeat: true,
                repeats: (khatma.repeats ?? 0) + 1,
                readParts: null,
                lastRead: null,
                endDate: null,
              ),
            );
      } else {
        await ref.read(localKhatmaRepositoryProvider).deleteById(id);
      }

      // Optionally handle local history if needed
    } else {
      final userUid = _getUserId();

      // Save history in remote
      await ref.read(khatmaHistoryRepositoryProvider).create(
            userUid,
            CompletionHistory(
              khatmaId: khatma.id,
              startDate: khatma.startDate,
              endDate: DateTime.now(),
            ),
          );

      if (repeat) {
        await ref.read(khatmasRepositoryProvider).update(
              userUid,
              khatma.copyWith(
                startDate: DateTime.now(),
                repeat: true,
                repeats: (khatma.repeats ?? 0) + 1,
                readParts: null,
                lastRead: null,
                endDate: null,
              ),
            );
      } else {
        await ref.read(khatmasRepositoryProvider).deleteById(userUid, id);
      }
    }

    var values = await _fetchAll();
    state = AsyncValue.data(values);
  }
}

@Riverpod(keepAlive: true)
class CurrentKhatma extends _$CurrentKhatma {
  @override
  Khatma? build() => null;

  void updateValue(Khatma khatma) {
    state = khatma;
  }
}
