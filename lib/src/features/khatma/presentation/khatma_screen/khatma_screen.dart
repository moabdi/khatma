import 'package:khatma_app/src/common_widgets/async_value_widget.dart';
import 'package:khatma_app/src/features/khatma/data/fake_khatma_repository.dart';
import 'package:khatma_app/src/features/khatma/presentation/home_app_bar/home_app_bar.dart';
import 'package:khatma_app/src/localization/string_hardcoded.dart';
import 'package:khatma_app/src/common_widgets/empty_placeholder_widget.dart';
import 'package:flutter/material.dart';
import 'package:khatma_app/src/common_widgets/responsive_center.dart';
import 'package:khatma_app/src/common_widgets/responsive_two_column_layout.dart';
import 'package:khatma_app/src/constants/app_sizes.dart';
import 'package:khatma_app/src/features/khatma/domain/khatma.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Shows the khatma page for a given khatma ID.
class KhatmaScreen extends StatelessWidget {
  const KhatmaScreen({super.key, required this.khatmaId});
  final String khatmaId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeAppBar(),
      body: Consumer(
        builder: (context, ref, _) {
          final khatmaValue = ref.watch(khatmaProvider(khatmaId));
          return AsyncValueWidget<Khatma?>(
            value: khatmaValue,
            data: (khatma) => khatma == null
                ? EmptyPlaceholderWidget(
                    message: 'Khatma not found'.hardcoded,
                  )
                : CustomScrollView(
                    slivers: [
                      ResponsiveSliverCenter(
                        padding: const EdgeInsets.all(Sizes.p16),
                        child: KhatmaDetails(khatma: khatma),
                      ),
                    ],
                  ),
          );
        },
      ),
    );
  }
}

/// Shows all the khatma details along with actions to:
/// - leave a review
/// - add to cart
class KhatmaDetails extends StatelessWidget {
  const KhatmaDetails({super.key, required this.khatma});
  final Khatma khatma;

  @override
  Widget build(BuildContext context) {
    return ResponsiveTwoColumnLayout(
      startContent: Container(),
      spacing: Sizes.p16,
      endContent: Card(
        child: Padding(
          padding: const EdgeInsets.all(Sizes.p16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(khatma.name, style: Theme.of(context).textTheme.headline6),
              gapH8,
              Text(khatma.description),
            ],
          ),
        ),
      ),
    );
  }
}
