import 'package:flutter/material.dart';

import 'Colors.dart';

class AppButtons {
  Widget button1({
    required double width,
    required double height,
    required bool buttonLoading,
    required String label,
    required double labelSize,
  }) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(
        top: 20,
      ),
      width: width,
      height: 45,
      decoration: BoxDecoration(
        gradient: AppThemeColor.buttonGradient,
        borderRadius: BorderRadius.circular(10),
      ),
      child: buttonLoading
          ? Image.asset('images/loading.gif')
          : Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: labelSize,
                color: Colors.white,
              ),
            ),
    );
  }
}
