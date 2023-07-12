import 'package:flutter/material.dart';
import 'package:khatma/src/common/utils/duration_formatter.dart';
import 'package:khatma/src/common/widgets/text_or_empty.dart';
import 'package:khatma/src/common/constants/app_sizes.dart';
import 'package:khatma/src/features/khatma/domain/khatma.dart';
import 'package:khatma/src/features/khatma/utils/image_utils.dart';
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
      hoverColor: AppTheme.getTheme().primaryColor.withOpacity(.2),
      contentPadding: const EdgeInsets.all(10),
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15.0))),
        child: Image(
          image: AssetImage(ImageUtils.getAssetImage(khatma.name)),
          fit: BoxFit.contain,
        ),
      ),
      title: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            khatma.name,
            style: AppTheme.getTheme().textTheme.headline6,
          ),
          Row(
            children: [
              Icon(
                Icons.schedule,
                size: 14,
                color: AppTheme.getTheme().textTheme.subtitle2!.color,
              ),
              gapW4,
              TextOrEmpty(
                  formatDateAsTextDuration(
                      khatma.lastRead ?? khatma.createDate),
                  style: AppTheme.getTheme().textTheme.subtitle2),
            ],
          ),
          gapH12,
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
