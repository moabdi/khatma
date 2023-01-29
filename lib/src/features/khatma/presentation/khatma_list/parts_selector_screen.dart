import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khatma_app/src/common_widgets/async_value_widget.dart';
import 'package:khatma_app/src/common_widgets/safe_text.dart';
import 'package:khatma_app/src/features/khatma/data/fake_khatma_repository.dart';
import 'package:khatma_app/src/features/khatma/data/parts_repository.dart';
import 'package:khatma_app/src/features/khatma/data/selected_items_notifier.dart';
import 'package:khatma_app/src/features/khatma/domain/part.dart';
import 'package:khatma_app/src/features/khatma/presentation/home_app_bar/home_app_bar.dart';
import 'package:khatma_app/src/localization/string_hardcoded.dart';
import 'package:khatma_app/src/themes/theme.dart';

class PartSelectorScreen extends ConsumerWidget {
  const PartSelectorScreen({super.key, required this.khatmaId});
  final String khatmaId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final partsListValue = ref.watch(partListFutureProvider);
    final khatmaValue = ref.watch(khatmaProvider(khatmaId));
    return Scaffold(
      appBar: const HomeAppBar(),
      floatingActionButton: Container(
        height: 50,
        alignment: Alignment.bottomCenter,
        child: FloatingActionButton.extended(
          extendedTextStyle: AppTheme.getTheme().textTheme.subtitle1,
          onPressed: () {
            // Add your onPressed code here!
          },
          label: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Marquer comme lu',
            ),
          ),
          icon: const Icon(Icons.check),
          backgroundColor: AppTheme.getTheme().primaryColor,
        ),
      ),
      body: Consumer(
        builder: (context, ref, _) {
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
                      var isIncluded = selectedParts.contains(index);
                      return ListTile(
                        // enabled: isIncluded,
                        // enableFeedback: isIncluded,
                        onLongPress: () => ref
                            .read(selectedItemsNotifier.notifier)
                            .toggleSelection(index),
                        // selected: isIncluded,
                        // selectedTileColor: Colors.grey.shade100,
                        leading: CircleAvatar(
                          backgroundColor:
                              HexColor(isIncluded ? "94A4BB" : "DCF0EC"),
                          child: Text(part.id.toString(),
                              style: AppTheme.getTheme()
                                  .textTheme
                                  .headline6!
                                  .copyWith(
                                      color: HexColor(
                                          isIncluded ? "DCF0EC" : "04AB67"))),
                        ),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SafeText(
                              part.translation, maxLength: 20,
                              // style: AppTheme.getTheme().textTheme.bodyText2,
                            ),
                            SafeText(
                              part.name, maxLength: 25,
                              // style: AppTheme.getTheme().textTheme.headline6,
                            ),
                          ],
                        ),
                        subtitle: Text(
                          part.transliteration,
                          style: AppTheme.getTheme().textTheme.subtitle2,
                        ),
                      );
                    },
                  ),
          );
        },
      ),
    );
  }
}
