import 'package:khatma/src/common/constants/test_khatmat.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khatma/src/features/khatma/domain/khatma.dart';

class FakeKhatmaRepository {
  final List<Khatma> _khatmat = kTestKhatmat;

  List<Khatma> getKhatmaList() {
    return _khatmat;
  }

  Khatma? getKhatma(String id) {
    return _khatmat.firstWhere((khatma) => khatma.id == id);
  }

  Future<List<Khatma>> fetchKhatmaList() async {
    await Future.delayed(const Duration(seconds: 1));
    return Future.value(_khatmat);
  }

  Stream<List<Khatma>> watchKhatmaList() async* {
    yield _khatmat;
  }

  Stream<Khatma?> watchProduct(String id) {
    return watchKhatmaList()
        .map((khatmas) => khatmas.firstWhere((khatma) => khatma.id == id));
  }

  void masrAsReadParts(String? khatmaId, List<int> partIds) {
    if (khatmaId != null) {
      Khatma? khatma = getKhatma(khatmaId);
      khatma?.completedParts!.addAll(partIds);
    }
  }
}

final khatmasRepositoryProvider = Provider<FakeKhatmaRepository>((ref) {
  return FakeKhatmaRepository();
});

final khatmasListStreamProvider =
    StreamProvider.autoDispose<List<Khatma>>((ref) {
  final khatmasRepository = ref.watch(khatmasRepositoryProvider);
  return khatmasRepository.watchKhatmaList();
});

final khatmasListFutureProvider =
    FutureProvider.autoDispose<List<Khatma>>((ref) {
  final khatmasRepository = ref.watch(khatmasRepositoryProvider);
  return khatmasRepository.fetchKhatmaList();
});

final khatmaProvider =
    StreamProvider.autoDispose.family<Khatma?, String>((ref, id) {
  final khatmasRepository = ref.watch(khatmasRepositoryProvider);
  return khatmasRepository.watchProduct(id);
});
