import 'package:firebase_auth/firebase_auth.dart';
import 'package:khatma/src/features/authentication/presentation/sign_in/custom_sign_in_screen.dart';
import 'package:khatma/src/features/authentication/presentation/account/account_screen.dart';
import 'package:khatma/src/features/khatma/presentation/form/providers/khatma_form_provider.dart';
import 'package:khatma/src/features/khatma/presentation/read/khatma_read_screen.dart';
import 'package:khatma/src/features/home/presentation/home_page.dart';
import 'package:khatma/src/features/khatma/presentation/form/khatma_form_screen.dart';
import 'package:khatma/src/features/mushaf/presentations/moushaf_screen.dart';
import 'package:khatma/src/routing/go_router_refresh_stream.dart';
import 'package:khatma/src/routing/not_found_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

enum AppRoute {
  home,
  addKhatma,
  editKhatma,
  khatmaDetails,
  account,
  signIn,
  quran,
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
    /* redirect: (context, state) {
      final isLoggedIn = firebaseAuth.currentUser != null;
      final path = state.uri.path;
      if (!isLoggedIn) {
        return '/sign-in';
      } else if (path == '/sign-in') {
        return '/';
      }
      return null;
    }, */
    routes: [
      GoRoute(
        path: '/',
        name: AppRoute.home.name,
        builder: (context, state) => const KhatmatListScreen(),
        routes: [
          GoRoute(
            path: 'quran/:idSourat/:idVerset',
            name: AppRoute.quran.name,
            builder: (context, state) {
              final idSourat = int.parse(state.pathParameters['idSourat']!);
              final idVerset = int.parse(state.pathParameters['idVerset']!);
              return MoushafScreen(
                idSourat: idSourat,
                idVerse: idVerset,
              );
            },
          ),
          GoRoute(
            path: 'khatma/create',
            name: AppRoute.addKhatma.name,
            builder: (context, state) {
              ref.invalidate(formKhatmaProvider);
              return AddKhatmaScreen();
            },
          ),
          GoRoute(
            path: 'khatma/:id',
            name: AppRoute.khatmaDetails.name,
            builder: (context, state) {
              final khatmaId = state.pathParameters['id']!;
              return KhatmaReadScreen(khatmaId: khatmaId);
            },
            routes: [
              GoRoute(
                path: 'edit',
                name: AppRoute.editKhatma.name,
                builder: (context, state) {
                  final khatmaId = state.pathParameters['id']!;
                  return AddKhatmaScreen(khatmaId: khatmaId);
                },
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: '/profile',
        name: AppRoute.account.name,
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          fullscreenDialog: true,
          child: const AccountScreen(),
        ),
      ),
      GoRoute(
        path: '/sign-in',
        name: AppRoute.signIn.name,
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          fullscreenDialog: true,
          child: CustomSignInScreen(),
        ),
      ),
    ],
    errorBuilder: (context, state) => const NotFoundScreen(),
  );
});
