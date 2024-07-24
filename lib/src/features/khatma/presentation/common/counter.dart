import 'package:flutter/material.dart';

class Counter extends StatelessWidget {
  const Counter({
    super.key,
    this.value = 0,
    required this.maxValue,
    this.onChanged,
    this.onIncrement,
    this.onDecrement,
  });

  final int value;
  final int maxValue;
  final Function(int c)? onChanged;
  final Function(int c)? onIncrement;
  final Function(int c)? onDecrement;

  @override
  Widget build(BuildContext context) {
    print(value);
    return CustomizableCounter(
      showButtonText: false,
      borderColor: Theme.of(context).disabledColor,
      borderRadius: 50,
      backgroundColor: Theme.of(context).disabledColor,
      textColor: Colors.black,
      textSize: 17,
      count: value,
      step: 1,
      minCount: 1,
      maxCount: maxValue,
      onDecrement: onDecrement,
      onIncrement: onIncrement,
      onCountChange: onChanged,
    );
  }
}

class CustomizableCounter extends StatefulWidget {
  final Color? borderColor;
  final double? borderWidth;
  final double? borderRadius;
  final Color? backgroundColor;
  final String? buttonText;
  final Color? textColor;
  final double? textSize;
  final Widget? decrementIcon;
  final Widget? incrementIcon;
  final int count;
  final int maxCount;
  final int minCount;
  final int step;
  final bool showButtonText;
  final void Function(int c)? onCountChange;
  final void Function(int c)? onIncrement;
  final void Function(int c)? onDecrement;

  const CustomizableCounter(
      {Key? key,
      this.borderColor,
      this.borderWidth,
      this.borderRadius,
      this.backgroundColor,
      this.buttonText,
      this.textColor,
      this.textSize,
      this.decrementIcon,
      this.incrementIcon,
      this.count = 0,
      this.maxCount = 1000000,
      this.minCount = 0,
      this.step = 1,
      this.showButtonText = true,
      this.onCountChange,
      this.onIncrement,
      this.onDecrement})
      : super(key: key);

  @override
  State<CustomizableCounter> createState() => _CustomizableCounterState();
}

class _CustomizableCounterState extends State<CustomizableCounter> {
  int mCount = 0;

  @override
  void initState() {
    mCount = widget.count;
    super.initState();
  }

  void decrement() {
    setState(() {
      if ((mCount - widget.step) >= widget.minCount) {
        mCount -= widget.step;
        widget.onCountChange?.call(mCount);
        widget.onDecrement?.call(mCount);
      }
    });
  }

  void increment() {
    setState(() {
      if ((mCount + widget.step) <= widget.maxCount) {
        mCount += widget.step;
        widget.onCountChange?.call(mCount);
        widget.onIncrement?.call(mCount);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Container(
          height: 35,
          decoration: BoxDecoration(
            color: widget.backgroundColor,
            borderRadius: BorderRadius.circular(widget.borderRadius ?? 10),
            shape: BoxShape.rectangle,
            border: Border.all(
              color: widget.borderColor ?? Theme.of(context).primaryColor,
              width: widget.borderWidth ?? 2.0,
            ),
          ),
          child: Row(
            children: [
              IconButton(
                padding: EdgeInsets.all(0),
                onPressed: decrement,
                icon: widget.decrementIcon ??
                    Icon(
                      Icons.remove,
                      color: widget.textColor,
                      size: 20,
                    ),
              ),
              Text(
                _formatDouble(mCount),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: widget.textColor,
                  fontSize: widget.textSize,
                ),
              ),
              IconButton(
                padding: EdgeInsets.all(0),
                onPressed: increment,
                icon: widget.incrementIcon ??
                    Icon(
                      Icons.add,
                      color: widget.textColor,
                      size: 20,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

String _formatDouble(int value) {
  var verbose = value.toStringAsFixed(4);
  var trimmed = verbose;
  for (var i = verbose.length - 1; i > 0; i--) {
    if (trimmed[i] != '0' && trimmed[i] != '.' || !trimmed.contains('.')) {
      break;
    }
    trimmed = trimmed.substring(0, i);
  }
  return trimmed;
}
