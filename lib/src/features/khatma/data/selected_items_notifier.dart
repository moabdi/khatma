import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectedItemsNotifier extends StateNotifier<List<int>> {
  SelectedItemsNotifier() : super([]);

  void toggleSelection(int item) {
    if (state.contains(item)) {
      state = [...state.where((e) => e != item)];
    } else {
      state = List.of(state..add(item));
    }
  }

  void initSelection(List<int> items) {
    state = items;
  }
}

final selectedItemsNotifier =
    StateNotifierProvider<SelectedItemsNotifier, List<int>>((ref) {
  return SelectedItemsNotifier();
});
