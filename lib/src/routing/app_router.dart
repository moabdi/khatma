import 'package:firebase_auth/firebase_auth.dart';
import 'package:khatma/src/common/widgets/markdown_reader.dart';
import 'package:khatma/src/features/authentication/presentation/sign_in/custom_sign_in_screen.dart';
import 'package:khatma/src/features/authentication/presentation/account/account_screen.dart';
import 'package:khatma/src/features/khatma/presentation/form/providers/khatma_form_provider.dart';
import 'package:khatma/src/features/khatma/presentation/read/khatma_read_screen.dart';
import 'package:khatma/src/features/home/presentation/home_page.dart';
import 'package:khatma/src/features/khatma/presentation/form/khatma_form_screen.dart';
import 'package:khatma/src/features/mushaf/presentations/moushaf_screen.dart';
import 'package:khatma/src/features/info/contact.dart';
import 'package:khatma/src/features/authentication/presentation/password/create_password_page.dart';
import 'package:khatma/src/features/info/faq_page.dart';
import 'package:khatma/src/features/authentication/presentation/password/forgot_password_page.dart';
import 'package:khatma/src/features/authentication/presentation/login/login_page.dart';
import 'package:khatma/src/features/profil/profile_menu_page.dart';
import 'package:khatma/src/features/authentication/presentation/register/register_page.dart';
import 'package:khatma/src/features/settings/settings_page.dart';
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
  profil,
  login,
  register,
  forgotPassword,
  createPassword,
  quran,
  MentionsLegales,
  cgu,
  aboutUs,
  declarationDonnees,
  faq,
  contact,
  settings,
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
        name: AppRoute.profil.name,
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          fullscreenDialog: true,
          child: const ProfileMenuPage(),
        ),
        routes: [
          GoRoute(
            name: AppRoute.settings.name,
            path: 'setings',
            builder: (context, state) => const SettingsPage(),
          ),
          GoRoute(
            name: AppRoute.login.name,
            path: 'login',
            builder: (context, state) => const LoginPage(),
          ),
          GoRoute(
            name: AppRoute.register.name,
            path: 'register',
            builder: (context, state) => const RegisterPage(),
          ),
          GoRoute(
            path: 'forgot_password',
            name: AppRoute.forgotPassword.name,
            builder: (context, state) => const ForgotPasswordPage(),
          ),
          GoRoute(
            path: 'create_password',
            name: AppRoute.createPassword.name,
            builder: (context, state) => const CreatePasswordPage(),
          ),
        ],
      ),
      /*
      GoRoute(
        path: '/sign-in',
        name: AppRoute.login.name,
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          fullscreenDialog: true,
          child: CustomSignInScreen(),
        ),
      ),
      */
      // Exemple pour CGU
      GoRoute(
        path: '/cgu',
        name: AppRoute.cgu.name,
        builder: (context, state) => const MarkdownReaderPage(
          title: 'Conditions Générales',
          assetPath: 'assets/docs/cgu.md',
        ),
      ),

      GoRoute(
        path: '/declaration-donnees',
        name: AppRoute.declarationDonnees.name,
        builder: (context, state) => const MarkdownReaderPage(
          title: 'Protection des données',
          assetPath: 'assets/docs/declaration_donnees.md',
        ),
      ),

      GoRoute(
        path: '/about-us',
        name: AppRoute.aboutUs.name,
        builder: (context, state) => const MarkdownReaderPage(
          title: 'À propos',
          assetPath: 'assets/docs/about_us.md',
        ),
      ),

      GoRoute(
        path: '/mentions-legals',
        name: AppRoute.MentionsLegales.name,
        builder: (context, state) => const MarkdownReaderPage(
          title: 'Mentions légales',
          assetPath: 'assets/docs/mentions_legals.md',
        ),
      ),
      GoRoute(
        path: '/faq',
        name: AppRoute.faq.name,
        builder: (context, state) => const FAQPage(),
      ),
      GoRoute(
        path: '/contact',
        name: AppRoute.contact.name,
        builder: (context, state) => const ContactUsPage(),
      ),
    ],
    errorBuilder: (context, state) => const NotFoundScreen(),
  );
});
