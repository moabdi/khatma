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
        return "assets/images/surat.jpg";
      }

      return "assets/images/khatma/$type.png";
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(7.0),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0, bottom: 15),
        child: ListTile(
          leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: const BorderRadius.all(Radius.circular(15.0))
          ),
          child:  Image(
            image: AssetImage(getAssetImage(khatma.type?.name)),
            fit: BoxFit.contain,
          ),
        ),
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(khatma.name, style: AppTheme.getTheme().textTheme.headline6,),
              TextOrEmpty(khatma.description, style: AppTheme.getTheme().textTheme.subtitle2),
            ],
          ),
          trailing: Container(
            decoration: BoxDecoration(
              color: Colors.blueGrey.shade50,
              borderRadius: const BorderRadius.all(Radius.circular(10.0))
            ),
            child: const Icon(Icons.chevron_right_rounded)),
          onTap: onPressed,
        ),
      ),
    );
  }
}
