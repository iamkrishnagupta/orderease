import 'package:flutter/material.dart';

class CustomSnackbar {
  static void show(BuildContext context, String message, {int durationSeconds = 4}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: durationSeconds),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        backgroundColor: Colors.teal,
      )
    );
  }
}
