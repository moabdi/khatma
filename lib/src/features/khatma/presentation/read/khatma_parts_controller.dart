import 'dart:async';

import 'package:khatma/src/features/khatma/application/khatmat_provider.dart';
import 'package:khatma/src/features/khatma/domain/khatma.dart';
import 'package:khatma/src/features/khatma/domain/khatma_history.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'khatma_parts_controller.g.dart';

@riverpod
class KhatmaPartsController extends _$KhatmaPartsController {
  @override
  List<int> build() {
    return [];
  }

  FutureOr<void> selectPart(int item) {
    if (state.contains(item)) {
      state = state.where((i) => i != item).toList();
    } else {
      state = [...state, item];
    }
  }

  Future<KhatmaHistory?> completeParts(String id) async {
    Khatma khatma = ref.watch(currentKhatmaProvider)!;

    List<KhatmaPart> completedParts = List<KhatmaPart>.from(khatma.parts ?? []);

    for (var partId in state) {
      int index = completedParts.indexWhere((part) => part.id == partId);
      if (index != -1) {
        completedParts[index] =
            completedParts[index].copyWith(finishedDate: DateTime.now());
      } else {
        completedParts
            .add(KhatmaPart(id: partId, finishedDate: DateTime.now()));
      }
    }

    Khatma updatedKhatma = khatma.copyWith(parts: completedParts);
    ref.read(khatmaListProvider.notifier).saveOrUpdate(updatedKhatma);
    ref.read(currentKhatmaProvider.notifier).updateValue(updatedKhatma);
    state = [];

    if (updatedKhatma.isCompleted) {
      return KhatmaHistory.fromKhatma(updatedKhatma);
    }

    return null;
  }

  FutureOr<void> historize(KhatmaID khatmaId, bool repeat) {
    ref.read(khatmaListProvider.notifier).historize(khatmaId, repeat);
  }
}
