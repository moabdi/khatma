import 'package:khatma/src/features/khatma/data/local/local_khatma_repository.dart';
import 'package:khatma/src/features/khatma/data/selected_items_notifier.dart';
import 'package:khatma/src/features/khatma/domain/khatma.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'khatma_parts_controller.g.dart';

@riverpod
class KhatmaPartsController extends _$KhatmaPartsController {
  @override
  FutureOr<void> build() {}

  Future<void> completeParts(String id, List<int> partIds) async {
    // Fetch the khatma
    Khatma? khatma = await ref.watch(localKhatmaRepositoryProvider).getById(id);

    if (khatma == null) {
      return;
    }

    // Create a copy of the parts list to update
    List<KhatmaPart> completedParts = List<KhatmaPart>.from(khatma.parts ?? []);

    // Update the parts based on the provided partIds
    for (var partId in partIds) {
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
    await ref
        .watch(localKhatmaRepositoryProvider)
        .save(khatma.copyWith(parts: completedParts));

    ref.read(selectedItemsNotifierProvider.notifier).clear();
  }
}
