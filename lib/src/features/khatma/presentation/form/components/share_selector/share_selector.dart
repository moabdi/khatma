import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khatma/src/common/constants/app_sizes.dart';
import 'package:khatma/src/common/utils/common.dart';

import 'package:khatma/src/features/khatma/domain/khatma.dart';
import 'package:khatma/src/features/khatma/presentation/form/components/share_selector/share_limit.dart';
import 'package:khatma/src/features/khatma/presentation/form/components/share_selector/share_options.dart';
import 'package:khatma/src/features/khatma/presentation/form/components/share_selector/share_provider.dart';
import 'package:khatma/src/features/khatma/presentation/form/khatma_form_provider.dart';

class ShareSelector extends ConsumerWidget {
  const ShareSelector(
      {super.key, required this.share, required this.onChanged});
  final KhatmaShare share;
  final ValueChanged<KhatmaShare> onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isChanged = ref.read(formKhatmaProvider).share.hashCode !=
        ref.watch(shareNotifierProvider).hashCode;

    return Column(
      children: [
        gapH8,
        const ShareOptions(),
        gapH12,
        const ShareLimit(),
        gapH32,
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
              onPressed: isChanged
                  ? () {
                      onChanged(ref.read(shareNotifierProvider));
                      Navigator.pop(context);
                    }
                  : null,
              child: Text(AppLocalizations.of(context).apply)),
        ),
        gapH12,
      ],
    );
  }
}
