import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:khatma/src/common_widgets/async_value_widget.dart';
import 'package:khatma/src/common_widgets/safe_text.dart';
import 'package:khatma/src/features/khatma/data/fake_khatma_repository.dart';
import 'package:khatma/src/features/khatma/data/parts_repository.dart';
import 'package:khatma/src/features/khatma/data/selected_items_notifier.dart';
import 'package:khatma/src/features/khatma/domain/khatma.dart';
import 'package:khatma/src/features/khatma/domain/part.dart';
import 'package:khatma/src/common_widgets/k_app_bar.dart';
import 'package:khatma/src/features/khatma/presentation/part_selector/part_tile.dart';
import 'package:khatma/src/features/khatma/utils/collection_utils.dart';
import 'package:khatma/src/routing/app_router.dart';
import 'package:khatma/src/themes/theme.dart';

class PartSelectorScreen extends ConsumerWidget {
  const PartSelectorScreen({super.key, required this.khatmaId});
  final String khatmaId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final khatmaValue = ref.watch(khatmaProvider(khatmaId));
    return Scaffold(
      backgroundColor: AppTheme.getTheme().backgroundColor,
      body: AsyncValueWidget<Khatma?>(
        value: khatmaValue,
        data: (khatma) => Scaffold(
          appBar: KAppBar(
            title: khatma!.name,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            actions: [
              IconButton(
                onPressed: () => {},
                icon: const Icon(Icons.description),
              ),
              IconButton(
                onPressed: () => {},
                icon: const Icon(Icons.edit),
              ),
            ],
          ),
          floatingActionButton: const FloatingButton(),
          body: Consumer(
            builder: (context, ref, _) {
              final partsListValue =
                  ref.watch(partsListFutureProvider(khatma.unit));
              List<int> selectedParts = ref.watch(selectedItemsNotifier);
              return AsyncValueWidget<List<Part>>(
                value: partsListValue,
                data: (parts) => ListView.separated(
                  separatorBuilder: (context, index) => const Divider(
                    height: 2,
                  ),
                  itemCount: parts.length,
                  itemBuilder: (BuildContext context, int index) {
                    var part = parts[index];
                    var isRead = khatma.completedParts!.contains(part.id);
                    return PartTile(
                      part,
                      selectedParts: selectedParts,
                      isRead: isRead,
                      ref: ref,
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class FloatingButton extends StatelessWidget {
  const FloatingButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      alignment: Alignment.bottomCenter,
      child: Consumer(builder: (context, ref, _) {
        final selectedParts = ref.watch(selectedItemsNotifier);
        return CollectionUtils.isEmpty(selectedParts)
            ? Container()
            : Center(
                child: FloatingActionButton.extended(
                  extendedTextStyle: AppTheme.getTheme().textTheme.subtitle1,
                  onPressed: () {
                    // Add your onPressed code here!
                  },
                  label: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'Marquer comme lu (${selectedParts.length})',
                    ),
                  ),
                  icon: const Icon(Icons.check),
                  backgroundColor: AppTheme.getTheme().primaryColor,
                ),
              );
      }),
    );
  }
}
