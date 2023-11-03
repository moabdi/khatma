import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khatma/src/common/constants/app_sizes.dart';
import 'package:khatma/src/common/widgets/avatar.dart';
import 'package:khatma/src/features/khatma/data/khatma_notifier.dart';
import 'package:khatma/src/features/khatma/domain/khatma.dart';
import 'package:khatma/src/common/widgets/k_app_bar.dart';
import 'package:khatma/src/features/khatma/presentation/common/khatma_images.dart';
import 'package:khatma/src/features/khatma/presentation/common/khatma_utils.dart';
import 'package:khatma/src/features/khatma/presentation/parts/part_selector/part_floating_button.dart';
import 'package:khatma/src/features/khatma/presentation/parts/part_selector/read_tiles.dart';
import 'package:khatma/src/features/khatma/presentation/parts/part_selector/unread_tiles.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:readmore/readmore.dart';

class PartSelectorScreen extends ConsumerWidget {
  const PartSelectorScreen({super.key, required this.khatmaId});
  final String khatmaId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final khatma = ref.watch(formKhatmaProvider).khatma;

    return Scaffold(
      appBar: buildAppBar(khatma, context),
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
              buildReadPartCard(context, khatma),
              gapH8,
              buildUnReadPartCard(khatma),
              gapH64,
            ],
          ),
        ),
      ),
    );
  }

  KAppBar buildAppBar(Khatma? khatma, BuildContext context) {
    return KAppBar(
      title: khatma!.name,
      actions: [
        Avatar(
          radius: 20,
          backgroundColor: Theme.of(context).primaryColor.withOpacity(.3),
          onTap: null,
          bottom: Avatar(
            radius: 5,
            backgroundColor: Theme.of(context).primaryColor,
            child: const Icon(Icons.edit, size: 10),
          ),
          child: Center(
            child: getImage(
              khatma.style.icon,
              color: Theme.of(context).primaryColor,
            ),
          ),
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
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: ListTile(
          tileColor: Colors.transparent,
          subtitle: ReadMoreText(
            khatma.description ?? '',
            trimLines: 3,
            style: Theme.of(context).textTheme.bodySmall,
            colorClickableText: Theme.of(context).primaryColor,
            trimMode: TrimMode.Line,
            textAlign: TextAlign.justify,
            trimCollapsedText: ' > show more',
            trimExpandedText: ' < show less',
          ),
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
          completedParts: khatma.completedParts,
        ),
      ),
    );
  }

  Widget buildReadPartCard(
    BuildContext context,
    Khatma khatma,
  ) {
    return Card(
      elevation: 0.4,
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ExpansionTile(
          backgroundColor: Theme.of(context).cardColor,
          title: const Text('Completed parts'),
          subtitle: Text("${khatma.completedParts?.length} parts",
              style: Theme.of(context).textTheme.bodySmall),
          trailing: const Icon(Icons.arrow_drop_down_circle),
          leading: buildChart(context, khatma.completude),
          children: <Widget>[
            ReadPartTiles(
              key: UniqueKey(),
              unit: khatma.unit,
              color: khatma.style.hexColor,
              completedParts: khatma.completedParts,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildChart(BuildContext context, double percent) {
    return CircularPercentIndicator(
      radius: 20.0,
      lineWidth: 3.5,
      percent: percent,
      center: Text("${(percent * 100).toStringAsFixed(0)}%",
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                fontSize: 9,
                fontWeight: FontWeight.w900,
              )),
      progressColor: Theme.of(context).primaryColor,
      backgroundColor: Theme.of(context).disabledColor,
    );
  }
}
