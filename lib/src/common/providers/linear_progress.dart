import 'package:flutter_riverpod/flutter_riverpod.dart';

class BooleanNotifier extends StateNotifier<bool> {
  BooleanNotifier(this.ref) : super(false); // Pass ref to the constructor

  final Ref ref;

  void enable() {
    state = true;
  }

  void disable() {
    state = false;
  }

  // Don't use ref.read or ref.watch here directly if it's dependency-changing
}

final boolNotifierProvider =
    StateNotifierProvider<BooleanNotifier, bool>((ref) {
  return BooleanNotifier(ref);
});
