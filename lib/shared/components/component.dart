import 'package:flutter/material.dart';

void showLoading(BuildContext context, String msg) {
  showDialog(
    barrierDismissible: true,
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("$msg"),
            SizedBox(
              width: 5,
            ),
            CircularProgressIndicator(),
          ],
        ),
      );
    },
  );
}

void showMessage(BuildContext context, String msg, String description,
    String posBtn, VoidCallback posAction,
    {bool isCancellable = true}) {
  showDialog(
    barrierDismissible: isCancellable,
    context: context,
    builder: (context) => AlertDialog(
      title: Text(msg),
      content: Text(description),
      actions: [TextButton(onPressed: posAction, child: Text(posBtn))],
    ),
  );
}
