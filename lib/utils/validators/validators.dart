
import '../utils.dart';

String? emailValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Email is a required field.';
  } else if (!Regxs.validateEmail(value)) {
    return 'Invalid email format.';
  }
  return null;
}