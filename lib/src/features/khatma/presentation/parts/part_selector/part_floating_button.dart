import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khatma/src/common/utils/common.dart';
import 'package:khatma/src/features/khatma/data/fake_khatma_repository.dart';
import 'package:khatma/src/features/khatma/data/khatma_notifier.dart';
import 'package:khatma/src/features/khatma/data/selected_items_notifier.dart';
import 'package:khatma/src/features/khatma/utils/collection_utils.dart';

class PartFloatingButton extends ConsumerStatefulWidget {
  const PartFloatingButton({
    super.key,
    this.khatmaId,
    required this.color,
  });
  final String? khatmaId;
  final Color? color;

  @override
  ConsumerState<PartFloatingButton> createState() => _PartFloatingButtonState();
}

class _PartFloatingButtonState extends ConsumerState<PartFloatingButton> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final selectedParts = ref.watch(selectedItemsNotifier);
    return CollectionUtils.isEmpty(selectedParts)
        ? Container()
        : Container(
            width: MediaQuery.of(context).size.width * .9,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(.5),
                  spreadRadius: 10,
                  blurRadius: 100,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: ElevatedButton.icon(
              onPressed: () => _onSubmit(context, ref, selectedParts),
              style:
                  ElevatedButton.styleFrom(padding: const EdgeInsets.all(16.0)),
              icon: _isLoading
                  ? const CircularProgressIndicator(
                      color: Colors.white, strokeWidth: 3)
                  : const Icon(Icons.check, size: 18),
              label: Text(AppLocalizations.of(context)
                  .completeParts(selectedParts.length)),
            ),
          );
  }

  _onSubmit(BuildContext context, WidgetRef ref, List<int> selectedParts) {
    setState(() => _isLoading = true);
    ref
        .read(khatmasRepositoryProvider)
        .markAsRead(widget.khatmaId, selectedParts);
    ref.read(formKhatmaProvider).markPartAsRead(selectedParts);
    ref.read(selectedItemsNotifier.notifier).initSelection([]);
    setState(() => _isLoading = false);
  }
}
