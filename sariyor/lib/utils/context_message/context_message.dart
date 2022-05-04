import 'package:flutter/material.dart';
class ContextMessage {
  static final GlobalKey<ScaffoldMessengerState> _messangerKey = GlobalKey();

  static void showSnackbar(Widget child, Duration duration) {
    _messangerKey.currentState!.showSnackBar(SnackBar(
      content: child,
      duration: duration,
    ));
  }

  static void showSnackbarWidget(
      BuildContext context, Widget child, Duration duration) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: child,
      duration: duration,
    ));
  }
}
