import 'package:flutter/material.dart';
import 'package:khatma/src/common/utils/duration_formatter.dart';
import 'package:khatma/src/common/widgets/avatar.dart';
import 'package:khatma/src/common/widgets/text_or_empty.dart';
import 'package:khatma/src/common/constants/app_sizes.dart';
import 'package:khatma/src/features/khatma/domain/khatma.dart';
import 'package:khatma/src/features/khatma/presentation/common/enum_extension.dart';
import 'package:khatma/src/features/khatma/presentation/common/khatma_images.dart';
import 'package:khatma/src/features/khatma/presentation/common/khatma_utils.dart';
import 'package:khatma/src/themes/theme.dart';

import 'khatma_completude.dart';

class KhatmaTile extends StatelessWidget {
  const KhatmaTile({
    super.key,
    required this.khatma,
    required this.onPressed,
  });

  final Khatma khatma;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
      hoverColor: khatma.style.hexColor.withOpacity(.1),
      leading: CircleAvatar(
        backgroundColor: khatma.style.hexColor.withOpacity(.1),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: getIcon(khatma.style.icon, color: khatma.style.hexColor),
        ),
      ),
      title: Text(khatma.name),
      subtitle: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          gapH4,
          Row(
            children: [
              Icon(
                Icons.schedule,
                size: 14,
                color: Theme.of(context).listTileTheme.subtitleTextStyle!.color,
              ),
              gapW4,
              Text(formatDateAsTextDuration(
                  khatma.lastRead ?? khatma.createDate)),
            ],
          ),
          gapH12,
          KhatmaCompletude(khatma: khatma),
          gapH4,
        ],
      ),
      trailing: Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          child: const Icon(Icons.chevron_right_rounded)),
      onTap: onPressed,
    );
  }
}
