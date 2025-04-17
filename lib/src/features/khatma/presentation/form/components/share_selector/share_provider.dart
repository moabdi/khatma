import 'package:khatma/src/features/khatma/domain/khatma.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'share_provider.g.dart';

@Riverpod(keepAlive: true)
class ShareNotifier extends _$ShareNotifier {
  KhatmaShare build() {
    return KhatmaShare(visibility: ShareVisibility.private);
  }

  void update(KhatmaShare? khatmaShare) {
    state = khatmaShare ?? KhatmaShare(visibility: ShareVisibility.private);
  }
}
