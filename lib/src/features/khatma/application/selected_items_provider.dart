import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'selected_items_provider.g.dart';

@riverpod
class SelectedItemsNotifier extends _$SelectedItemsNotifier {
  @override
  List<int> build() {
    return [];
  }

  void toggleSelection(int item) {
    if (state.contains(item)) {
      state = [...state.where((e) => e != item)];
    } else {
      state = List.of(state..add(item));
    }
  }

  void clear() {
    state = [];
  }
}
