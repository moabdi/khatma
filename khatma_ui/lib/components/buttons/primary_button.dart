import 'package:flutter/material.dart';

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
      padding: const EdgeInsets.all(0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: color),
        onPressed: onPressed,
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .titleSmall!
              .copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
