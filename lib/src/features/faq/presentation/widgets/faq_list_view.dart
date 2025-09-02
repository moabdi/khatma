import 'package:flutter/material.dart';

import '../../domain/faq_entry.dart';
import 'faq_expansion_panel.dart';

class FaqListView extends StatefulWidget {
  final List<FaqEntry> faqs;

  const FaqListView({
    super.key,
    required this.faqs,
  });

  @override
  State<FaqListView> createState() => _FaqListViewState();
}

class _FaqListViewState extends State<FaqListView>
    with TickerProviderStateMixin {
  late List<bool> _expanded;
  late List<AnimationController> _animationControllers;
  late List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    final length = widget.faqs.length;
    _expanded = List.filled(length, false);

    _animationControllers = List.generate(
      length,
      (index) => AnimationController(
        duration: const Duration(milliseconds: 250),
        reverseDuration: const Duration(milliseconds: 200),
        vsync: this,
      ),
    );

    _animations = _animationControllers
        .map((controller) => CurvedAnimation(
              parent: controller,
              curve: Curves.easeInOut,
              reverseCurve: Curves.easeIn,
            ))
        .toList();
  }

  @override
  void didUpdateWidget(FaqListView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.faqs.length != widget.faqs.length) {
      _disposeAnimations();
      _initializeAnimations();
    }
  }

  @override
  void dispose() {
    _disposeAnimations();
    super.dispose();
  }

  void _disposeAnimations() {
    for (final controller in _animationControllers) {
      controller.dispose();
    }
  }

  void _toggleExpansion(int index) {
    setState(() {
      _expanded[index] = !_expanded[index];
      if (_expanded[index]) {
        _animationControllers[index].forward();
      } else {
        _animationControllers[index].reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: List.generate(
          widget.faqs.length,
          (index) => FaqExpansionPanel(
            entry: widget.faqs[index],
            index: index,
            isExpanded: _expanded[index],
            animation: _animations[index],
            onToggle: () => _toggleExpansion(index),
          ),
        ),
      ),
    );
  }
}
