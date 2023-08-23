import 'package:flutter/material.dart';
import 'form_validation.dart';

class EmailInputField extends StatelessWidget {
  final bool rememberEmail;
  final String initialEmail;
  final Function(String) onEmailChanged;

  EmailInputField({
    required this.rememberEmail,
    required this.initialEmail,
    required this.onEmailChanged,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: rememberEmail ? initialEmail : '',
      decoration: const InputDecoration(
        labelText: 'Email',
        border: OutlineInputBorder(),
      ),
      validator: FormValidation.validateEmail,
      onChanged: onEmailChanged,
    );
  }
}