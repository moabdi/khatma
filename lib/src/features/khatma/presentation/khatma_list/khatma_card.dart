import 'package:khatma_app/src/common_widgets/text_or_empty.dart';
import 'package:flutter/material.dart';
import 'package:khatma_app/src/constants/app_sizes.dart';
import 'package:khatma_app/src/features/khatma/domain/khatma.dart';
import 'package:khatma_app/src/features/khatma/utils/image_utils.dart';
import 'package:khatma_app/src/themes/theme.dart';

/// Used to show a single khatma inside a card.
class KhatmaCard extends StatelessWidget {
  const KhatmaCard({super.key, required this.khatma, this.onPressed});
  final Khatma khatma;
  final VoidCallback? onPressed;

  // * Keys for testing using find.byKey()
  static const khatmaCardKey = Key('khatma-card');

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: AppTheme.getTheme().disabledColor,
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(7.0),
        side: BorderSide(
          color: AppTheme.getTheme().disabledColor,
          width: 1.0,
        ),
      ),
      child: SizedBox(
        height: 100,
        child: KhatmaTile(khatma: khatma, onPressed: onPressed),
      ),
    );
  }
}

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
      contentPadding: const EdgeInsets.all(10),
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15.0))),
        child: Image(
          image: AssetImage(ImageUtils.getAssetImage(khatma.type.name)),
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
          TextOrEmpty("Dérniere lecture: hier",
              style: AppTheme.getTheme().textTheme.subtitle2),
          gapH12,
          KhatmaCompletude(khatma: khatma),
          gapH4,
          ProgressIndicator(khatma: khatma),
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

class KhatmaCompletude extends StatelessWidget {
  const KhatmaCompletude({
    super.key,
    required this.khatma,
  });

  final Khatma khatma;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          khatma.name,
          style: AppTheme.getTheme().textTheme.subtitle1,
        ),
        Text(
          khatma.completude <= 0
              ? ""
              : "${(khatma.completude * 100).toStringAsFixed(0)}%",
          style: AppTheme.getTheme().textTheme.subtitle2,
        ),
      ],
    );
  }
}

class ProgressIndicator extends StatelessWidget {
  const ProgressIndicator({
    super.key,
    required this.khatma,
  });

  final Khatma khatma;

  @override
  Widget build(BuildContext context) {
    // for visibility
    double opacity = khatma.completude < .3 ? 0.3 : khatma.completude;
    return LinearProgressIndicator(
      backgroundColor: AppTheme.getTheme().disabledColor.withOpacity(.8),
      valueColor: AlwaysStoppedAnimation<Color>(
          AppTheme.getTheme().primaryColor.withOpacity(opacity)),
      value: khatma.completude,
    );
  }
}
