import 'package:flutter/material.dart';

class ToastService {
  BuildContext context;

  ToastService({required this.context});

  showTextToast(String text, {BuildContext? context}) {
    ScaffoldMessenger.of(context ?? this.context).showSnackBar(SnackBar(
      content: Text(text),
      duration: const Duration(seconds: 2),
    ));
  }
}
