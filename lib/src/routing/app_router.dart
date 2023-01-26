import 'package:khatma_app/src/features/authentication/data/fake_auth_repository.dart';
import 'package:khatma_app/src/features/authentication/presentation/account/account_screen.dart';
import 'package:khatma_app/src/features/authentication/presentation/sign_in/email_password_sign_in_screen.dart';
import 'package:khatma_app/src/features/authentication/presentation/sign_in/email_password_sign_in_state.dart';
import 'package:khatma_app/src/features/khatma/presentation/khatma_list/parts_selector_screen.dart';
import 'package:khatma_app/src/features/khatma/presentation/khatma_screen/khatma_screen.dart';
import 'package:khatma_app/src/features/khatma/presentation/khatma_list/khatmat_list_screen.dart';
import 'package:khatma_app/src/routing/go_router_refresh_stream.dart';
import 'package:khatma_app/src/routing/not_found_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

enum AppRoute {
  home,
  khatma,
  khatmaDetails,
  leaveReview,
  cart,
  checkout,
  orders,
  account,
  signIn,
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
            path: 'khatma/:id',
            name: AppRoute.khatma.name,
            builder: (context, state) {
              final khatmaId = state.params['id']!;
              return KhatmaScreen(khatmaId: khatmaId);
            },
          ),
          GoRoute(
            path: 'khatmaDetails/:id',
            name: AppRoute.khatmaDetails.name,
            builder: (context, state) {
              final khatmaId = state.params['id']!;
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
