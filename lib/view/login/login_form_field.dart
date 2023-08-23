import 'package:flutter/material.dart';
import 'form_validation.dart';
import 'email_input_field.dart';
import 'password_input_field.dart';

class LoginFormField extends StatefulWidget {
  final Function(String) onEmailChanged;
  final Function(String) onPasswordChanged;
  final Function(bool) onRememberEmailChanged;
  final Function() onLoginPressed;
  final Function() onSignupPressed;
  final Function() toggleLoginMode;
  final bool isLoginMode;
  final bool isObscureText;
  final bool rememberEmail;
  final String initialEmail;

  const LoginFormField({
    required this.onEmailChanged,
    required this.onPasswordChanged,
    required this.onRememberEmailChanged,
    required this.isLoginMode,
    required this.isObscureText,
    required this.rememberEmail,
    required this.initialEmail,
    required this.onLoginPressed,
    required this.onSignupPressed,
    required this.toggleLoginMode,
    Key? key,
  }) : super(key: key);

  @override
  _LoginFormFieldState createState() => _LoginFormFieldState();
}

class _LoginFormFieldState extends State<LoginFormField> {
  bool _isPasswordVisible = false; // Track the password visibility state

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        EmailInputField(
          rememberEmail: widget.rememberEmail,
          initialEmail: widget.initialEmail,
          onEmailChanged: widget.onEmailChanged,
        ),
        const SizedBox(height: 20.0),
        PasswordInputField(
          onChanged: widget.onPasswordChanged,
        ),
        Row(
          children: [
            Checkbox(
              value: widget.rememberEmail,
              onChanged: (newValue) => widget.onRememberEmailChanged(newValue!),
            ),
            Text("Remember Email")
          ],
        ),
        const SizedBox(height: 20.0),
        ElevatedButton(
          onPressed: widget.isLoginMode
              ? widget.onLoginPressed
              : widget.onSignupPressed,
          child: Text(widget.isLoginMode ? 'Login' : 'Signup'),
        ),
        TextButton(
          onPressed: widget.toggleLoginMode,
          child: Text(widget.isLoginMode
              ? 'Don\'t have an account? Sign up'
              : 'Already have an account? Login'),
        ),
      ],
    );
  }
}
