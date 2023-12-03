import 'package:flutter/material.dart';
import 'package:khatma/src/common/widgets/alert_dialogs.dart';

class DeleteButton extends StatelessWidget {
  const DeleteButton({
    super.key,
    required this.onPressed,
    this.width,
  });

  final VoidCallback? onPressed;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      child: OutlinedButton(
        style: Theme.of(context).outlinedButtonTheme.style!.copyWith(
            elevation: MaterialStatePropertyAll(0),
            fixedSize: MaterialStatePropertyAll(Size(double.infinity, 45)),
            backgroundColor:
                MaterialStatePropertyAll(Colors.red.shade100.withOpacity(0.2)),
            foregroundColor: MaterialStatePropertyAll(Colors.red),
            side: MaterialStatePropertyAll(BorderSide(color: Colors.red)),
            overlayColor: MaterialStatePropertyAll(Colors.red.shade100)),
        onPressed: () async {
          final confirm = await showAlertDialog(
            context: context,
            title: 'Are you sure?',
            content: 'You want to delete this item!',
            cancelActionText: 'Cancel',
            defaultActionText: 'Delete',
            confirmTextColor: Colors.red,
          );
          if (confirm == true) {
            onPressed;
          }
        },
        child: Text("Delete"),
      ),
    );
  }
}
