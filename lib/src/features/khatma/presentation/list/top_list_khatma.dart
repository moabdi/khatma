import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:khatma/src/common/utils/common.dart';
import 'package:khatma/src/routing/app_router.dart';
import 'package:khatma/src/themes/theme.dart';

class TopListKhatmat extends StatelessWidget {
  const TopListKhatmat({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          AppLocalizations.of(context).khatmaList,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        OutlinedButton.icon(
          icon: Icon(
            Icons.add_circle,
            color: AppTheme.primaryColors,
            size: 24,
          ),
          label: Text(AppLocalizations.of(context).add),
          onPressed: () => {
            context.goNamed(AppRoute.addKhatma.name),
          },
        ),
      ],
    );
  }
}
