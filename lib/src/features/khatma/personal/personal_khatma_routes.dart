import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:khatma/src/features/khatma/personal/application/khatmat_provider.dart';
import 'package:khatma/src/features/khatma/personal/presentation/read/khatma_read_screen.dart';
import 'package:khatma/src/features/khatma/presentation/form/khatma_form_screen.dart';
import 'package:khatma/src/features/khatma/presentation/form/logic/khatma_form_provider.dart';
import 'package:khatma/src/routing/app_router.dart';
import 'package:khatma/src/widgets/markdown_reader.dart';

List<GoRoute> khatmaRoutes(Ref ref) => [
      GoRoute(
        path: 'khatma/new',
        name: AppRoute.addKhatma.name,
        builder: (context, state) {
          ref.invalidate(khatmaFormProvider);
          return AddKhatmaScreen();
        },
      ),
      GoRoute(
        path: 'khatma/personal/:id',
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
              return _EditKhatmaWrapper(khatmaId: khatmaId);
            },
          ),
        ],
      ),
      GoRoute(
        path: 'khatma/douaa',
        name: AppRoute.douaaKhatm.name,
        builder: (context, state) => const MarkdownReader(
          title: 'Douaa Khatm',
          assetPath: 'assets/docs/khatma-doaa.md',
        ),
      ),
    ];

// Wrapper widget to ensure form is initialized before building the screen
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
      final khatma = ref.read(khatmaNotifierProvider.notifier).getKhatmaById(widget.khatmaId);

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
