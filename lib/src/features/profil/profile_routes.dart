import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:khatma/src/features/authentication/presentation/login/login_page.dart';
import 'package:khatma/src/features/authentication/presentation/password/create_password_page.dart';
import 'package:khatma/src/features/authentication/presentation/password/forgot_password_page.dart';
import 'package:khatma/src/features/authentication/presentation/register/register_page.dart';
import 'package:khatma/src/features/profil/presentation/profile_menu_page.dart';
import 'package:khatma/src/features/settings/presentation/language_setting.dart';
import 'package:khatma/src/features/settings/presentation/recitation_settings.dart';
import 'package:khatma/src/features/settings/presentation/settings_page.dart';
import 'package:khatma/src/features/settings/presentation/theme_settings.dart';
import 'package:khatma/src/routing/app_router.dart';

final profileRoutes = [
  GoRoute(
    path: 'profile',
    name: AppRoute.profil.name,
    pageBuilder: (context, state) => MaterialPage(
      key: state.pageKey,
      fullscreenDialog: true,
      child: const ProfileMenuPage(),
    ),
    routes: [
      GoRoute(
        name: AppRoute.settings.name,
        path: 'settings',
        builder: (context, state) => const SettingsPage(),
        routes: [
          GoRoute(
            name: AppRoute.languages.name,
            path: 'languages',
            builder: (context, state) => const LanguageSettings(),
          ),
          GoRoute(
            name: AppRoute.theme.name,
            path: 'theme',
            builder: (context, state) => const ThemeSettings(),
          ),
          GoRoute(
            name: AppRoute.recitation.name,
            path: 'recitation',
            builder: (context, state) => const RecitationSettings(),
          )
        ],
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
        path: 'forgot-password',
        name: AppRoute.forgotPassword.name,
        builder: (context, state) => const ForgotPasswordPage(),
      ),
      GoRoute(
        path: 'create-password',
        name: AppRoute.createPassword.name,
        builder: (context, state) => const CreatePasswordPage(),
      ),
    ],
  ),
];
