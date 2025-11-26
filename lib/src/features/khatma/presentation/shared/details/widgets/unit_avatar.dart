import 'package:flutter/material.dart';
import 'package:khatma/src/features/khatma/presentation/shared/utils/user_color_generator.dart';
import 'package:khatma/src/themes/theme.dart';

class UnitAvatar extends StatelessWidget {
  const UnitAvatar({
    super.key,
    required this.unitNumber,
    required this.backgroundColor,
    required this.borderColor,
    required this.numberColor,
    this.isSelected = false,
    this.userId,
    this.userName,
    this.userPhotoUrl,
  });

  final int unitNumber;
  final Color backgroundColor;
  final Color borderColor;
  final Color numberColor;
  final bool isSelected;
  final String? userId;
  final String? userName;
  final String? userPhotoUrl;

  @override
  Widget build(BuildContext context) {
    // If user info is provided (reserved unit), show user avatar
    if (userId != null && userName != null) {
      final userColor = UserColorGenerator.getColorForUser(userId!);

      return Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: userColor.withValues(alpha: 0.4),
                  blurRadius: 6,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: CircleAvatar(
              radius: 24,
              backgroundColor: userColor,
              backgroundImage: userPhotoUrl != null
                  ? NetworkImage(userPhotoUrl!)
                  : null,
              child: userPhotoUrl == null
                  ? Text(
                      userName!.substring(0, 1).toUpperCase(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    )
                  : null,
            ),
          ),
          // Show checkmark if selected
          if (isSelected)
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: context.colorScheme.primary.withValues(alpha: 0.9),
                ),
                child: Icon(
                  Icons.check,
                  size: 24,
                  color: context.colorScheme.onPrimary,
                ),
              ),
            ),
        ],
      );
    }

    // Otherwise, show unit number (free unit)
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: isSelected ? context.colorScheme.primary : backgroundColor,
        borderRadius: BorderRadius.circular(50),
        border: Border.all(
          color: isSelected
              ? context.colorScheme.primary
              : borderColor.withValues(alpha: 0.3),
          width: 1.5,
        ),
      ),
      child: Center(
        child: isSelected
            ? Icon(
                Icons.check,
                size: 24,
                color: context.colorScheme.onPrimary,
              )
            : Text(
                '$unitNumber',
                style: context.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: numberColor,
                ),
              ),
      ),
    );
  }
}
