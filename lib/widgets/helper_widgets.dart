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

Widget commonSocialBtn({
  required VoidCallback onPressed,
  required Widget child,
}) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.grey.shade500,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(60),
      ),
      backgroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 2),
      elevation: 0,
    ),
    onPressed: onPressed,
    child: Container(
      width: 60,
      height: 60,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.grey.shade200,
          width: 5,
        ),
      ),
      child: child,
    ),
  );
}

Expanded commonDivider(double width, double padding, bool right) {
  return Expanded(
    child: Padding(
      padding: EdgeInsets.only(top: padding),
      child: Divider(
        color: AppColors.greyColor,
        thickness: 1,
        endIndent: right ? width : 0,
        indent: !right ? width : 0,
      ),
    ),
  );
}