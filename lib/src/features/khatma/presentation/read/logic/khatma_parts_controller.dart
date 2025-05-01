import 'dart:async';

import 'package:khatma/src/features/khatma/application/khatmat_provider.dart';
import 'package:khatma/src/features/khatma/domain/khatma.dart';
import 'package:khatma/src/features/khatma/presentation/extentions/khatma_extention.dart';
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

  Future<Khatma> completeParts(String id) async {
    Khatma khatma = ref.watch(currentKhatmaProvider)!;

    List<KhatmaPart> completedParts =
        List<KhatmaPart>.from(khatma.readParts ?? []);

    for (var partId in state) {
      int index = completedParts.indexWhere((part) => part.id == partId);
      if (index != -1) {
        completedParts[index] =
            completedParts[index].copyWith(endDate: DateTime.now());
      } else {
        completedParts.add(KhatmaPart(id: partId, endDate: DateTime.now()));
      }
    }

    Khatma updatedKhatma = khatma.copyWith(readParts: completedParts);
    if (updatedKhatma.isCompleted) {
      updatedKhatma = updatedKhatma.copyWith(endDate: DateTime.now());
    }
    ref.read(khatmaListProvider.notifier).saveOrUpdate(updatedKhatma);
    ref.read(currentKhatmaProvider.notifier).updateValue(updatedKhatma);
    state = [];
    return updatedKhatma;
  }

  FutureOr<void> historize(KhatmaID khatmaId, bool repeat) {
    ref.read(khatmaListProvider.notifier).complete(khatmaId, repeat);
  }
}
