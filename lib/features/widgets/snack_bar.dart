import 'package:flutter/material.dart';

void showInfoSnackBar({
  required BuildContext context,
  required String text,
  duration = const Duration(seconds: 3),
}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    duration: duration,
    behavior: SnackBarBehavior.floating,
    margin: EdgeInsets.symmetric(horizontal: 10).copyWith(bottom: 10),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    content: Center(child: Text(text)),
  ));
}
