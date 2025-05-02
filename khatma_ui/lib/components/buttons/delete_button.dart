import 'package:flutter/material.dart';
import 'package:khatma_ui/components/alert_dialogs.dart';

class DeleteButton extends StatelessWidget {
  const DeleteButton({
    super.key,
    required this.onPressed,
    this.width,
    this.content,
    required this.title,
    required this.cancelActionText,
    required this.defaultActionText,
  });

  final VoidCallback? onPressed;
  final double? width;
  final String? content;
  final String title;
  final String cancelActionText;
  final String defaultActionText;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      child: OutlinedButton.icon(
        icon: Icon(Icons.delete),
        style: Theme.of(context).outlinedButtonTheme.style!.copyWith(
            elevation: WidgetStatePropertyAll(0),
            fixedSize: WidgetStatePropertyAll(Size(double.infinity, 45)),
            backgroundColor:
                WidgetStatePropertyAll(Colors.red.shade100.withOpacity(0.2)),
            foregroundColor: WidgetStatePropertyAll(Colors.red),
            side: WidgetStatePropertyAll(BorderSide(color: Colors.red)),
            overlayColor: WidgetStatePropertyAll(Colors.red.shade500)),
        onPressed: () async {
          final confirm = await showAlertDialog(
            context: context,
            title: title,
            content: content,
            cancelActionText: cancelActionText,
            defaultActionText: defaultActionText,
            confirmTextColor: Colors.red,
          );
          if (confirm == true) {
            onPressed!.call();
          }
        },
        label: Text("Delete"),
      ),
    );
  }
}
