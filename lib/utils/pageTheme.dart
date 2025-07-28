import 'package:flutter/material.dart';

enum PageTheme { construction, manpower }

extension PageThemeColors on PageTheme {
  Color get backgroundColor {
    switch (this) {
      case PageTheme.construction:
        return const Color(0xFF3A0303);
      case PageTheme.manpower:
        return const Color(0xFF022025);
    }
  }

  Color get primaryColor {
    switch (this) {
      case PageTheme.construction:
        return const Color(0xFF3A0303);
      case PageTheme.manpower:
        return const Color(0xFF022025);
    }
  }

  Color get buttonColor {
    switch (this) {
      case PageTheme.construction:
        return Colors.deepOrange;
      case PageTheme.manpower:
        return Colors.teal;
    }
  }
}
