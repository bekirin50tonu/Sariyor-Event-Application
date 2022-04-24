import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/diagnostics.dart';
import 'package:flutter/src/cupertino/theme.dart';

class ThemeManager {
  ThemeManager(this.context);

  BuildContext context;

  ThemeData lightTheme() {
    return Theme.of(context).copyWith();
  }

  ThemeData darkTheme() {
    return Theme.of(context).copyWith();
  }
}
