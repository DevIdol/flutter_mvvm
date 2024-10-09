import '../utils.dart';

class Validators {
  static String? validateRequiredField({
    required String? value,
    required String labelText,
  }) {
    if (value == null || value.isEmpty) {
      return '$labelText is required';
    }
    return null;
  }

  static String? validateEmail({
    required String? value,
    required String labelText,
  }) {
    if (value == null || value.isEmpty) {
      return '$labelText is required';
    }
    if (!Regxs.validateEmail(value)) {
      return 'Invalid $labelText format';
    }
    return null;
  }

  static String? validatePassword(
      {required String? value, required String labelText}) {
    if (value == null || value.isEmpty) {
      return '$labelText is required';
    }
    if (!Regxs.validatePassword(value)) {
      return 'Password must have: \nAt least 8+ characters, \nAt least 1 uppercase, 1 lowercase, \nAt least 1 number, 1 special';
    }
    return null;
  }
}
