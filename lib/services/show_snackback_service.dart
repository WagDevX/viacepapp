import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      margin: const EdgeInsets.all(8),
      behavior: SnackBarBehavior.floating,
      showCloseIcon: true,
      backgroundColor: Colors.green,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(4))),
      elevation: 2,
      content: Text(message)));
}
