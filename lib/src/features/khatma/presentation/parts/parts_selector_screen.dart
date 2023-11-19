import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:khatma/src/common/constants/app_sizes.dart';
import 'package:khatma/src/common/utils/collection_utils.dart';
import 'package:khatma/src/common/utils/common.dart';
import 'package:khatma/src/common/widgets/avatar.dart';
import 'package:khatma/src/features/khatma/data/khatma_form_notifier.dart';
import 'package:khatma/src/features/khatma/application/khatma_provider.dart';
import 'package:khatma/src/features/khatma/domain/khatma.dart';
import 'package:khatma/src/common/widgets/k_app_bar.dart';
import 'package:khatma/src/features/khatma/presentation/common/khatma_images.dart';
import 'package:khatma/src/features/khatma/presentation/common/khatma_utils.dart';
import 'package:khatma/src/features/khatma/presentation/parts/part_selector/part_floating_button.dart';
import 'package:khatma/src/features/khatma/presentation/parts/part_selector/read_tiles.dart';
import 'package:khatma/src/features/khatma/presentation/parts/part_selector/unread_tiles.dart';
import 'package:khatma/src/routing/app_router.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:readmore/readmore.dart';

class PartSelectorScreen extends ConsumerWidget {
  const PartSelectorScreen({super.key, required this.khatmaId});
  final String khatmaId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final khatma = ref.read(khatmaDetailsProvider).khatma;

    return Scaffold(
      appBar: buildAppBar(khatma, context, ref),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton:
          PartFloatingButton(khatmaId: khatma.id, color: khatma.style.hexColor),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildDescriptionCard(khatma, context),
              gapH8,
              buildParts(context, ref),
              gapH64,
            ],
          ),
        ),
      ),
    );
  }

  Column buildParts(BuildContext context, WidgetRef ref) {
    final khatma = ref.watch(khatmaDetailsProvider).khatma;
    return Column(
      children: [
        buildReadPartCard(context, khatma),
        gapH8,
        buildUnReadPartCard(khatma),
      ],
    );
  }

  KAppBar buildAppBar(Khatma? khatma, BuildContext context, WidgetRef ref) {
    return KAppBar(
      title: khatma!.name,
      actions: [
        Avatar(
          radius: 20,
          backgroundColor: Theme.of(context).primaryColor.withOpacity(.3),
          bottom: Avatar(
            radius: 5,
            backgroundColor: Theme.of(context).primaryColor,
            child: const Icon(Icons.edit, size: 10),
          ),
          child: Center(
            child: getIcon(
              khatma.style.icon,
              color: Theme.of(context).primaryColor,
            ),
          ),
          onTap: () => {
            ref.read(formKhatmaProvider).update(khatma),
            context.goNamed(AppRoute.editKhatma.name,
                pathParameters: {'id': khatma.id!}),
          },
        ),
        gapW16,
      ],
    );
  }

  Widget buildDescriptionCard(Khatma khatma, BuildContext context) {
    if (khatma.description?.isEmpty == true) return const SizedBox.shrink();

    return Card(
      elevation: 0.5,
      clipBehavior: Clip.antiAlias,
      child: ListTile(
        tileColor: Colors.transparent,
        title: ReadMoreText(
          khatma.description ?? '',
          trimLines: 3,
          style: Theme.of(context).textTheme.bodyMedium,
          colorClickableText: Theme.of(context).primaryColor,
          trimMode: TrimMode.Line,
          textAlign: TextAlign.justify,
          trimCollapsedText: AppLocalizations.of(context).showMore,
          trimExpandedText: AppLocalizations.of(context).showLess,
        ),
      ),
    );
  }

  Card buildUnReadPartCard(Khatma khatma) {
    return Card(
      elevation: 0.4,
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: UnReadPartTiles(
          key: UniqueKey(),
          unit: khatma.unit,
          color: khatma.style.hexColor,
          completedParts: khatma.completedPartIds,
        ),
      ),
    );
  }

  Widget buildReadPartCard(
    BuildContext context,
    Khatma khatma,
  ) {
    if (isEmpty(khatma.parts)) {
      return const SizedBox.shrink();
    } else {
      return Card(
        elevation: 0.4,
        clipBehavior: Clip.antiAlias,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ExpansionTile(
            backgroundColor: Theme.of(context).disabledColor,
            collapsedBackgroundColor: Theme.of(context).disabledColor,
            title: Text(AppLocalizations.of(context).completedParts),
            subtitle: Text(AppLocalizations.of(context)
                .readedParts(khatma.completedPartIds.length)),
            trailing: const Icon(Icons.arrow_drop_down),
            leading: buildChart(context, khatma.completude),
            children: <Widget>[
              ReadPartTiles(
                key: UniqueKey(),
                unit: khatma.unit,
                color: khatma.style.hexColor,
                completedParts: khatma.parts!,
              ),
            ],
          ),
        ),
      );
    }
  }

  Widget buildChart(BuildContext context, double percent) {
    return CircularPercentIndicator(
      radius: 20.0,
      lineWidth: 4,
      percent: percent,
      center: Text("${(percent * 100).toStringAsFixed(0)}%",
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w600,
              )),
      progressColor: Theme.of(context).primaryColor,
      backgroundColor: Theme.of(context).primaryColor.withOpacity(.2),
    );
  }
}
