import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:khatma/src/features/khatma/presentation/read/components/animate_khatma_chart.dart';
import 'package:khatma/src/features/khatma/presentation/read/khatma_success_complete.dart';
import 'package:khatma_ui/constants/app_sizes.dart';
import 'package:khatma_ui/extentions/string_extensions.dart';
import 'package:khatma/src/common/utils/collection_utils.dart';
import 'package:khatma/src/common/utils/common.dart';
import 'package:khatma/src/common/widgets/async_value_widget.dart';
import 'package:khatma/src/common/widgets/avatar.dart';
import 'package:khatma/src/common/widgets/empty_placeholder_widget.dart';
import 'package:khatma/src/common/widgets/loading_list_tile.dart';
import 'package:khatma_ui/components/conditional_content.dart';
import 'package:khatma/src/features/khatma/data/remote/khatmas_repository.dart';
import 'package:khatma/src/features/khatma/domain/khatma.dart';
import 'package:khatma/src/features/khatma/presentation/widgets/khatma_images.dart';
import 'package:khatma/src/features/khatma/presentation/widgets/khatma_utils.dart';
import 'package:khatma/src/features/khatma/presentation/form/providers/khatma_form_provider.dart';
import 'package:khatma/src/features/khatma/presentation/read/components/part_selector/part_floating_button.dart';
import 'package:khatma/src/features/khatma/presentation/read/components/part_selector/to_read_tiles.dart';
import 'package:khatma/src/routing/app_router.dart';
import 'package:readmore/readmore.dart';

class KhatmaReadScreen extends ConsumerWidget {
  const KhatmaReadScreen({super.key, required this.khatmaId});
  final String khatmaId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final khatmaValue = ref.watch(khatmaStreamProvider(khatmaId));
    return AsyncValueWidget<Khatma?>(
      loading: const LoadingListTile(),
      value: khatmaValue,
      data: (khatma) => khatma == null
          ? EmptyPlaceholderWidget(message: 'Khatma not found')
          : khatma.isCompleted
              ? KhatmaSuccessComplete(khatma: khatma)
              : buildContent(khatma, context),
    );
  }

  Widget buildContent(Khatma khatma, BuildContext context) {
    return Scaffold(
      appBar: KhatmaAppBar(khatmaId: khatma.id!),
      floatingActionButton: PartFloatingButton(
        khatmaId: khatma.id,
        color: khatma.style.hexColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SingleChildScrollView(
        child: Container(
          color: khatma.style.hexColor.withOpacity(.1),
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
        buildToReadPartCard(context, khatma),
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

  Widget buildToReadPartCard(BuildContext context, Khatma khatma) {
    return Card(
      elevation: 0.4,
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ToReadPartTiles(
          key: UniqueKey(),
          unit: khatma.unit,
          color: khatma.style.hexColor,
          completedParts: khatma.completedPartIds,
        ),
      ),
    );
  }

  Widget buildReadPartCard(BuildContext context, Khatma khatma) {
    return ConditionalContent(
      condition: isNotEmpty(khatma.readParts),
      secondary: const SizedBox.shrink(),
      primary: Card(
        elevation: 0.4,
        clipBehavior: Clip.antiAlias,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
              title: Text(AppLocalizations.of(context).completedParts),
              subtitle: Text(AppLocalizations.of(context)
                  .readedParts(khatma.completedPartIds.length)),
              leading: AnimatedKhatmaChart(khatma: khatma)),
        ),
      ),
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
                        backgroundColor: khatma.style.hexColor.withOpacity(.2),
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
