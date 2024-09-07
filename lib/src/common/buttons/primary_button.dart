import 'package:flutter/material.dart';
import 'package:khatma/src/common/constants/app_sizes.dart';
import 'package:khatma/src/common/constants/lottie_asset.dart';

/// Primary button based on [ElevatedButton].
/// Useful for CTAs in the app.
/// @param text - text to display on the button.
/// @param isLoading - if true, a loading indicator will be displayed instead of
/// the text.
/// @param onPressed - callback to be called when the button is pressed.
class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.text,
    this.isLoading = false,
    this.onPressed,
    this.shadowOffset = 3,
    this.width,
    this.color,
  });

  final String text;
  final bool isLoading;
  final VoidCallback? onPressed;
  final double shadowOffset;
  final double? width;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Sizes.p48,
      width: width,
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            BoxShadow(
              color: color ?? Theme.of(context).primaryColor,
              blurRadius: shadowOffset,
              spreadRadius: 0,
              blurStyle: BlurStyle.outer,
            )
          ]),
      padding: EdgeInsets.all(0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: color),
        onPressed: onPressed,
        child: isLoading
            ? lottieStartReading
            : Text(
                text,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: Colors.white),
              ),
      ),
    );
  }
}
