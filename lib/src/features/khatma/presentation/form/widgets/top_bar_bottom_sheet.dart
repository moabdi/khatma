import 'package:flutter/material.dart';
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
        Center(
          child: Padding(
            padding:
                const EdgeInsets.only(bottom: 5, top: 10, left: 10, right: 10),
            child: Container(
              width: 49,
              height: 5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(45),
                color: AppTheme.getTheme().dividerColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
