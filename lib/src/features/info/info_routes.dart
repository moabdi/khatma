import 'package:go_router/go_router.dart';
import 'package:khatma/src/features/faq/presentation/faq_page.dart';
import 'package:khatma/src/features/settings/presentation/about_page.dart';
import 'package:khatma/src/widgets/markdown_reader.dart';
import 'package:khatma/src/features/info/presentation/contact_page.dart';
import 'package:khatma/src/routing/app_router.dart';

List<GoRoute> infoRoutes = [
  GoRoute(
    path: 'cgu',
    name: AppRoute.cgu.name,
    builder: (context, state) => const MarkdownReader(
      title: 'Conditions Générales',
      assetPath: 'assets/docs/cgu.md',
    ),
  ),
  GoRoute(
    path: 'declaration-donnees',
    name: AppRoute.declarationDonnees.name,
    builder: (context, state) => const MarkdownReader(
      title: 'Protection des données',
      assetPath: 'assets/docs/declaration_donnees.md',
    ),
  ),
  GoRoute(
    path: 'about-us',
    name: AppRoute.aboutUs.name,
    builder: (context, state) => AboutPage(),
  ),
  GoRoute(
    path: 'mentions-legals',
    name: AppRoute.mentionsLegales.name,
    builder: (context, state) => const MarkdownReader(
      title: 'Mentions légales',
      assetPath: 'assets/docs/mentions_legals.md',
    ),
  ),
  GoRoute(
    path: 'faq',
    name: 'faq',
    builder: (context, state) => const FaqPage(),
  ),
  GoRoute(
    path: 'contact',
    name: 'contact',
    builder: (context, state) => const ContactUsPage(),
  ),
];
