import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:khatma/src/features/home/presentation/home_page.dart';
import 'package:khatma/src/features/khatma/personal/presentation/form/khatma_form_screen.dart';
import 'package:khatma/src/features/khatma/personal/presentation/form/logic/khatma_form_provider.dart';
import 'package:khatma/src/features/khatma/personal/presentation/read/khatma_read_screen.dart';
import 'package:khatma/src/routing/app_router.dart';
import 'package:khatma/src/widgets/markdown_reader.dart';

List<GoRoute> khatmaRoutes(Ref ref) => [
      GoRoute(
        path: 'personal-khatma',
        name: AppRoute.personalKhatma.name,
        builder: (context, state) => const KhatmatListScreen(),
        routes: [
          GoRoute(
            path: 'create',
            name: AppRoute.addKhatma.name,
            builder: (context, state) {
              ref.invalidate(khatmaFormProvider);
              return AddKhatmaScreen();
            },
          ),
          GoRoute(
            path: ':id',
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
          GoRoute(
            path: 'douaa',
            name: AppRoute.douaaKhatm.name,
            builder: (context, state) => const MarkdownReader(
              title: 'Douaa Khatm',
              assetPath: 'assets/docs/khatma-doaa.md',
            ),
          ),
        ],
      ),
    ];
