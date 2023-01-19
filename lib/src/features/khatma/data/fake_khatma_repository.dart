import 'package:khatma_app/src/constants/test_khatmat.dart';
import 'package:khatma_app/src/features/khatma/domain/khatma.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FakeKhatmaRepository {
  final List<Khatma> _khatmat = kTestKhatmat;

  List<Khatma> getProductsList() {
    return _khatmat;
  }

  Khatma? getProduct(String id) {
    return _khatmat.firstWhere((khatma) => khatma.id == id);
  }

  Future<List<Khatma>> fetchProductsList() async {
    await Future.delayed(const Duration(seconds: 2));
    return Future.value(_khatmat);
  }

  Stream<List<Khatma>> watchProductsList() async* {
    await Future.delayed(const Duration(seconds: 1));
    yield _khatmat;
  }

  Stream<Khatma?> watchProduct(String id) {
    return watchProductsList()
        .map((khatmas) => khatmas.firstWhere((khatma) => khatma.id == id));
  }
}

final khatmasRepositoryProvider = Provider<FakeKhatmaRepository>((ref) {
  return FakeKhatmaRepository();
});

final khatmasListStreamProvider =
    StreamProvider.autoDispose<List<Khatma>>((ref) {
  final khatmasRepository = ref.watch(khatmasRepositoryProvider);
  return khatmasRepository.watchProductsList();
});

final khatmasListFutureProvider =
    FutureProvider.autoDispose<List<Khatma>>((ref) {
  final khatmasRepository = ref.watch(khatmasRepositoryProvider);
  return khatmasRepository.fetchProductsList();
});

final khatmaProvider =
    StreamProvider.autoDispose.family<Khatma?, String>((ref, id) {
  final khatmasRepository = ref.watch(khatmasRepositoryProvider);
  return khatmasRepository.watchProduct(id);
});
