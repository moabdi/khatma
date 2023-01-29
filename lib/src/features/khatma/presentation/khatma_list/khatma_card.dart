import 'dart:math';

import 'package:khatma_app/src/common_widgets/text_or_empty.dart';
import 'package:khatma_app/src/localization/string_hardcoded.dart';
import 'package:flutter/material.dart';
import 'package:khatma_app/src/constants/app_sizes.dart';
import 'package:khatma_app/src/features/khatma/domain/khatma.dart';
import 'package:khatma_app/src/themes/theme.dart';

/// Used to show a single khatma inside a card.
class KhatmaCard extends StatelessWidget {
  const KhatmaCard({super.key, required this.khatma, this.onPressed});
  final Khatma khatma;
  final VoidCallback? onPressed;

  // * Keys for testing using find.byKey()
  static const khatmaCardKey = Key('khatma-card');

  String getAssetImage(String? type){
      if(type == null) {
        return "assets/images/khatma/khatma.png";
      }

      return "assets/images/khatma/$type.png";
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: HexColor("F5F5F8"),
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(7.0),
        side: BorderSide(
          color: HexColor("F5F5F8"),
          width: 1.0,
        ),
      ),
      child: Container(
        height: 100,
        child: ListTile(
          contentPadding: const EdgeInsets.all(10),
          leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15.0))
          ),
          child:  Image(
            image: AssetImage(getAssetImage(khatma.type?.name)),
            fit: BoxFit.contain,
          ),
        ),
          title: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(khatma.name, style: AppTheme.getTheme().textTheme.headline6,),
              TextOrEmpty("Dérniere lecture 12/212/22", style: AppTheme.getTheme().textTheme.subtitle2),
              gapH12,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(khatma.name, style: AppTheme.getTheme().textTheme.subtitle1,),
                  Text((khatma.completude * 100).toStringAsFixed(0) +"%", style: AppTheme.getTheme().textTheme.subtitle2,),
                ],
              ),
              gapH4,
              LinearProgressIndicator(
                backgroundColor: AppTheme.getTheme().disabledColor.withOpacity(.8),
                valueColor: AlwaysStoppedAnimation<Color>(AppTheme.getTheme().primaryColor.withOpacity(khatma.completude)),
                value: khatma.completude,
              ),
            ],
          ),
          trailing: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10.0))
            ),
            child: const Icon(Icons.chevron_right_rounded)),
          onTap: onPressed,
        ),
      ),
    );
  }
}
