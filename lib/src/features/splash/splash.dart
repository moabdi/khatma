import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:khatma/src/i18n/app_localizations_context.dart';
import 'package:khatma/src/routing/app_router.dart';
import 'package:khatma/src/themes/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  final bool isVisible;

  const SplashScreen({super.key, this.isVisible = true});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _hasRedirected = false;

  static const _bgGradientLight = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFFECFDF5), // Light green/mint
      Color(0xFFD1FAE5), // Lighter green
      Color(0xFFFFFFFF), // White
    ],
    stops: [0.0, 0.5, 1.0],
  );

  static const _bgGradientDark = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF1F2937), // Grey 800
      Color(0xFF111827), // Grey 900
    ],
  );

  Future<void> _startRedirect(BuildContext context) async {
    if (_hasRedirected) return;
    _hasRedirected = true;

    print('SplashScreen: Starting redirect process...');
    final prefs = await SharedPreferences.getInstance();
    final onboardingCompleted = prefs.getBool('onboarding_completed') ?? false;

    // Delay for splash effect (optional)
    await Future.delayed(const Duration(seconds: 3));

    if (!context.mounted) return;

    if (kIsWeb || onboardingCompleted) {
      context.replaceNamed(AppRoute.home.name);
    } else {
      context.replaceNamed(AppRoute.onboarding.name);
    }
  }

  Future<void> _forceRedirectAfterTimeout(BuildContext context) async {
    // Safety timeout: force redirect to home after 3 seconds if still on splash
    await Future.delayed(const Duration(seconds: 3));

    if (!context.mounted || _hasRedirected) return;

    _hasRedirected = true;
    print('SplashScreen: Force redirecting to home after timeout...');
    context.replaceNamed(AppRoute.home.name);
  }

  @override
  void initState() {
    super.initState();
    // Start the force redirect timeout immediately
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _forceRedirectAfterTimeout(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Only trigger redirect if we're actually on the splash route
    // This prevents the splash from redirecting when navigating to other routes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Check if we're still on the splash screen before redirecting
      if (context.mounted) {
        final location = GoRouter.of(context).routerDelegate.currentConfiguration.uri.path;
        // Only redirect if we're on the root path
        if (location == '/') {
          _startRedirect(context);
        }
      }
    });

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final gradient = isDark ? _bgGradientDark : _bgGradientLight;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: AnimatedOpacity(
        opacity: widget.isVisible ? 1 : 0,
        duration: const Duration(milliseconds: 500),
        child: Container(
          color: Colors.transparent,
          child: DecoratedBox(
            decoration: BoxDecoration(gradient: gradient),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      AvatarGlow(
                        startDelay: const Duration(milliseconds: 600),
                        glowColor: colorScheme.primary,
                        glowShape: BoxShape.circle,
                        glowRadiusFactor: 1.5,
                        repeat: false,
                        curve: Curves.fastOutSlowIn,
                        child: const CircleAvatar(
                          backgroundColor: Colors.transparent,
                          backgroundImage: AssetImage('assets/app-icon.png'),
                          radius: 50.0,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  Text(
                    context.loc.splashAppNameArabic,
                    style: context.textTheme.displaySmall!.copyWith(
                      color: colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    context.loc.splashAppNameLatin,
                    style: context.textTheme.headlineLarge!.copyWith(
                      color: colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    context.loc.splashTagline,
                    style: TextStyle(
                      fontSize: 18,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 32),
                  Container(
                    width: 64,
                    height: 4,
                    decoration: BoxDecoration(
                      color: colorScheme.primary,
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
