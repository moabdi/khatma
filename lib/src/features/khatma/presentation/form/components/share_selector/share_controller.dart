import 'package:khatma/src/features/khatma/domain/khatma.dart';
import 'package:khatma/src/features/khatma/presentation/form/components/share_selector/share_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'share_controller.g.dart';

@riverpod
class ShareController extends _$ShareController {
  @override
  void build() {}

  void updateMaxPartToReserve(int? value) {
    KhatmaShare share = ref.read(shareNotifierProvider);
    if (share.maxPartToRead == null ||
        (value != null && value > share.maxPartToRead!)) {
      ref.read(shareNotifierProvider.notifier).update(
          share.copyWith(maxPartToReserve: value, maxPartToRead: value));
    } else {
      ref
          .read(shareNotifierProvider.notifier)
          .update(share.copyWith(maxPartToReserve: value));
    }
  }

  void updateMaxPartToRead(int? value) {
    KhatmaShare share = ref.read(shareNotifierProvider);
    if (share.maxPartToReserve == null ||
        (value != null && value < share.maxPartToReserve!)) {
      ref.read(shareNotifierProvider.notifier).update(
          share.copyWith(maxPartToReserve: value, maxPartToRead: value));
    } else {
      ref
          .read(shareNotifierProvider.notifier)
          .update(share.copyWith(maxPartToRead: value));
    }
  }
}
