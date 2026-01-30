import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:khatma/src/routing/app_router.dart';
import 'package:khatma/src/themes/theme.dart';
import 'package:khatma_ui/constants/app_sizes.dart';

class WelcomeHome extends StatelessWidget {
  const WelcomeHome({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final maxContentWidth = screenWidth > 600 ? 500.0 : double.infinity;

    // Force dark theme for this widget
    final darkTheme = AppTheme.dark;
    final colorScheme = darkTheme.colorScheme;
    final textTheme = darkTheme.textTheme;

    return Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          colorScheme.primaryContainer,
          colorScheme.tertiaryContainer,
        ],
      ),
    ),
    child: Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxContentWidth),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Icon with glass effect
                Container(
                  width: 100,
                  height: 100,
                  child: Image(image: AssetImage('assets/images/hifdz.png')),
                ),
                gapH20,
                // Title
                Text(
                  'Achevez le Coran\nensemble',
                  textAlign: TextAlign.center,
                  style: textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onPrimaryContainer,
                    height: 1.2,
                  ),
                ),
                gapH32,
                // Subtitle
                Text(
                  'Créez ou rejoignez une khatma pour lire le Coran ensemble.',
                  textAlign: TextAlign.center,
                  style: textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onPrimaryContainer.withAlpha(204),
                    height: 1.3,
                  ),
                ),
                gapH24,
                // Action buttons
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      // Primary button - Create Khatma
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            context.goNamed(AppRoute.addKhatma.name);
                          },
                          icon: Icon(Icons.add_circle_outline, size: 20, color: colorScheme.onPrimaryContainer),
                          label: Text(
                            'Créer une Khatma',
                            style: textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      gapH12,
                      // Two inline buttons
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton.icon(
                              style: OutlinedButton.styleFrom(
                                //foregroundColor: colorScheme.primary,
                                padding: const EdgeInsets.symmetric(vertical: 12),
                                side: BorderSide(color: colorScheme.primary, width: 1.5),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onPressed: () {
                                context.pushNamed(AppRoute.khatmaSearch.name);
                              },
                              icon: Icon(Icons.people_outline, size: 18, color: colorScheme.onPrimaryContainer),
                              label: Text(
                                'Rejoindre',
                                style: textTheme.labelLarge?.copyWith(
                                  color: colorScheme.onPrimaryContainer,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          gapW8, ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: screenHeight * 0.2),
              ],
            ),
          ),
        ),
      ),
      ),
    );
  }
}
