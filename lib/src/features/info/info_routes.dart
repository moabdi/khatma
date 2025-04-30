import 'package:go_router/go_router.dart';
import 'package:khatma/src/common/widgets/markdown_reader.dart';
import 'package:khatma/src/features/info/contact.dart';
import 'package:khatma/src/features/info/faq_page.dart';

List<GoRoute> infoRoutes = [
  GoRoute(
    path: 'cgu',
    name: 'cgu',
    builder: (context, state) => const MarkdownReaderPage(
      title: 'Conditions Générales',
      assetPath: 'assets/docs/cgu.md',
    ),
  ),
  GoRoute(
    path: 'declaration-donnees',
    name: 'declarationDonnees',
    builder: (context, state) => const MarkdownReaderPage(
      title: 'Protection des données',
      assetPath: 'assets/docs/declaration_donnees.md',
    ),
  ),
  GoRoute(
    path: 'about-us',
    name: 'aboutUs',
    builder: (context, state) => const MarkdownReaderPage(
      title: 'À propos',
      assetPath: 'assets/docs/about_us.md',
    ),
  ),
  GoRoute(
    path: 'mentions-legals',
    name: 'MentionsLegales',
    builder: (context, state) => const MarkdownReaderPage(
      title: 'Mentions légales',
      assetPath: 'assets/docs/mentions_legals.md',
    ),
  ),
  GoRoute(
    path: 'faq',
    name: 'faq',
    builder: (context, state) => const FAQPage(),
  ),
  GoRoute(
    path: 'contact',
    name: 'contact',
    builder: (context, state) => const ContactUsPage(),
  ),
];
