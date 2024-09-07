import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:khatma/src/common/constants/app_sizes.dart';
import 'package:khatma/src/common/constants/lottie_asset.dart';
import 'package:khatma/src/common/extensions/string_utils.dart';
import 'package:khatma/src/common/providers/linear_progress.dart';
import 'package:khatma/src/common/utils/collection_utils.dart';
import 'package:khatma/src/common/utils/common.dart';
import 'package:khatma/src/common/widgets/async_value_widget.dart';
import 'package:khatma/src/common/widgets/avatar.dart';
import 'package:khatma/src/common/widgets/empty_placeholder_widget.dart';
import 'package:khatma/src/common/widgets/loading_list_tile.dart';
import 'package:khatma/src/common/widgets/conditional_content.dart';
import 'package:khatma/src/features/khatma/data/remote/khatmas_repository.dart';
import 'package:khatma/src/features/khatma/domain/khatma.dart';
import 'package:khatma/src/common/widgets/app_bar.dart';
import 'package:khatma/src/features/khatma/presentation/common/khatma_images.dart';
import 'package:khatma/src/features/khatma/presentation/common/khatma_utils.dart';
import 'package:khatma/src/features/khatma/presentation/form/khatma_form_provider.dart';
import 'package:khatma/src/features/khatma/presentation/parts/part_selector/part_floating_button.dart';
import 'package:khatma/src/features/khatma/presentation/parts/part_selector/read_tiles.dart';
import 'package:khatma/src/features/khatma/presentation/parts/part_selector/unread_tiles.dart';
import 'package:khatma/src/routing/app_router.dart';
import 'package:khatma/src/themes/theme.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:readmore/readmore.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class PartSelectorScreen extends ConsumerWidget {
  const PartSelectorScreen({super.key, required this.khatmaId});
  final String khatmaId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final khatmaValue = ref.watch(khatmaStreamProvider(khatmaId));

    return AsyncValueWidget<Khatma?>(
      loading: const LoadingListTile(),
      value: khatmaValue,
      data: (khatma) => khatma == null
          ? EmptyPlaceholderWidget(message: 'Khatma not found')
          : Scaffold(
              backgroundColor: Theme.of(context).disabledColor.withOpacity(.5),
              appBar: KhatmaAppBar(khatmaId: khatmaId),
              floatingActionButton: PartFloatingButton(
                khatmaId: khatmaId,
                color: khatma.style.hexColor,
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildDescriptionCard(khatma, context),
                      gapH8,
                      buildParts(context, khatma),
                      gapH64,
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Widget buildParts(BuildContext context, Khatma khatma) {
    return Column(
      children: [
        buildReadPartCard(context, khatma),
        gapH8,
        buildUnReadPartCard(context, khatma),
      ],
    );
  }

  Widget buildAppBar(KhatmaID khatma, BuildContext context, WidgetRef ref) {
    return KhatmaAppBar(khatmaId: khatmaId);
  }

  Widget buildDescriptionCard(Khatma khatma, BuildContext context) {
    if (isBlank(khatma.description)) return const SizedBox.shrink();

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

  Widget buildUnReadPartCard(BuildContext context, Khatma khatma) {
    return ConditionalContent(
      condition: khatma.isCompleted,
      primary: Stack(
        alignment: Alignment.center,
        children: [
          Card(
            color: Colors.green.shade200,
            child: Container(
              width: double.infinity,
              height: 300,
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  lottieSuccessAsset,
                  AnimatedTextKit(
                    isRepeatingAnimation: false,
                    animatedTexts: [
                      TyperAnimatedText(
                        AppLocalizations.of(context).congratulation,
                        textStyle: Theme.of(context)
                            .textTheme
                            .headlineLarge!
                            .copyWith(color: Colors.green),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(child: lottieCongratAsset),
        ],
      ),
      secondary: Card(
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
      ),
    );
  }

  Widget buildReadPartCard(BuildContext context, Khatma khatma) {
    return ConditionalContent(
      condition: isNotEmpty(khatma.parts),
      secondary: const SizedBox.shrink(),
      primary: Card(
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
            leading: buildChart(context, khatma),
            children: <Widget>[
              ReadPartTiles(
                key: UniqueKey(),
                unit: khatma.unit,
                color: khatma.style.hexColor,
                parts: khatma.parts,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildChart(BuildContext context, Khatma khatma) {
    return CircularPercentIndicator(
      radius: 20.0,
      lineWidth: 4,
      percent: khatma.completude,
      center: Text("${(khatma.completude * 100).toStringAsFixed(0)}%",
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w600,
              )),
      progressColor: khatma.style.hexColor, // Theme.of(context).primaryColor,
      backgroundColor: khatma.style.hexColor.withOpacity(.2),
    );
  }
}

class KhatmaAppBar extends StatelessWidget implements PreferredSizeWidget {
  const KhatmaAppBar({
    super.key,
    required this.khatmaId,
  });

  final String khatmaId;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Consumer(
        builder: (context, ref, _) {
          return AsyncValueWidget<Khatma?>(
            loading: const LoadingListTile(),
            value: ref.watch(khatmaStreamProvider(khatmaId)),
            data: (khatma) => khatma == null
                ? AppBar(title: Text("Khatma"))
                : AppBar(
                    backgroundColor: khatma.style.hexColor.withOpacity(.05),
                    title: Text(khatma.name),
                    actions: [
                      Avatar(
                        radius: 20,
                        backgroundColor:
                            Theme.of(context).primaryColorDark.withOpacity(.5),
                        bottom: Avatar(
                          radius: 5,
                          backgroundColor: khatma.style.hexColor,
                          child: const Icon(Icons.edit, size: 10),
                        ),
                        child: Center(
                          child: getIcon(
                            khatma.style.icon,
                            color: khatma.style.hexColor,
                          ),
                        ),
                        onTap: () => {
                          ref.read(formKhatmaProvider.notifier).update(khatma),
                          context.goNamed(AppRoute.editKhatma.name,
                              pathParameters: {'id': khatma.id!}),
                        },
                      ),
                      gapW16,
                    ],
                  ),
          );
        },
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(66.0);
}
