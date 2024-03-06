import 'package:flutter/material.dart';
import 'package:grock/grock.dart';

class NotificationService {
  void makeDialog(
    String title,
    String content,
    String cancelButtonLabel,
    VoidCallback onCancel,
    String updateButtonLabel,
    VoidCallback onUpdate,
  ) {
    Grock.dialog(
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              child: Text(cancelButtonLabel),
              onPressed: () {
                onCancel();
              },
            ),
            TextButton(
              child: Text(updateButtonLabel),
              onPressed: () {
                onUpdate();
              },
            ),
          ],
        );
      },
    );
  }

  void makeSnackbar(String title , String text , Color color ) {
    Grock.snackBar(
      title: title,
      description: text,
      color: color,
      position : SnackbarPosition.top
    );
  }


}
