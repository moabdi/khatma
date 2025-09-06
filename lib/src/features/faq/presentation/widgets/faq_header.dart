import 'package:flutter/material.dart';
import 'package:khatma/src/themes/theme.dart';

class FaqHeader extends StatelessWidget {
  final String question;
  final int index;
  final bool isExpanded;
  final Animation<double> animation;
  final VoidCallback onToggle;

  const FaqHeader({
    super.key,
    required this.question,
    required this.index,
    required this.isExpanded,
    required this.animation,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onToggle,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(16),
          color: isExpanded
              ? context.colorScheme.primaryContainer.withOpacity(0.1)
              : context.colorScheme.surface,
          child: Row(
            children: [
              _buildNumberBadge(context),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  question,
                  style: context.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: isExpanded
                        ? context.colorScheme.primary
                        : context.colorScheme.onSurface,
                  ),
                ),
              ),
              _buildExpandIcon(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNumberBadge(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: isExpanded
            ? context.colorScheme.primary
            : context.colorScheme.primary.withOpacity(0.8),
        borderRadius: BorderRadius.circular(18),
        boxShadow: isExpanded
            ? [
                BoxShadow(
                  color: context.colorScheme.primary.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
      ),
      child: AnimatedScale(
        scale: isExpanded ? 1.05 : 1.0,
        duration: const Duration(milliseconds: 200),
        child: Center(
          child: Text(
            '${index + 1}',
            style: TextStyle(
              color: context.colorScheme.onPrimary,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildExpandIcon(BuildContext context) {
    return AnimatedRotation(
      turns: isExpanded ? 0.5 : 0,
      duration: const Duration(milliseconds: 200),
      child: Icon(
        Icons.keyboard_arrow_down,
        color: context.colorScheme.primary,
        size: 24,
      ),
    );
  }
}
