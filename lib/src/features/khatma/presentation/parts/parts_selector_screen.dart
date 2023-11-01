import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khatma/src/common/widgets/async_value_widget.dart';
import 'package:khatma/src/common/constants/app_sizes.dart';
import 'package:khatma/src/features/khatma/data/fake_khatma_repository.dart';
import 'package:khatma/src/features/khatma/data/parts_repository.dart';
import 'package:khatma/src/features/khatma/data/selected_items_notifier.dart';
import 'package:khatma/src/features/khatma/domain/khatma.dart';
import 'package:khatma/src/features/khatma/domain/part.dart';
import 'package:khatma/src/common/widgets/k_app_bar.dart';
import 'package:khatma/src/features/khatma/presentation/common/khatma_utils.dart';
import 'package:khatma/src/features/khatma/presentation/parts/part_selector/part_floating_button.dart';
import 'package:khatma/src/features/khatma/presentation/parts/part_selector/part_tile.dart';

class PartSelectorScreen extends ConsumerWidget {
  const PartSelectorScreen({super.key, required this.khatmaId});
  final String khatmaId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final khatmaValue = ref.watch(khatmaProvider(khatmaId));
    return Scaffold(
      body: AsyncValueWidget<Khatma?>(
        value: khatmaValue,
        data: (khatma) => Scaffold(
          appBar: buildAppBar(khatma!, context),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: PartFloatingButton(khatmaId: khatma.id),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Card(
                  elevation: 0.4,
                  clipBehavior: Clip.antiAlias,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: buildBody(khatma),
                  ),
                ),
                gapH64,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Consumer buildBody(Khatma khatma) {
    return Consumer(
      builder: (context, ref, _) {
        final partsListValue = ref.watch(partsListFutureProvider(khatma!.unit));
        List<int> selectedParts = ref.watch(selectedItemsNotifier);
        return AsyncValueWidget<List<Part>>(
          value: partsListValue,
          data: (parts) => ListView.separated(
            shrinkWrap: true,
            primary: false,
            separatorBuilder: (context, index) => const Divider(height: 2),
            itemCount: parts.length,
            itemBuilder: (BuildContext context, int index) {
              var part = parts[index];
              var isRead = khatma.completedParts != null &&
                  khatma.completedParts!.contains(part.id);
              return PartTile(
                part,
                selectedParts: selectedParts,
                isRead: isRead,
                color: khatma.style.hexColor,
              );
            },
          ),
        );
      },
    );
  }

  KAppBar buildAppBar(Khatma khatma, BuildContext context) {
    return KAppBar(
      backgroundColor: khatma.style.hexColor.withOpacity(.3),
      title: khatma.name,
      leading: IconButton(
        icon: const Icon(Icons.chevron_left),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      actions: [
        IconButton(
          onPressed: () => {},
          icon: const Icon(Icons.info_outline_rounded),
        ),
        IconButton(
          onPressed: () => {},
          icon: const Icon(Icons.edit),
        ),
      ],
    );
  }
}
