import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:khatma/src/features/khatma/application/khatma_manager.dart';
import 'package:khatma/src/features/khatma/presentation/personal/details/khatma_read_screen.dart';
import 'package:khatma/src/features/khatma/presentation/shared/details/shared_khatma_screen.dart';
import 'package:khatma/src/features/khatma/presentation/shared/participants/participants_screen.dart';
import 'package:khatma/src/features/khatma/presentation/form/khatma_form_screen.dart';
import 'package:khatma/src/features/khatma/presentation/form/logic/khatma_form_provider.dart';
import 'package:khatma/src/features/khatma/presentation/success/khatma_success_screen.dart';
import 'package:khatma/src/routing/app_router.dart';
import 'package:khatma/src/widgets/markdown_reader.dart';

List<GoRoute> khatmaRoutes(Ref ref) => [
      // ========================================================================
      // COMMON ROUTES
      // ========================================================================

      // Create new khatma
      GoRoute(
        path: 'khatma/new',
        name: AppRoute.addKhatma.name,
        builder: (context, state) {
          ref.invalidate(khatmaFormProvider);
          return AddKhatmaScreen();
        },
      ),

      // Khatma douaa
      GoRoute(
        path: 'khatma/douaa',
        name: AppRoute.douaaKhatm.name,
        builder: (context, state) => const MarkdownReader(
          title: 'Douaa Khatm',
          assetPath: 'assets/docs/khatma-doaa.md',
        ),
      ),

      // ========================================================================
      // PERSONAL KHATMA ROUTES
      // ========================================================================

      // Personal khatma details
      GoRoute(
        path: 'khatma/personal/:id',
        name: AppRoute.khatmaDetails.name,
        builder: (context, state) {
          final khatmaId = state.pathParameters['id']!;
          return KhatmaReadScreen(khatmaId: khatmaId);
        },
        routes: [
          // Edit personal khatma
          GoRoute(
            path: 'edit',
            name: AppRoute.editKhatma.name,
            builder: (context, state) {
              final khatmaId = state.pathParameters['id']!;
              return _EditKhatmaWrapper(khatmaId: khatmaId);
            },
          ),
        ],
      ),

      // ========================================================================
      // SHARED KHATMA ROUTES
      // ========================================================================

      // Shared khatma details
      GoRoute(
        path: 'khatma/shared/:id',
        name: AppRoute.sharedKhatmaDetails.name,
        builder: (context, state) {
          final khatmaId = state.pathParameters['id']!;
          return SharedKhatmaScreen(khatmaId: khatmaId);
        },
        routes: [
          // Edit shared khatma
          GoRoute(
            path: 'edit',
            name: AppRoute.editSharedKhatma.name,
            builder: (context, state) {
              final khatmaId = state.pathParameters['id']!;
              return _EditSharedKhatmaWrapper(khatmaId: khatmaId);
            },
          ),
          // Participants screen
          GoRoute(
            path: 'participants',
            builder: (context, state) {
              final khatmaId = state.pathParameters['id']!;
              return ParticipantsScreen(khatmaId: khatmaId);
            },
          ),
          // Settings screen (config) - uses same form as edit
          GoRoute(
            path: 'settings',
            builder: (context, state) {
              final khatmaId = state.pathParameters['id']!;
              return _EditSharedKhatmaWrapper(khatmaId: khatmaId);
            },
          ),
          // Shared khatma success screen
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

// ============================================================================
// WRAPPER WIDGETS
// ============================================================================

/// Wrapper widget to ensure form is initialized before building the edit screen
/// Used for personal khatma editing
class _EditKhatmaWrapper extends ConsumerStatefulWidget {
  const _EditKhatmaWrapper({
    required this.khatmaId,
  });

  final String khatmaId;

  @override
  ConsumerState<_EditKhatmaWrapper> createState() => _EditKhatmaWrapperState();
}

class _EditKhatmaWrapperState extends ConsumerState<_EditKhatmaWrapper> {
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    // Initialize the form after the first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final khatma = ref.read(khatmaManagerProvider.notifier).getKhatmaById(widget.khatmaId);

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

/// Wrapper widget to ensure form is initialized before building the edit screen
/// Used for shared khatma editing
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
