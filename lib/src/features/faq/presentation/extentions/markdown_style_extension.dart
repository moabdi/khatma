import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:khatma/src/themes/theme.dart';

extension MarkdownStyleSheetExtension on BuildContext {
  MarkdownStyleSheet get faqMarkdownStyleSheet {
    return MarkdownStyleSheet(
      p: textTheme.bodyMedium?.copyWith(
        height: 1.6,
        color: colorScheme.onSurface.withOpacity(0.85),
      ),
      h1: textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.bold,
        color: colorScheme.primary,
        height: 1.3,
      ),
      h2: textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.w600,
        color: colorScheme.primary,
        height: 1.3,
      ),
      h3: textTheme.titleSmall?.copyWith(
        fontWeight: FontWeight.w600,
        color: colorScheme.onSurface,
      ),
      strong: TextStyle(
        fontWeight: FontWeight.bold,
        color: colorScheme.onSurface,
      ),
      em: TextStyle(
        fontStyle: FontStyle.italic,
        color: colorScheme.onSurface.withOpacity(0.8),
      ),
      a: TextStyle(
        color: colorScheme.primary,
        decoration: TextDecoration.underline,
      ),
      code: TextStyle(
        backgroundColor: colorScheme.surfaceVariant,
        color: colorScheme.onSurfaceVariant,
        fontFamily: 'monospace',
        fontSize: 14,
      ),
      codeblockDecoration: BoxDecoration(
        color: colorScheme.surfaceVariant.withOpacity(0.5),
        borderRadius: BorderRadius.circular(8),
      ),
      blockquote: textTheme.bodyMedium?.copyWith(
        color: colorScheme.onSurface.withOpacity(0.7),
        fontStyle: FontStyle.italic,
      ),
      blockquoteDecoration: BoxDecoration(
        color: colorScheme.surfaceVariant.withOpacity(0.3),
        border: Border(
          left: BorderSide(
            color: colorScheme.primary,
            width: 4,
          ),
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      listBullet: textTheme.bodyMedium?.copyWith(
        color: colorScheme.primary,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  MarkdownStyleSheet markdownStyleSheet({
    Color? primaryColor,
    Color? textColor,
    double? lineHeight,
    double? codeBlockRadius,
  }) {
    return MarkdownStyleSheet(
      p: textTheme.bodyMedium?.copyWith(
        height: lineHeight ?? 1.6,
        color: textColor ?? colorScheme.onSurface.withOpacity(0.85),
      ),
      h1: textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.bold,
        color: primaryColor ?? colorScheme.primary,
        height: 1.3,
      ),
      h2: textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.w600,
        color: primaryColor ?? colorScheme.primary,
        height: 1.3,
      ),
      h3: textTheme.titleSmall?.copyWith(
        fontWeight: FontWeight.w600,
        color: textColor ?? colorScheme.onSurface,
      ),
      strong: TextStyle(
        fontWeight: FontWeight.bold,
        color: textColor ?? colorScheme.onSurface,
      ),
      em: TextStyle(
        fontStyle: FontStyle.italic,
        color: (textColor ?? colorScheme.onSurface).withOpacity(0.8),
      ),
      a: TextStyle(
        color: primaryColor ?? colorScheme.primary,
        decoration: TextDecoration.underline,
      ),
      code: TextStyle(
        backgroundColor: colorScheme.surfaceVariant,
        color: colorScheme.onSurfaceVariant,
        fontFamily: 'monospace',
        fontSize: 14,
      ),
      codeblockDecoration: BoxDecoration(
        color: colorScheme.surfaceVariant.withOpacity(0.5),
        borderRadius: BorderRadius.circular(codeBlockRadius ?? 8),
      ),
      blockquote: textTheme.bodyMedium?.copyWith(
        color: (textColor ?? colorScheme.onSurface).withOpacity(0.7),
        fontStyle: FontStyle.italic,
      ),
      blockquoteDecoration: BoxDecoration(
        color: colorScheme.surfaceVariant.withOpacity(0.3),
        border: Border(
          left: BorderSide(
            color: primaryColor ?? colorScheme.primary,
            width: 4,
          ),
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      listBullet: textTheme.bodyMedium?.copyWith(
        color: primaryColor ?? colorScheme.primary,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
