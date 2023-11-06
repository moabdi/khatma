import 'package:flutter/material.dart';
import 'package:khatma/src/common/utils/duration_formatter.dart';
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
      hoverColor: khatma.style.hexColor.withOpacity(.1),
      contentPadding: const EdgeInsets.all(5),
      leading: CircleAvatar(
        backgroundColor: khatma.style.hexColor.withOpacity(.1),
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: getImage(khatma.style.icon, color: khatma.style.hexColor),
        ),
      ),
      title: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                khatma.name,
                style: AppTheme.getTheme().textTheme.bodyLarge,
              ),
              gapW4,
              Icon(
                khatma.share.icon,
                size: 13,
                color: Colors.blueGrey.shade200,
              ),
            ],
          ),
          gapH4,
          Row(
            children: [
              Icon(
                Icons.schedule,
                size: 14,
                color: AppTheme.getTheme().textTheme.bodySmall!.color,
              ),
              gapW4,
              TextOrEmpty(
                  formatDateAsTextDuration(
                      khatma.lastRead ?? khatma.createDate),
                  style: AppTheme.getTheme().textTheme.bodyMedium),
            ],
          ),
          gapH8,
          KhatmaCompletude(khatma: khatma),
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
