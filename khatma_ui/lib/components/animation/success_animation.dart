import 'package:flutter/material.dart';
import 'package:khatma_ui/khatma_ui.dart';

class SuccessAnimation extends StatefulWidget {
  final String? title;
  final String message;
  final IconData? icon;
  final Color? iconColor;
  final Color? backgroundColor;
  final Duration animationDuration;
  final VoidCallback? onComplete;

  const SuccessAnimation({
    super.key,
    this.title,
    required this.message,
    this.icon = Icons.check_circle,
    this.iconColor,
    this.backgroundColor,
    this.animationDuration = const Duration(milliseconds: 800),
    this.onComplete,
  });

  @override
  State<SuccessAnimation> createState() => _SuccessAnimationState();
}

class _SuccessAnimationState extends State<SuccessAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _iconAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.5, curve: Curves.elasticOut),
    ));

    _iconAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.5, 1.0, curve: Curves.easeOut),
    ));

    _controller.forward().then((_) {
      widget.onComplete?.call();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Transform.scale(
              scale: _scaleAnimation.value,
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: widget.backgroundColor ??
                      Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Transform.scale(
                  scale: _iconAnimation.value,
                  child: Icon(
                    widget.icon,
                    color: widget.iconColor ??
                        Theme.of(context).colorScheme.primary,
                    size: 48,
                  ),
                ),
              ),
            ),
            gapH16,
            if (widget.title != null) ...[
              Text(
                widget.title!,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              gapH8,
            ],
            Text(
              widget.message,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        );
      },
    );
  }
}

/// A simpler version with just fade-in animation
class SimpleSuccessAnimation extends StatefulWidget {
  final String? title;
  final String message;
  final IconData? icon;
  final Color? iconColor;
  final Color? backgroundColor;
  final Duration animationDuration;
  final VoidCallback? onComplete;

  const SimpleSuccessAnimation({
    super.key,
    this.title,
    required this.message,
    this.icon = Icons.check_circle,
    this.iconColor,
    this.backgroundColor,
    this.animationDuration = const Duration(milliseconds: 400),
    this.onComplete,
  });

  @override
  State<SimpleSuccessAnimation> createState() => _SimpleSuccessAnimationState();
}

class _SimpleSuccessAnimationState extends State<SimpleSuccessAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    ));

    _controller.forward().then((_) {
      widget.onComplete?.call();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: widget.backgroundColor ??
                  Theme.of(context).colorScheme.primary.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              widget.icon,
              color: widget.iconColor ?? Theme.of(context).colorScheme.primary,
              size: 48,
            ),
          ),
          gapH16,
          if (widget.title != null) ...[
            Text(
              widget.title!,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            gapH8,
          ],
          Text(
            widget.message,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

/// A utility class for managing modal states with success animations
class ModalStateManager {
  final ValueNotifier<bool> isLoading = ValueNotifier(false);
  final ValueNotifier<String?> errorText = ValueNotifier(null);
  final ValueNotifier<bool> showSuccess = ValueNotifier(false);

  void clearError() {
    errorText.value = null;
  }

  void setError(String error) {
    errorText.value = error;
    isLoading.value = false;
  }

  void setLoading(bool loading) {
    isLoading.value = loading;
    if (loading) {
      errorText.value = null;
    }
  }

  void showSuccessAnimation() {
    isLoading.value = false;
    showSuccess.value = true;
  }

  void reset() {
    isLoading.value = false;
    errorText.value = null;
    showSuccess.value = false;
  }

  void dispose() {
    isLoading.dispose();
    errorText.dispose();
    showSuccess.dispose();
  }
}
