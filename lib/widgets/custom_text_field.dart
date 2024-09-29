import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String initialValue;
  final ValueChanged<String> onChanged;
  final bool isRequired;
  final String? Function(String?)? validator;
  final int? maxLength;

  const CustomTextField({
    super.key,
    required this.label,
    required this.initialValue,
    required this.onChanged,
    this.isRequired = false,
    this.validator,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
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
