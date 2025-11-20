import 'package:khatma/src/features/khatma/personal/application/khatmat_provider.dart';
import 'package:khatma/src/features/khatma/domain/khatma_domain.dart';
import 'package:khatma/src/features/khatma/presentation/form/logic/khatma_form_data.dart';
import 'package:random_string/random_string.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'khatma_form_provider.g.dart';

@Riverpod(keepAlive: true)
class KhatmaForm extends _$KhatmaForm {
  @override
  KhatmaFormData build() {
    final code = randomAlphaNumeric(6).toUpperCase();
    return KhatmaFormData.blank(code: code);
  }

  /// Initialize form for creating a new Khatma
  void initializeForCreate({KhatmaType type = KhatmaType.personal}) {
    final code = randomAlphaNumeric(6).toUpperCase();
    state = KhatmaFormData.blank(code: code, type: type);
  }

  /// Initialize form for editing an existing Khatma
  void initializeForEdit(Khatma khatma) {
    state = KhatmaFormData.fromKhatma(khatma);
  }

  /// Update the form state
  void update(KhatmaFormData updatedFormData) {
    state = updatedFormData;
  }

  /// Save the Khatma (handles both create and update automatically)
  /// Returns the saved khatma with updated ID
  Future<Khatma?> save() async {
    final khatmaToSave = state.toKhatma();
    final result = await ref.read(khatmaNotifierProvider.notifier).saveKhatma(khatmaToSave);

    // If save was successful, update the state with the saved khatma
    if (result.isSuccess) {
      final savedKhatma = result.dataOrNull!;
      state = KhatmaFormData.fromKhatma(savedKhatma);
      return savedKhatma;
    }

    return null;
  }

  /// Delete the Khatma (only works if editing existing)
  Future<void> delete() async {
    final khatma = state.toKhatma();
    if (khatma.id != null) {
      await ref.read(khatmaNotifierProvider.notifier).deleteKhatma(khatma.id!);
    }
  }

  /// Check if we're editing an existing Khatma
  bool get isEditing => state.isEditing;
}
