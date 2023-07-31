import 'package:flutter/material.dart';

class AppThemeColor {
  static const Color dullWhiteColor = Color(0xFFE5E5E5);
  static const Color pureWhiteColor = Color(0xFFFFFFFF);
  static const Color pureBlackColor = Color(0xFF000000);
  static const Color darkBlueColor = Color(0xFF5989D6);
  static const Color orangeColor = Color(0xFFFB7B20);
  static const Color yellowColor = Colors.yellow;
  static const Color greenColor = Colors.green;
  static const Color dullBlueColor = Color(0xFF73ABE4);
  static const Color lightBlueColor = Color(0xFFF3F8FC);
  static const Color dullFontColor = Color(0xFF6E757C);
  static const Color dullFontColor1 = Color(0xFFB9B9B9);

  static const Color backGroundColor = Color(0xFFFFFFFF);
  static const Color cardBackGroundColor = Color(0x90cddbea);
  static const Color grayColor = Color(0xFF60676C);
  static const Color lightGrayColor = Color(0xFFEDEDED);

  static const Gradient buttonGradient = LinearGradient(
    colors: [
      Color(0xFF6B9AE4),
      Color(0xFF6596E0),
      Color(0xFF5C8CD8),
    ],
    tileMode: TileMode.repeated,
  );

  static const Gradient backgroundGradient1 = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment(0.8, 1),
    colors: <Color>[
      orangeColor,
      yellowColor,
    ], // Gradient from https://learnui.design/tools/gradient-generator.html
    tileMode: TileMode.mirror,
  );

  static const Gradient backgroundGradient2 = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment(0.8, 1),
    colors: <Color>[
      darkBlueColor,
      pureWhiteColor,
    ], // Gradient from https://learnui.design/tools/gradient-generator.html
    tileMode: TileMode.mirror,
  );

  static const Gradient backgroundGradient3 = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment(0.8, 1),
    colors: <Color>[
      pureWhiteColor,
      darkBlueColor,
    ], // Gradient from https://learnui.design/tools/gradient-generator.html
    tileMode: TileMode.mirror,
  );
}
