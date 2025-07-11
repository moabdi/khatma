import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:khatma/src/routing/app_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  final bool isVisible;

  const SplashScreen({Key? key, this.isVisible = true}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  static const _bgGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFECFDF5),
      Color(0xFFCCFBF1),
      Color(0xFFE0F2FE),
    ],
  );
  @override
  void initState() {
    super.initState();
    _startRedirect();
  }

  Future<void> _startRedirect() async {
    final prefs = await SharedPreferences.getInstance();
    final onboardingCompleted = prefs.getBool('onboarding_completed') ?? false;

    // Delay for splash effect (optional)
    await Future.delayed(const Duration(seconds: 3));

    if (!mounted) return;

    if (kIsWeb) {
      context.goNamed(AppRoute.home.name);
    } else if (onboardingCompleted) {
      context.goNamed(AppRoute.home.name);
    } else {
      context.goNamed(AppRoute.onboarding.name);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedOpacity(
        opacity: widget.isVisible ? 1 : 0,
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
                        glowColor: Theme.of(context).primaryColor,
                        glowShape: BoxShape.circle,
                        glowRadiusFactor: 1.5,
                        repeat: false,
                        curve: Curves.fastOutSlowIn,
                        child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          backgroundImage: AssetImage('assets/app-icon.png'),
                          radius: 50.0,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  const Text(
                    'ختمة',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF065F46),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Khatma',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF047857),
                    ),
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
