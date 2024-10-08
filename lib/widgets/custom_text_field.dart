import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String initialValue;
  final ValueChanged<String> onChanged;
  final bool isRequired;
  final String? Function(String?)? validator;
  final int? maxLength;
  final bool isReadOnly;
  final bool isEnabled;

  const CustomTextField({
    super.key,
    required this.label,
    required this.initialValue,
    required this.onChanged,
    this.isRequired = false,
    this.validator,
    this.maxLength,
    this.isReadOnly = false,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: isReadOnly,
      initialValue: initialValue,
      maxLength: maxLength,
      autocorrect: true,
      decoration: InputDecoration(labelText: label),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onChanged: onChanged,
      validator: validator ??
          (value) {
            if (isRequired && (value == null || value.isEmpty)) {
              return '$label is a required field.';
            }
            return null;
          },
    );
  }
}
