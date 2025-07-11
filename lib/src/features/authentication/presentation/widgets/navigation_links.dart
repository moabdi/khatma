import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:khatma/src/i18n/app_localizations_context.dart';
import 'package:khatma/src/routing/app_router.dart';

/// Navigation links widget for auth pages
class NavigationLinks extends StatelessWidget {
  final bool isLoading;
  final String? leftText;
  final String? rightText;
  final String? leftRoute;
  final String? rightRoute;
  final VoidCallback? onLeftPressed;
  final VoidCallback? onRightPressed;

  const NavigationLinks({
    super.key,
    this.isLoading = false,
    this.leftText,
    this.rightText,
    this.leftRoute,
    this.rightRoute,
    this.onLeftPressed,
    this.onRightPressed,
  });

  /// Factory for login page navigation
  factory NavigationLinks.login({bool isLoading = false}) {
    return NavigationLinks(
      isLoading: isLoading,
      leftRoute: AppRoute.register.name,
      rightRoute: AppRoute.forgotPassword.name,
    );
  }

  /// Factory for register page navigation
  factory NavigationLinks.register({bool isLoading = false}) {
    return NavigationLinks(
      isLoading: isLoading,
      leftRoute: AppRoute.login.name,
      rightRoute: AppRoute.forgotPassword.name,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: isLoading ? null : _handleLeftPress(context),
          child: Text(_getLeftText(context)),
        ),
        TextButton(
          onPressed: isLoading ? null : _handleRightPress(context),
          child: Text(_getRightText(context)),
        ),
      ],
    );
  }

  String _getLeftText(BuildContext context) {
    if (leftText != null) return leftText!;
    if (leftRoute == AppRoute.register.name) return context.loc.signUp;
    if (leftRoute == AppRoute.login.name) return context.loc.signIn;
    return context.loc.back;
  }

  String _getRightText(BuildContext context) {
    if (rightText != null) return rightText!;
    if (rightRoute == AppRoute.forgotPassword.name)
      return context.loc.forgotPassword;
    if (rightRoute == AppRoute.register.name) return context.loc.signUp;
    return '';
  }

  VoidCallback? _handleLeftPress(BuildContext context) {
    if (onLeftPressed != null) return onLeftPressed;
    if (leftRoute != null) return () => context.goNamed(leftRoute!);
    return null;
  }

  VoidCallback? _handleRightPress(BuildContext context) {
    if (onRightPressed != null) return onRightPressed;
    if (rightRoute != null) return () => context.goNamed(rightRoute!);
    return null;
  }
}
