import 'package:flutter/material.dart';

class PartTileTrailing extends StatelessWidget {
  const PartTileTrailing({
    super.key,
    required this.isRead,
    required this.color,
    this.onPressed,
  });

  final bool isRead;
  final Color color;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: isRead
          ? Icon(
              Icons.done_all,
              color: Theme.of(context).primaryColor.withOpacity(.3),
            )
          : CircleAvatar(
              backgroundColor: color.withOpacity(.2),
              child: IconButton(
                icon: const Icon(Icons.auto_stories, size: 18),
                color: color,
                onPressed: onPressed,
              ),
            ),
    );
  }
}
