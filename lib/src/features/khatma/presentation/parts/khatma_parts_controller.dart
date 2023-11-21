import 'package:khatma/src/features/khatma/application/khatmat_provider.dart';
import 'package:khatma/src/features/khatma/domain/khatma.dart';
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

  Future<void> completeParts(String id) async {
    Khatma khatma = ref.watch(asyncKhatmatProvider.notifier).getKhatmaById(id);

    // Create a copy of the parts list to update
    List<KhatmaPart> completedParts = List<KhatmaPart>.from(khatma.parts ?? []);

    // Update the parts based on the provided partIds
    for (var partId in state) {
      int index = completedParts.indexWhere((part) => part.id == partId);
      if (index != -1) {
        // Update the existing part
        completedParts[index] =
            completedParts[index].copyWith(finishedDate: DateTime.now());
      } else {
        // Add a new part if it doesn't exist
        completedParts
            .add(KhatmaPart(id: partId, finishedDate: DateTime.now()));
      }
    }

    // Update the khatma with the modified parts
    Khatma updatedKhatma = khatma.copyWith(parts: completedParts);
    ref.read(asyncKhatmatProvider.notifier).updateKhatma(updatedKhatma);
    state = [];
  }
}
