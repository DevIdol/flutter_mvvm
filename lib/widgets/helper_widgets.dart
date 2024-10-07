import 'package:flutter/material.dart';

import '../utils/utils.dart';

TextStyle commonStyle(double size, FontWeight fontWeight, Color color) {
  return TextStyle(
    fontSize: size,
    fontWeight: fontWeight,
    color: color,
  );
}

OutlineInputBorder commonBorder(bool focus) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: BorderSide(
      color: focus ? AppColors.darkColor : AppColors.primaryColor,
      width: 0.6,
    ),
  );
}