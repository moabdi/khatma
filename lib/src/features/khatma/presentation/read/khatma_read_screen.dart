import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:khatma/src/error/app_error_code.dart';
import 'package:khatma/src/error/app_error_handler.dart';
import 'package:khatma/src/features/khatma/application/khatmat_provider.dart';
import 'package:khatma/src/features/khatma/presentation/read/logic/khatma_parts_controller.dart';
import 'package:khatma/src/features/khatma/presentation/read/ui/animate_khatma_chart.dart';
import 'package:khatma/src/features/khatma/presentation/read/khatma_complete_screen.dart';
import 'package:khatma/src/i18n/app_localizations_context.dart';
import 'package:khatma/src/themes/theme.dart';
import 'package:khatma_ui/constants/app_sizes.dart';
import 'package:khatma_ui/extentions/color_extensions.dart';
import 'package:khatma_ui/extentions/string_extensions.dart';
import 'package:khatma/src/utils/common.dart';
import 'package:khatma/src/widgets/empty_placeholder_widget.dart';
import 'package:khatma_ui/components/conditional_content.dart';
import 'package:khatma/src/features/khatma/domain/khatma.dart';
import 'package:khatma/src/features/khatma/presentation/form/logic/khatma_form_provider.dart';
import 'package:khatma/src/features/khatma/presentation/read/ui/part_selector/to_read_tiles.dart';
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
              padding: const EdgeInsets.all(16.0),
              child: Container(
                color: khatma.style.hexColor.withAlpha(26),
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

class _ConfirmReadState extends ConsumerState<ConfirmRead> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final selectedParts = ref.watch(khatmaPartsControllerProvider);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(0, -2),
            blurRadius: 8,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (selectedParts.isNotEmpty)
                    Text(context.loc.selectedParts(selectedParts.length)),
                ],
              )
            ],
          ),
          gapH12,
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: (selectedParts.isNotEmpty && !_isLoading)
                  ? () =>
                      _onSubmit(context, ref, widget.khatmaID, selectedParts)
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: context.colorScheme.primary,
                foregroundColor: Colors.white,
                disabledBackgroundColor:
                    Theme.of(context).colorScheme.surfaceContainerHighest,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: _isLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : Text(
                      context.loc.confirmReading,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
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
    // Set loading state to true
    setState(() {
      _isLoading = true;
    });
    await Future.delayed(const Duration(milliseconds: 300));

    try {
      final result = await ref
          .read(khatmaNotifierProvider.notifier)
          .completeParts(khatmaId, selectedParts);

      if (!context.mounted) return;

      result.handleUI(
        context,
        onSuccess: () {
          ref.read(khatmaPartsControllerProvider).clear();

          if (result.dataOrNull!.status == KhatmaStatus.completed) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    KhatmaSuccessComplete(khatma: result.dataOrNull!),
              ),
            );
          }
        },
      );
    } catch (e) {
      if (context.mounted) {
        AppErrorHandler.handleError(context, AppErrorCode.generalUnknown);
      }
    } finally {
      // Always reset loading state
      if (mounted) {
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
