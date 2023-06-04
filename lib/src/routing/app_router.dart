import 'package:khatma/src/features/authentication/data/fake_auth_repository.dart';
import 'package:khatma/src/features/authentication/presentation/account/account_screen.dart';
import 'package:khatma/src/features/authentication/presentation/sign_in/email_password_sign_in_screen.dart';
import 'package:khatma/src/features/authentication/presentation/sign_in/email_password_sign_in_state.dart';
import 'package:khatma/src/features/khatma/presentation/khatma_parts_screen/parts_selector_screen.dart';
import 'package:khatma/src/features/khatma/presentation/khatma_screen/bottom.dart';
import 'package:khatma/src/features/khatma/presentation/khatma_list_screen/khatmat_list_screen.dart';
import 'package:khatma/src/features/khatma/presentation/khatma_screen/home_screen.dart';
import 'package:khatma/src/features/khatma/presentation/khatma_screen/khatma_screen.dart';
import 'package:khatma/src/features/mushaf/presentations/moushaf_screen.dart';
import 'package:khatma/src/routing/go_router_refresh_stream.dart';
import 'package:khatma/src/routing/not_found_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

enum AppRoute {
  home,
  khatma,
  khatmaDetails,
  account,
  signIn,
  quran,
}

final goRouterProvider = Provider<GoRouter>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: false,
    refreshListenable: GoRouterRefreshStream(authRepository.authStateChanges()),
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
            name: AppRoute.khatma.name,
            builder: (context, state) {
              return AddKhatmaScreen();
            },
          ),
          GoRoute(
            path: 'khatma-parts/:id',
            name: AppRoute.khatmaDetails.name,
            builder: (context, state) {
              final khatmaId = state.pathParameters['id']!;
              return PartSelectorScreen(khatmaId: khatmaId);
            },
          ),
          GoRoute(
            path: 'account',
            name: AppRoute.account.name,
            pageBuilder: (context, state) => MaterialPage(
              key: state.pageKey,
              fullscreenDialog: true,
              child: const AccountScreen(),
            ),
          ),
          GoRoute(
            path: 'signIn',
            name: AppRoute.signIn.name,
            pageBuilder: (context, state) => MaterialPage(
              key: state.pageKey,
              fullscreenDialog: true,
              child: const EmailPasswordSignInScreen(
                formType: EmailPasswordSignInFormType.signIn,
              ),
            ),
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) => const NotFoundScreen(),
  );
});
