import 'package:flutter/material.dart';
import 'form_validation.dart';

class EmailInputField extends StatefulWidget {
  final bool rememberEmail;
  final String initialEmail;
  final Function(String) onEmailChanged;

  const EmailInputField({
    required this.rememberEmail,
    required this.initialEmail,
    required this.onEmailChanged,
    Key? key,
  }) : super(key: key);

  @override
  _EmailInputFieldState createState() => _EmailInputFieldState();
}

class _EmailInputFieldState extends State<EmailInputField> {
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(
        text: widget.rememberEmail ? widget.initialEmail : '');
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _emailController,
      decoration: const InputDecoration(
        labelText: 'Email',
        border: OutlineInputBorder(),
      ),
      validator: FormValidation.validateEmail,
      onChanged: widget.onEmailChanged,
    );
  }

  @override
  void didUpdateWidget(EmailInputField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.rememberEmail != widget.rememberEmail ||
        oldWidget.initialEmail != widget.initialEmail) {
      _emailController.text = widget.rememberEmail ? widget.initialEmail : '';
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }
}
