import 'package:khatma/src/features/authentication/application/account_manager.dart';
import 'package:khatma/src/features/khatma/application/khatma_manager.dart';
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
    final currentUser = ref.read(userProvider);
    final creator = currentUser != null
        ? KhatmaCreator(
            creatorId: currentUser.id,
            creatorName: currentUser.displayName ?? currentUser.email,
          )
        : null;
    return KhatmaFormData.blank(code: code, creator: creator);
  }

  /// Initialize form for creating a new Khatma
  void initializeForCreate({KhatmaType type = KhatmaType.personal}) {
    final code = randomAlphaNumeric(6).toUpperCase();
    final currentUser = ref.read(userProvider);
    final creator = currentUser != null
        ? KhatmaCreator(
            creatorId: currentUser.id,
            creatorName: currentUser.displayName ?? currentUser.email,
          )
        : null;
    state = KhatmaFormData.blank(code: code, type: type, creator: creator);
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
    final result = await ref.read(khatmaManagerProvider.notifier).save(khatmaToSave);

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
      await ref.read(khatmaManagerProvider.notifier).delete(khatma);
    }
  }

  /// Check if we're editing an existing Khatma
  bool get isEditing => state.isEditing;
}
