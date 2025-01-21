import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khatma_ui/constants/app_sizes.dart';
import 'package:khatma/src/common/utils/common.dart';

import 'package:khatma/src/features/khatma/domain/khatma.dart';
import 'package:khatma/src/features/khatma/presentation/form/components/share_selector/share_limit.dart';
import 'package:khatma/src/features/khatma/presentation/form/components/share_selector/share_options.dart';
import 'package:khatma/src/features/khatma/presentation/form/components/share_selector/share_provider.dart';

import '../../khatma_form_provider.dart';

class ShareSelector extends ConsumerWidget {
  const ShareSelector({super.key, required this.onChanged});

  final ValueChanged<KhatmaShare> onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final khatma = ref.watch(formKhatmaProvider);
    final khatmaShare = ref.watch(shareNotifierProvider);

    return Column(
      children: [
        gapH8,
        ShareOptions(
          khatmaShare: khatmaShare,
        ),
        gapH12,
        ShareLimit(
          khatmaShare: khatmaShare,
          maxValue: khatma.unit.count,
        ),
        gapH32,
        ElevatedButton(
          child: Text(AppLocalizations.of(context).apply),
          onPressed: () {
            onChanged(ref.read(shareNotifierProvider));
            Navigator.pop(context);
          },
        ),
        gapH12,
      ],
    );
  }
}
