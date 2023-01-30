import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khatma_app/src/common_widgets/async_value_widget.dart';
import 'package:khatma_app/src/common_widgets/safe_text.dart';
import 'package:khatma_app/src/features/khatma/data/fake_khatma_repository.dart';
import 'package:khatma_app/src/features/khatma/data/parts_repository.dart';
import 'package:khatma_app/src/features/khatma/data/selected_items_notifier.dart';
import 'package:khatma_app/src/features/khatma/domain/khatma.dart';
import 'package:khatma_app/src/features/khatma/domain/part.dart';
import 'package:khatma_app/src/features/khatma/presentation/home_app_bar/home_app_bar.dart';
import 'package:khatma_app/src/features/khatma/utils/collection_utils.dart';
import 'package:khatma_app/src/localization/string_hardcoded.dart';
import 'package:khatma_app/src/themes/theme.dart';

class PartSelectorScreen extends ConsumerWidget {
  const PartSelectorScreen({super.key, required this.khatmaId});
  final String khatmaId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final khatmaValue = ref.watch(khatmaProvider(khatmaId));
    return AsyncValueWidget<Khatma?>(
      value: khatmaValue,
      data: (khatma) => Scaffold(
        appBar: HomeAppBar(title: khatma!.name),
        floatingActionButton: const FloatingButton(),
        body: Consumer(
          builder: (context, ref, _) {
            final partsListValue =
                ref.watch(partsListFutureProvider(khatma.unit));
            List<int> selectedParts = ref.watch(selectedItemsNotifier);
            return AsyncValueWidget<List<Part>>(
              value: partsListValue,
              data: (parts) => parts.isEmpty
                  ? Text(
                      'Cannot loading parts...'.hardcoded,
                      style: Theme.of(context).textTheme.headline4,
                    )
                  : ListView.separated(
                      separatorBuilder: (context, index) => const Divider(
                        height: 2,
                      ),
                      itemCount: parts.length,
                      itemBuilder: (BuildContext context, int index) {
                        var part = parts[index];
                        var isRead = khatma.completedParts!.contains(part.id);
                        return PartListeTile(
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
            : FloatingActionButton.extended(
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
              );
      }),
    );
  }
}

class PartListeTile extends StatelessWidget {
  const PartListeTile(this.part,
      {super.key, this.ref, this.selectedParts, this.isRead = false});

  final List<int>? selectedParts;
  final Part part;
  final WidgetRef? ref;
  final bool isRead;

  @override
  Widget build(BuildContext context) {
    bool isSelected = selectedParts != null && selectedParts!.contains(part.id);
    return ListTile(
      enabled: !isRead,
      selected: isSelected,
      //enableFeedback: isSelected,
      selectedTileColor: isRead
          ? AppTheme.getTheme().disabledColor
          : isSelected
              ? AppTheme.getTheme().primaryColor.withOpacity(0.13)
              : null,
      onLongPress: () => isRead
          ? null
          : ref?.read(selectedItemsNotifier.notifier).toggleSelection(part.id),
      onTap: () => CollectionUtils.isNotEmpty(selectedParts)
          ? ref?.read(selectedItemsNotifier.notifier).toggleSelection(part.id)
          : null,
      leading: CircleAvatar(
        backgroundColor: isRead
            ? AppTheme.getTheme().disabledColor
            : isSelected
                ? AppTheme.getTheme().primaryColor
                : AppTheme.getTheme().primaryColor.withOpacity(.1),
        child: Text(part.id.toString(),
            style: AppTheme.getTheme().textTheme.headline6!.copyWith(
                color: isRead
                    ? null
                    : isSelected
                        ? AppTheme.getTheme().backgroundColor
                        : AppTheme.getTheme().primaryColor)),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SafeText(
            part.translation,
            maxLength: 20,
            style: isRead ? AppTheme.getTheme().textTheme.subtitle1 : null,
          ),
          SafeText(
            part.name,
            maxLength: 25,
            style: isRead ? AppTheme.getTheme().textTheme.subtitle1 : null,
          ),
        ],
      ),
      subtitle: Text(
        part.transliteration,
        style: AppTheme.getTheme().textTheme.subtitle2,
      ),
    );
  }
}
