import 'package:flutter/material.dart';
import 'package:khatma/src/common/constants/app_sizes.dart';
import 'package:khatma/src/themes/theme.dart';

class TopBarBottomSheet extends StatelessWidget {
  const TopBarBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        gapH16,
        Center(
          child: Container(
            width: 40,
            padding: const EdgeInsets.only(bottom: 20.0),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: AppTheme.getTheme().dividerColor,
                  width: 3.5,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: InkWell(
            hoverColor: Colors.transparent,
            child: Container(
              width: 30,
              height: 30,
              padding: const EdgeInsets.all(0),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(50.0)),
                color: AppTheme.getTheme().disabledColor,
              ),
              child: const Icon(Icons.close, size: 18, color: Colors.blueGrey),
            ),
            onTap: () => Navigator.of(context).pop(),
          ),
        ),
      ],
    );
  }
}
