import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:khatma/src/routing/app_router.dart';
import 'package:khatma/src/themes/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatelessWidget {
  final bool isVisible;

  const SplashScreen({super.key, this.isVisible = true});

  static const _bgGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFECFDF5),
      Color(0xFFCCFBF1),
      Color(0xFFE0F2FE),
    ],
  );

  Future<void> _startRedirect(BuildContext context) async {
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

    return Scaffold(
      body: AnimatedOpacity(
        opacity: isVisible ? 1 : 0,
        duration: const Duration(milliseconds: 500),
        child: Container(
          color: Colors.transparent,
          child: DecoratedBox(
            decoration: const BoxDecoration(gradient: _bgGradient),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      AvatarGlow(
                        startDelay: const Duration(milliseconds: 600),
                        glowColor: Theme.of(context).colorScheme.primary,
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
                    'ختمة',
                    style: context.textTheme.displaySmall!
                        .copyWith(color: const Color(0xFF065F46)),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Khatma',
                    style: context.textTheme.headlineLarge!
                        .copyWith(color: const Color(0xFF065F46)),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Your Quran Reading Companion',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF059669),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Container(
                    width: 64,
                    height: 4,
                    decoration: BoxDecoration(
                      color: const Color(0xFF34D399),
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
