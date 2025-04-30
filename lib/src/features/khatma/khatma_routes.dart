import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:khatma/src/features/khatma/presentation/form/khatma_form_screen.dart';
import 'package:khatma/src/features/khatma/presentation/form/providers/khatma_form_provider.dart';
import 'package:khatma/src/features/khatma/presentation/read/khatma_read_screen.dart';

List<GoRoute> khatmaRoutes(Ref ref) => [
      GoRoute(
        path: 'khatma/create',
        name: 'addKhatma',
        builder: (context, state) {
          ref.invalidate(formKhatmaProvider);
          return AddKhatmaScreen();
        },
      ),
      GoRoute(
        path: 'khatma/:id',
        name: 'khatmaDetails',
        builder: (context, state) {
          final khatmaId = state.pathParameters['id']!;
          return KhatmaReadScreen(khatmaId: khatmaId);
        },
        routes: [
          GoRoute(
            path: 'edit',
            name: 'editKhatma',
            builder: (context, state) {
              final khatmaId = state.pathParameters['id']!;
              return AddKhatmaScreen(khatmaId: khatmaId);
            },
          ),
        ],
      ),
    ];
