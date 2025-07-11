import 'package:flutter/material.dart';

class ModernBottomSheet extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget content;
  final List<Widget>? actions;
  final bool showDragHandle;
  final bool isDismissible;
  final bool enableDrag;
  final double? maxHeightFactor;
  final EdgeInsets? contentPadding;

  const ModernBottomSheet({
    super.key,
    required this.title,
    this.subtitle,
    required this.content,
    this.actions,
    this.showDragHandle = true,
    this.isDismissible = true,
    this.enableDrag = true,
    this.maxHeightFactor = 0.9,
    this.contentPadding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        constraints: BoxConstraints(
          maxHeight:
              MediaQuery.of(context).size.height * (maxHeightFactor ?? 0.9),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Fixed header
            _buildHeader(context),

            // Scrollable content
            Flexible(
              child: SingleChildScrollView(
                padding:
                    contentPadding ?? const EdgeInsets.fromLTRB(24, 12, 24, 45),
                child: Column(
                  children: [
                    const SizedBox(height: 8),
                    content,
                    if (actions != null) ...[
                      const SizedBox(height: 32),
                      OverflowBar(
                        alignment: MainAxisAlignment.end,
                        children: actions!,
                      )
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
          ),
          if (subtitle != null) ...[
            const SizedBox(height: 8),
            Text(
              subtitle!,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withOpacity(0.7),
                    height: 1.4,
                  ),
            ),
          ],
        ],
      ),
    );
  }

  static Future<T?> show<T>({
    required BuildContext context,
    required String title,
    String? subtitle,
    required Widget content,
    List<Widget>? actions,
    bool showDragHandle = true,
    bool isDismissible = true,
    bool enableDrag = true,
    double? maxHeightFactor = 0.9,
    EdgeInsets? contentPadding,
    bool useSafeArea = true,
    bool useRootNavigator = true,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      useSafeArea: useSafeArea,
      isScrollControlled: true,
      showDragHandle: showDragHandle,
      useRootNavigator: useRootNavigator,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      barrierColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
      builder: (context) => ModernBottomSheet(
        title: title,
        subtitle: subtitle,
        content: content,
        actions: actions,
        showDragHandle: true,
        isDismissible: isDismissible,
        enableDrag: enableDrag,
        maxHeightFactor: maxHeightFactor,
        contentPadding: contentPadding,
      ),
    );
  }
}
