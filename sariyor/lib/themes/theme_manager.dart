import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/diagnostics.dart';
import 'package:flutter/src/cupertino/theme.dart';

class ThemeManager {
  static ThemeData lightTheme() {
    return ThemeData(
        primaryColor: Colors.deepPurple,
        );
  }

  static ThemeData darkTheme() {
    return ThemeData(primaryColor: Colors.black);
  }
}
