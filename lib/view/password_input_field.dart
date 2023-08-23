import 'package:flutter/material.dart';
import 'form_validation.dart';

class PasswordInputField extends StatefulWidget {
  final Function(String) onChanged;

  const PasswordInputField({
    required this.onChanged,
    Key? key,
  }) : super(key: key);

  @override
  _PasswordInputFieldState createState() => _PasswordInputFieldState();
}

class _PasswordInputFieldState extends State<PasswordInputField> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Password',
        border: OutlineInputBorder(),
        suffixIcon: IconButton(
          icon: Icon(
            _isPasswordVisible
                ? Icons.visibility
                : Icons.visibility_off,
          ),
          onPressed: () {
            setState(() {
              _isPasswordVisible = !_isPasswordVisible;
            });
          },
        ),
      ),
      obscureText: !_isPasswordVisible,
      validator: FormValidation.validatePassword,
      onChanged: widget.onChanged,
    );
  }
}
