import 'package:flutter/material.dart';

extension SnackBarExtension on BuildContext {
  void showMessage(String text) {
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(content: Text(text)));
  }
}
