import 'package:flutter/material.dart';
import 'package:khatma/src/features/khatma/domain/khatma_domain.dart';
import 'package:khatma/src/i18n/app_localizations_context.dart';
import 'package:khatma/src/utils/duration_formatter.dart';
import 'package:khatma_ui/constants/app_sizes.dart';
import 'package:khatma/src/features/khatma/personal/presentation/form/ui/khatma_images.dart';

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
      hoverColor: khatma.style.hexColor.withAlpha(26),
      leading: SizedBox(
        width: 40,
        child: CircleAvatar(
          backgroundColor: khatma.style.hexColor.withAlpha(26),
          child: getIcon(khatma.style.icon, color: khatma.style.hexColor),
        ),
      ),
      title: Text(khatma.name),
      subtitle: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          gapH4,
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.schedule,
                size: 14,
                color: Theme.of(context).listTileTheme.subtitleTextStyle!.color,
              ),
              gapW4,
              Text(formatDateAsTextDuration(
                  context.loc, khatma.lastRead ?? khatma.createDate)),
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
