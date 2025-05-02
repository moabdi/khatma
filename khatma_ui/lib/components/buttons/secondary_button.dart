import 'dart:math';

import 'package:flutter/material.dart';
import 'package:khatma_ui/constants/app_sizes.dart';

/// Primary button based on [ElevatedButton].
/// Useful for CTAs in the app.
/// @param text - text to display on the button.
/// @param isLoading - if true, a loading indicator will be displayed instead of
/// the text.
/// @param onPressed - callback to be called when the button is pressed.
class SecondaryButton extends StatelessWidget {
  const SecondaryButton({
    super.key,
    required this.text,
    this.isLoading = false,
    this.onPressed,
    this.width = 400,
  });

  final String text;
  final bool isLoading;
  final VoidCallback? onPressed;
  final double width;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Sizes.p48,
      width: min(double.infinity, width),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(50),
      ),
      padding: EdgeInsets.all(0),
      child: ElevatedButton(
        onPressed: onPressed,
        child: isLoading
            ? const CircularProgressIndicator()
            : Text(
                text,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: Theme.of(context).primaryColor),
              ),
        style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
                backgroundColor: MaterialStateProperty.all<Color>(
              Theme.of(context).primaryColor.withOpacity(0.1),
            )),
      ),
    );
  }
}
