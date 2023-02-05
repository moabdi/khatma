import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khatma/src/features/khatma/data/selected_items_notifier.dart';
import 'package:khatma/src/features/khatma/utils/collection_utils.dart';
import 'package:khatma/src/themes/theme.dart';

class PartFloatingButton extends StatelessWidget {
  const PartFloatingButton({
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
