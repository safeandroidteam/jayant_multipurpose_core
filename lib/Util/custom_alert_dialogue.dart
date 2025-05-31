import 'package:flutter/material.dart';

void showCustomAlertDialog({
  required BuildContext context,
  required String title,
  required String content,
  String confirmText = "OK",
  VoidCallback? onConfirm,
  String? cancelText,
  VoidCallback? onCancel,
  bool isError = false,
}) {
  showDialog(
    context: context,
    barrierDismissible: false, // Force user to tap buttons
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        title: Text(
          title,
          style: TextStyle(
            color: isError ? Colors.red : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          content,
          style: TextStyle(color: isError ? Colors.red[700] : Colors.black87),
        ),
        actions: [
          if (cancelText != null)
            TextButton(
              onPressed: onCancel ?? () => Navigator.of(context).pop(),
              child: Text(cancelText),
            ),
          TextButton(
            onPressed: onConfirm ?? () => Navigator.of(context).pop(),
            child: Text(confirmText),
          ),
        ],
      );
    },
  );
}
