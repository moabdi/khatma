import 'dart:async';

import 'package:khatma/src/common/constants/test_khatmat.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khatma/src/features/khatma/data/selected_items_notifier.dart';
import 'package:khatma/src/features/khatma/domain/khatma.dart';

class FakeKhatmaRepository {
  final List<Khatma> _khatmat = kTestKhatmat;

  List<Khatma> getKhatmaList() {
    return _khatmat;
  }

  void saveKhatma(Khatma khatma) {
    return _khatmat.add(khatma);
  }

  Khatma? getKhatma(String id) {
    return _khatmat.firstWhere((khatma) => khatma.id == id);
  }

  Future<List<Khatma>> fetchKhatmaList() async {
    return Future.value(_khatmat);
  }

  Stream<List<Khatma>> watchKhatmaList() async* {
    yield _khatmat;
  }

  Stream<Khatma?> watchProduct(String id) {
    return watchKhatmaList()
        .map((khatmas) => khatmas.firstWhere((khatma) => khatma.id == id));
  }

  void markAsRead(String? khatmaId, List<int> partIds) {
    if (khatmaId != null) {
      Khatma? khatma = getKhatma(khatmaId);
      List<int> completedParts = khatma!.completedParts ?? [];
      List<int> combinedList = List<int>.from(completedParts, growable: true);
      combinedList.addAll(partIds);
      int index = _khatmat.indexWhere((khatma) => khatma.id == khatmaId);
      _khatmat[index] = khatma.copyWith(completedParts: combinedList);
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
  ref.listen(selectedItemsNotifier, (previous, next) {
    if (previous!.isNotEmpty && next.isEmpty == true) {
      ref.state = AsyncValue.data(khatmasRepository.getKhatma(id));
    }
  });
  return khatmasRepository.watchProduct(id);
});
