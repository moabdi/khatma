import 'package:firebase_auth/firebase_auth.dart';
import 'package:khatma/src/features/info/info_routes.dart';
import 'package:khatma/src/features/khatma/personal/personal_khatma_routes.dart';
import 'package:khatma/src/features/onboarding/onboarding_screen.dart';
import 'package:khatma/src/features/profil/profile_routes.dart';
import 'package:khatma/src/features/quran/quran_routes.dart';
import 'package:khatma/src/features/shared_khatma/domain/shared_khatma.dart';
import 'package:khatma/src/features/shared_khatma/presentation/khatma_details_page.dart';
import 'package:khatma/src/features/shared_khatma/presentation/khatma_search_screen.dart';
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
  account,
  khatmaSearchDetails,
  khatmaSearch,
  personalKhatma,
  sync,
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
            builder: (context, state) => const KhatmaSearchScreen(),
          ),
          ...khatmaRoutes(ref),
          ...profileRoutes,
          ...quranRoutes,
          ...infoRoutes,
          GoRoute(
            path: 'khatma-search',
            name: AppRoute.khatmaSearch.name,
            builder: (context, state) => const KhatmaSearchScreen(),
          ),
          GoRoute(
            path: 'khatma-search-details/:id',
            name: AppRoute.khatmaSearchDetails.name,
            builder: (context, state) {
              final khatmaId = state.pathParameters['id']!;
              final SharedKhatma? khatma = state.extra as SharedKhatma?;

              if (khatma != null) {
                return KhatmaDetailsPage(khatma: khatma);
              }
              return NotFoundScreen();
            },
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) =>
        NotFoundScreen(errorMessage: state.error.toString()),
  );
});
