import 'package:firebase_auth/firebase_auth.dart';
import 'package:khatma/src/features/info/info_routes.dart';
import 'package:khatma/src/features/khatma/khatma_routes.dart';
import 'package:khatma/src/features/home/presentation/home_page.dart';
import 'package:khatma/src/features/onboarding/onboarding_screen.dart';
import 'package:khatma/src/features/profil/profile_routes.dart';
import 'package:khatma/src/features/quran/quran_routes.dart';
import 'package:khatma/src/features/splash/splash.dart';
import 'package:khatma/src/routing/go_router_refresh_stream.dart';
import 'package:khatma/src/routing/not_found_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

enum AppRoute {
  home,
  addKhatma,
  editKhatma,
  khatmaDetails,
  profil,
  login,
  register,
  forgotPassword,
  createPassword,
  quran,
  mentionsLegales,
  cgu,
  aboutUs,
  declarationDonnees,
  faq,
  contact,
  settings,
  languages,
  theme,
  recitation,
  khatma,
  douaaKhatm,
  onboarding,
  splash,
  link,
}

final firebaseAuthProvier = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});

final goRouterProvider = Provider<GoRouter>((ref) {
  final firebaseAuth = ref.watch(firebaseAuthProvier);
  return GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: false,
    refreshListenable: GoRouterRefreshStream(firebaseAuth.authStateChanges()),
    routes: [
      GoRoute(
        path: '/',
        name: AppRoute.splash.name,
        builder: (context, state) => const SplashScreen(),
        routes: [
          GoRoute(
            name: AppRoute.onboarding.name,
            path: 'onboarding',
            builder: (context, state) => const OnboardingScreen(),
          ),
          GoRoute(
            name: AppRoute.link.name,
            path: 'link',
            builder: (context, state) => const SplashScreen(),
          ),
          GoRoute(
            name: AppRoute.home.name,
            path: 'khatmat',
            builder: (context, state) => const KhatmatListScreen(),
          ),
          ...khatmaRoutes(ref),
          ...profileRoutes,
          ...quranRoutes,
          ...infoRoutes,
        ],
      ),
    ],
    errorBuilder: (context, state) =>
        NotFoundScreen(errorMessage: state.error.toString()),
  );
});
