import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:khatma/src/error/app_error_code.dart';
import 'package:khatma/src/error/app_error_handler.dart';
import 'package:khatma/src/features/khatma/personal/application/khatmat_provider.dart';
import 'package:khatma/src/features/khatma/personal/presentation/read/logic/khatma_parts_controller.dart';
import 'package:khatma/src/features/khatma/personal/presentation/read/ui/animate_khatma_chart.dart';
import 'package:khatma/src/features/khatma/personal/presentation/read/khatma_complete_screen.dart';
import 'package:khatma/src/i18n/app_localizations_context.dart';
import 'package:khatma/src/themes/theme.dart';
import 'package:khatma_ui/constants/app_sizes.dart';
import 'package:khatma_ui/extentions/color_extensions.dart';
import 'package:khatma_ui/extentions/string_extensions.dart';
import 'package:khatma/src/utils/common.dart';
import 'package:khatma/src/widgets/empty_placeholder_widget.dart';
import 'package:khatma_ui/components/conditional_content.dart';
import 'package:khatma/src/features/khatma/domain/khatma.dart';
import 'package:khatma/src/features/khatma/personal/presentation/form/logic/khatma_form_provider.dart';
import 'package:khatma/src/features/khatma/personal/presentation/read/ui/part_selector/to_read_tiles.dart';
import 'package:khatma/src/routing/app_router.dart';
import 'package:readmore/readmore.dart';

class KhatmaReadScreen extends ConsumerWidget {
  const KhatmaReadScreen({super.key, required this.khatmaId});
  final String khatmaId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final khatma = ref.watch(khatmaNotifierProvider).selectedKhatma;
    return khatma == null
        ? EmptyPlaceholderWidget(message: 'Khatma not found')
        : khatma.isCompleted
            ? KhatmaSuccessComplete(khatma: khatma)
            : buildContent(khatma, context);
  }

  Widget buildContent(Khatma khatma, BuildContext context) {
    return Scaffold(
      appBar: KhatmaAppBar(khatmaId: khatma.id!),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              boxShadow: [
                BoxShadow(
                  color: HexColor(khatma.style.color),
                  offset: const Offset(0, -2),
                  blurRadius: 8,
                ),
              ],
            ),
            child: Column(
              children: [
                buildDescriptionCard(khatma, context),
                gapH8,
                buildReadPartCard(context, khatma),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                color: context.colorScheme.onPrimary.withAlpha(51),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ToReadPartTiles(
                      key: UniqueKey(),
                      unit: khatma.unit,
                      color: khatma.style.hexColor,
                      completedParts: khatma.completedPartIds,
                    ),
                  ],
                ),
              ),
            ),
          ),
          ConfirmRead(khatmaID: khatmaId),
        ],
      ),
    );
  }

  Widget buildParts(BuildContext context, Khatma khatma) {
    return Column(
      children: [
        buildReadPartCard(context, khatma),
        gapH8,
        buildToReadPartCard(context, khatma),
      ],
    );
  }

  Widget buildAppBar(KhatmaID khatma, BuildContext context, WidgetRef ref) {
    return KhatmaAppBar(khatmaId: khatmaId);
  }

  Widget buildDescriptionCard(Khatma khatma, BuildContext context) {
    if (isBlank(khatma.description)) return const SizedBox.shrink();

    return Card(
      elevation: 0.5,
      clipBehavior: Clip.antiAlias,
      child: ListTile(
        tileColor: Colors.transparent,
        title: ReadMoreText(
          khatma.description ?? '',
          trimLines: 3,
          style: Theme.of(context).textTheme.bodyMedium,
          colorClickableText: Theme.of(context).primaryColor,
          trimMode: TrimMode.Line,
          textAlign: TextAlign.justify,
          trimCollapsedText: AppLocalizations.of(context).showMore,
          trimExpandedText: AppLocalizations.of(context).showLess,
        ),
      ),
    );
  }

  Widget buildToReadPartCard(BuildContext context, Khatma khatma) {
    return Card(
      elevation: 0.4,
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ToReadPartTiles(
          key: UniqueKey(),
          unit: khatma.unit,
          color: khatma.style.hexColor,
          completedParts: khatma.completedPartIds,
        ),
      ),
    );
  }

  Widget buildReadPartCard(BuildContext context, Khatma khatma) {
    return ConditionalContent(
      condition: khatma.readParts?.isNotEmpty ?? false,
      secondary: const SizedBox.shrink(),
      primary: Card(
        elevation: 0.4,
        clipBehavior: Clip.antiAlias,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
              title: Text(AppLocalizations.of(context).completedParts),
              subtitle: Text(AppLocalizations.of(context)
                  .readedParts(khatma.completedPartIds.length)),
              leading: AnimatedKhatmaChart(khatma: khatma)),
        ),
      ),
    );
  }
}

class ConfirmRead extends ConsumerStatefulWidget {
  const ConfirmRead({
    super.key,
    required this.khatmaID,
  });

  final KhatmaID khatmaID;

  @override
  ConsumerState<ConfirmRead> createState() => _ConfirmReadState();
}

class _ConfirmReadState extends ConsumerState<ConfirmRead>
    with SingleTickerProviderStateMixin {
  bool _isLoading = false;
  bool _showSuccess = false;
  late AnimationController _successAnimationController;

  @override
  void initState() {
    super.initState();
    _successAnimationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _successAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selectedParts = ref.watch(khatmaPartsControllerProvider);
    final hasSelection = selectedParts.isNotEmpty;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: _showSuccess
            ? Colors.green.withOpacity(0.1)
            : Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: _showSuccess
                ? Colors.green.withOpacity(0.2)
                : Colors.black.withOpacity(0.1),
            offset: const Offset(0, -2),
            blurRadius: 8,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Enhanced selection counter
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: hasSelection ? null : 0,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 200),
              opacity: hasSelection ? 1.0 : 0.0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.check_circle_outline,
                      size: 16,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      context.loc.selectedParts(selectedParts.length),
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Enhanced button with animations
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: (hasSelection && !_isLoading)
                  ? () =>
                      _onSubmit(context, ref, widget.khatmaID, selectedParts)
                  : null,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: _showSuccess
                    ? Row(
                        key: const ValueKey('success'),
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.check, size: 20),
                          const SizedBox(width: 8),
                          Text(
                            context.loc.completed,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      )
                    : _isLoading
                        ? Row(
                            key: const ValueKey('loading'),
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(
                                width: 18,
                                height: 18,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Text(
                                context.loc.processing,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          )
                        : Text(
                            key: const ValueKey('default'),
                            context.loc.confirmReading,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: hasSelection
                                  ? Colors.white
                                  : Theme.of(context)
                                      .colorScheme
                                      .onSurface
                                      .withOpacity(0.38),
                            ),
                          ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _onSubmit(BuildContext context, WidgetRef ref, KhatmaID khatmaId,
      List<int> selectedParts) async {
    // Haptic feedback for better UX
    try {
      HapticFeedback.lightImpact();
    } catch (_) {
      // Ignore haptic feedback errors on platforms that don't support it
    }

    // Set loading state
    if (mounted) {
      setState(() {
        _isLoading = true;
      });
    }

    // Visual delay for better UX
    await Future.delayed(const Duration(milliseconds: 500));

    try {
      final result = await ref
          .read(khatmaNotifierProvider.notifier)
          .completeParts(khatmaId, selectedParts);

      if (!context.mounted) return;

      result.handleUI(
        context,
        onSuccess: () async {
          // Show success state briefly
          if (mounted) {
            setState(() {
              _isLoading = false;
              _showSuccess = true;
            });
            _successAnimationController.forward();

            // Success haptic feedback
            try {
              HapticFeedback.mediumImpact();
            } catch (_) {
              // Ignore haptic feedback errors
            }
          }

          // Clear selection after brief delay
          await Future.delayed(const Duration(milliseconds: 500));

          if (mounted) {
            ref.read(khatmaPartsControllerProvider).clear();

            if (result.dataOrNull!.status == KhatmaStatus.completed) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      KhatmaSuccessComplete(khatma: result.dataOrNull!),
                ),
              );
            } else {
              // Reset success state if not completing
              setState(() {
                _showSuccess = false;
              });
              _successAnimationController.reset();
            }
          }
        },
      );
    } catch (e) {
      if (context.mounted) {
        AppErrorHandler.handleError(context, AppErrorCode.generalUnknown);
        // Error haptic feedback
        try {
          HapticFeedback.heavyImpact();
        } catch (_) {
          // Ignore haptic feedback errors
        }
      }
    } finally {
      // Always reset loading state
      if (mounted && !_showSuccess) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}

class KhatmaAppBar extends StatelessWidget implements PreferredSizeWidget {
  const KhatmaAppBar({
    super.key,
    required this.khatmaId,
  });

  final String khatmaId;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Consumer(
        builder: (context, ref, _) {
          Khatma? khatma = ref.watch(khatmaNotifierProvider).selectedKhatma;
          return khatma == null
              ? AppBar(title: Text(context.loc.khatma))
              : AppBar(
                  title: Text(khatma.name),
                  centerTitle: true,
                  actions: [
                    IconButton(
                      icon: Icon(
                        Icons.edit,
                        color: khatma.style.color.toColor(),
                      ),
                      onPressed: () => {
                        ref.read(khatmaFormProvider.notifier).update(khatma),
                        context.goNamed(AppRoute.editKhatma.name,
                            pathParameters: {'id': khatma.id!}),
                      },
                    ),
                    gapW16,
                  ],
                );
        },
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(66.0);
}
