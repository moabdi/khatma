import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:khatma/src/features/khatma/application/khatma_manager.dart';
import 'package:khatma/src/features/khatma/presentation/shared/details/shared_khatma_screen.dart';
import 'package:khatma/src/features/khatma/presentation/form/khatma_form_screen.dart';
import 'package:khatma/src/features/khatma/presentation/form/logic/khatma_form_provider.dart';
import 'package:khatma/src/features/khatma/presentation/success/khatma_success_screen.dart';
import 'package:khatma/src/routing/app_router.dart';

List<GoRoute> sharedKhatmaRoutes(Ref ref) => [
      GoRoute(
        path: 'khatma/shared/:id',
        name: AppRoute.sharedKhatmaDetails.name,
        builder: (context, state) {
          final khatmaId = state.pathParameters['id']!;
          return SharedKhatmaScreen(khatmaId: khatmaId);
        },
        routes: [
          GoRoute(
            path: 'edit',
            name: AppRoute.editSharedKhatma.name,
            builder: (context, state) {
              final khatmaId = state.pathParameters['id']!;
              return _EditSharedKhatmaWrapper(khatmaId: khatmaId);
            },
          ),
          GoRoute(
            path: 'success',
            name: AppRoute.khatmaSuccess.name,
            builder: (context, state) {
              final khatmaId = state.pathParameters['id']!;
              final extra = state.extra as Map<String, dynamic>?;
              final joinCode = extra?['joinCode'] as String? ?? '';
              final khatmaName = extra?['khatmaName'] as String?;

              return KhatmaSuccessScreen(
                khatmaId: khatmaId,
                joinCode: joinCode,
                khatmaName: khatmaName,
              );
            },
          ),
        ],
      ),
    ];

// Wrapper widget to ensure form is initialized before building the screen
class _EditSharedKhatmaWrapper extends ConsumerStatefulWidget {
  const _EditSharedKhatmaWrapper({
    required this.khatmaId,
  });

  final String khatmaId;

  @override
  ConsumerState<_EditSharedKhatmaWrapper> createState() =>
      _EditSharedKhatmaWrapperState();
}

class _EditSharedKhatmaWrapperState
    extends ConsumerState<_EditSharedKhatmaWrapper> {
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    // Initialize the form after the first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final khatma = ref
          .read(khatmaManagerProvider.notifier)
          .getKhatmaById(widget.khatmaId);

      if (khatma != null) {
        ref.read(khatmaFormProvider.notifier).initializeForEdit(khatma);
        if (mounted) {
          setState(() {
            _initialized = true;
          });
        }
      } else {
        // Navigate back if khatma not found
        if (mounted) {
          Navigator.of(context).pop();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_initialized) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return AddKhatmaScreen(khatmaId: widget.khatmaId);
  }
}
