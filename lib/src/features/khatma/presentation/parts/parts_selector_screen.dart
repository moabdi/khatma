import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khatma/src/common/utils/common.dart';
import 'package:khatma/src/common/utils/string_utils.dart';
import 'package:khatma/src/common/widgets/async_value_widget.dart';
import 'package:khatma/src/common/constants/app_sizes.dart';
import 'package:khatma/src/common/widgets/avatar.dart';
import 'package:khatma/src/common/widgets/safe_text.dart';
import 'package:khatma/src/features/khatma/data/fake_khatma_repository.dart';
import 'package:khatma/src/features/khatma/data/parts_repository.dart';
import 'package:khatma/src/features/khatma/data/selected_items_notifier.dart';
import 'package:khatma/src/features/khatma/domain/khatma.dart';
import 'package:khatma/src/features/khatma/domain/part.dart';
import 'package:khatma/src/common/widgets/k_app_bar.dart';
import 'package:khatma/src/features/khatma/presentation/common/khatma_images.dart';
import 'package:khatma/src/features/khatma/presentation/common/khatma_utils.dart';
import 'package:khatma/src/features/khatma/presentation/parts/part_selector/part_floating_button.dart';
import 'package:khatma/src/features/khatma/presentation/parts/part_selector/part_tile.dart';
import 'package:khatma/src/features/khatma/presentation/parts/part_selector/read_tiles.dart';
import 'package:khatma/src/features/khatma/presentation/parts/part_selector/unread_tiles.dart';

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
          appBar: KAppBar(
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
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: PartFloatingButton(
            khatmaId: khatma!.id,
            color: khatma.style.hexColor,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  khatma.description?.isNotEmpty == true
                      ? Card(
                          elevation: 0.5,
                          clipBehavior: Clip.antiAlias,
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: ListTile(
                              tileColor: Colors.transparent,
                              subtitle: Text(
                                khatma.description ?? '',
                                style: Theme.of(context).textTheme.bodySmall,
                                textAlign: TextAlign.justify,
                              ),
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                  gapH8,
                  Card(
                    elevation: 0.5,
                    clipBehavior: Clip.antiAlias,
                    child: ExpansionTile(
                      title: const Text('Completed parts'),
                      subtitle: const Text('12 parts completed'),
                      trailing: const Icon(Icons.arrow_drop_down_circle),
                      children: <Widget>[
                        ReadPartTiles(
                          unit: khatma.unit,
                          color: khatma.style.hexColor,
                          completedParts: khatma.completedParts,
                        ),
                      ],
                    ),
                  ),
                  Card(
                    elevation: 0.4,
                    clipBehavior: Clip.antiAlias,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: UnreadPartTiles(
                        unit: khatma.unit,
                        color: khatma.style.hexColor,
                        completedParts: khatma.completedParts,
                      ),
                    ),
                  ),
                  gapH64,
                ],
              ),
            ),
          ),
        ),
      ),
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
