import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'khatma_parts_controller.g.dart';

@riverpod
class KhatmaPartsController extends _$KhatmaPartsController {
  @override
  List<int> build() {
    return [];
  }

  FutureOr<void> togglePart(int item) {
    if (state.contains(item)) {
      state = state.where((i) => i != item).toList();
    } else {
      state = [...state, item];
    }
  }
}
