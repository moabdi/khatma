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
    ref
        .read(shareNotifierProvider.notifier)
        .update(share.copyWith(maxPartToReserve: value));
  }

  void updateMaxPartToRead(int? value) {
    KhatmaShare share = ref.read(shareNotifierProvider);
    ref
        .read(shareNotifierProvider.notifier)
        .update(share.copyWith(maxPartToRead: value));
  }
}
