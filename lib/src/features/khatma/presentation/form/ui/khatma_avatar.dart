import 'package:flutter/material.dart';
import 'package:khatma/src/features/khatma/domain/khatma_domain.dart';
import 'package:khatma/src/features/khatma/presentation/form/ui/khatma_images.dart';

class KhatmaAvatar extends StatelessWidget {
  const KhatmaAvatar({
    super.key,
    required this.khatma,
    required this.onTap,
    this.size = 80,
    this.showEditIndicator = true,
  });

  final Khatma khatma;
  final VoidCallback onTap;
  final double size;
  final bool showEditIndicator;

  @override
  Widget build(BuildContext context) {
    final themeColor = khatma.style.hexColor;
    final iconSize = size * 0.5; // Icon is 50% of container size
    final editIndicatorSize =
        size * 0.3; // Edit indicator is 30% of container size

    return Center(
      child: GestureDetector(
        onTap: onTap,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Main avatar container
            Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: themeColor.withOpacity(0.2),
                border: Border.all(
                  color: themeColor.withOpacity(0.3),
                  width: 2,
                ),
              ),
              child: Center(
                child: getIcon(
                  khatma.style.icon,
                  color: themeColor,
                  size: iconSize,
                ),
              ),
            ),

            // Edit indicator (brush icon)
            if (showEditIndicator)
              Positioned(
                bottom: size * 0.05,
                right: size * 0.05,
                child: Container(
                  width: editIndicatorSize,
                  height: editIndicatorSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: themeColor,
                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.edit,
                    size: editIndicatorSize * 0.5,
                    color: Colors.white,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// Alternative Material Design version
class KhatmaAvatarMaterial extends StatelessWidget {
  const KhatmaAvatarMaterial({
    super.key,
    required this.khatma,
    required this.onTap,
    this.size = 80,
    this.showEditIndicator = true,
  });

  final Khatma khatma;
  final VoidCallback onTap;
  final double size;
  final bool showEditIndicator;

  @override
  Widget build(BuildContext context) {
    final themeColor = khatma.style.hexColor;
    final iconSize = size * 0.45;
    final editIndicatorRadius = size * 0.125;

    return Center(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(size / 2),
          onTap: onTap,
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: themeColor.withOpacity(0.15),
              border: Border.all(
                color: themeColor.withOpacity(0.4),
                width: 2,
              ),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Main icon
                getIcon(
                  khatma.style.icon,
                  color: themeColor,
                  size: iconSize,
                ),

                // Edit badge
                if (showEditIndicator)
                  Positioned(
                    bottom: size * 0.025,
                    right: size * 0.025,
                    child: CircleAvatar(
                      radius: editIndicatorRadius,
                      backgroundColor: themeColor,
                      child: Icon(
                        Icons.brush_outlined,
                        size: editIndicatorRadius,
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
