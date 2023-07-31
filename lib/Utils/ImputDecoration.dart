import 'package:flutter/material.dart';

import 'Colors.dart';
import 'dimensions.dart';

class InputDecorations {
  static InputDecoration decoration1({
    required String hintText,
    required String? labelText,
    required IconData icon,
  }) {
    return InputDecoration(
      hintText: hintText,
      labelText: labelText,
      hintStyle: const TextStyle(
        color: AppThemeColor.dullFontColor,
        fontWeight: FontWeight.w400,
        fontSize: Dimensions.fontSizeLarge,
      ),
      labelStyle: const TextStyle(color: AppThemeColor.dullFontColor),
      icon: Icon(
        icon,
        color: AppThemeColor.dullFontColor,
        size: Dimensions.fontSizeExtraLarge,
      ),
      border: InputBorder.none,
    );
  }
}
