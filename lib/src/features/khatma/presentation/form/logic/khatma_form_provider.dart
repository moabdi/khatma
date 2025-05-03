import 'dart:math';

import 'package:khatma/src/features/khatma/domain/khatma_domain.dart';
import 'package:khatma/src/features/khatma/presentation/form/ui/khatma_images.dart';
import 'package:random_string/random_string.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'khatma_form_provider.g.dart';

final _random = Random();

@Riverpod(keepAlive: true)
class KhatmaForm extends _$KhatmaForm {
  @override
  Khatma build() {
    final code = randomAlphaNumeric(6).toUpperCase();
    final now = DateTime.now();

    return Khatma(
      code: code,
      name: 'Khatma-$code',
      unit: SplitUnit.juzz,
      createDate: now,
      startDate: now,
      theme: KhatmaTheme(
        color: khatmaColorMap.entries.first.key,
        icon: khatmaIconsMap.keys.elementAt(
          _random.nextInt(khatmaIconsMap.length),
        ),
      ),
    );
  }

  void update(Khatma updatedKhatma) {
    state = updatedKhatma;
  }
}
