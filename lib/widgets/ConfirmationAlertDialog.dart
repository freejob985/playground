import 'package:flutter/material.dart';

class ConfirmationAlertDialog extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;
  ConfirmationAlertDialog({
    required this.title,
    required this.content,
    this.onConfirm,
    this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        TextButton(
          child: Text('إلغاء'),
          onPressed: () {
            Navigator.of(context).pop();
            if (onCancel != null) onCancel!();
          },
        ),
        TextButton(
          child: Text('نعم'),
          onPressed: () {
            Navigator.of(context).pop();
            if (onConfirm != null) onConfirm!();
          },
        ),
      ],
    );
  }
}
