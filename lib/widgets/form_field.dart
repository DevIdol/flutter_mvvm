import 'package:flutter/material.dart';

import '../utils/utils.dart';
import 'helper_widgets.dart';

/// A reusable text field widget for forms with validation
Widget commonTextFormField(
    {required String labelText,
    required TextEditingController controller,
    String? Function(String?)? validator,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    ValueChanged<bool>? onTogglePassword,
    int? maxLength}) {
  return TextFormField(
    maxLength: maxLength,
    controller: controller,
    obscureText: obscureText,
    keyboardType: keyboardType,
    validator: validator,
    decoration: inputDecoration(labelText, obscureText, onTogglePassword),
  );
}

/// Builds the InputDecoration for the text field
InputDecoration inputDecoration(
    String labelText, bool obscureText, ValueChanged<bool>? onTogglePassword) {
  return InputDecoration(
    counterText: '',
    isDense: true,
    labelText: labelText,
    labelStyle: commonStyle(15, FontWeight.w400, AppColors.darkColor),
    contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 17),
    enabledBorder: commonBorder(false),
    focusedBorder: commonBorder(true),
    errorBorder: commonBorder(false),
    focusedErrorBorder: commonBorder(true),
    suffixIcon: labelText == 'Password'
        ? _buildPasswordToggleIcon(obscureText, onTogglePassword)
        : null,
  );
}

/// Builds the suffix icon for the password field
Widget? _buildPasswordToggleIcon(
    bool obscureText, ValueChanged<bool>? onTogglePassword) {
  return IconButton(
    icon: Icon(
      obscureText ? Icons.visibility_off : Icons.visibility,
      color: AppColors.darkColor,
    ),
    onPressed: () {
      onTogglePassword?.call(!obscureText);
    },
  );
}
