import 'dart:math';

import 'package:khatma/src/utils/common.dart';
import 'package:khatma/src/features/khatma/domain/khatma.dart';
import 'package:khatma/src/features/khatma/presentation/widgets/khatma_images.dart';
import 'package:khatma/src/themes/theme.dart';
import 'package:random_string/random_string.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'khatma_form_provider.g.dart';

@Riverpod(keepAlive: true)
class FormKhatma extends _$FormKhatma {
  @override
  Khatma build() {
    return Khatma(
      code: randomAlphaNumeric(6).toUpperCase(),
      name: 'Khatma-${DateTime.now().toInt().toString()}',
      unit: SplitUnit.juzz,
      createDate: DateTime.now(),
      startDate: DateTime.now(),
      theme: KhatmaTheme(
        color: AppTheme.primaryColors.toHex(),
        icon: khatmaIconsMap.keys
            .elementAt(Random().nextInt(khatmaIconsMap.length)),
      ),
    );
  }

  void update(Khatma updatedKhatma) {
    state = updatedKhatma;
  }
}
