import 'package:flutter/material.dart';
import 'email_input_field.dart';
import 'password_input_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
  final String userId;

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
    required this.userId,
    Key? key,
  }) : super(key: key);

  @override
  _LoginFormFieldState createState() => _LoginFormFieldState();
}

void storeEmail(String userId, String email) async {
  if (userId.isEmpty) {
    print("storeEmail Error: userId is empty.");
    return;
  }
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  await users.doc(userId).set({
    'email': email,
  });
}

Future<String?> retrieveEmail(String userId) async {
  if (userId.isEmpty) {
    print("retrieveEmail Error: userId is empty.");
    return null;
  }
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  DocumentSnapshot doc = await users.doc(userId).get();

  if (doc.exists) {
    print(doc['email']);
    return doc['email'];
  } else {
    return null;
  }
}

class _LoginFormFieldState extends State<LoginFormField> {
  final bool _isPasswordVisible = false; // Track the password visibility state
  String _currentEmail = ''; // To store the current email input

  @override
  void initState() {
    super.initState();
    if (widget.rememberEmail) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _loadStoredEmail());
    }
  }

  Future<void> _loadStoredEmail() async {
    String? email = await retrieveEmail(widget.userId);
    if (email != null) {
      setState(() {
        _currentEmail = email;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        EmailInputField(
          rememberEmail: widget.rememberEmail,
          initialEmail: _currentEmail, //widget.initialEmail,
          onEmailChanged: (email) {
            _currentEmail = email;
            widget.onEmailChanged(email);
          },
        ),
        const SizedBox(height: 20.0),
        PasswordInputField(
          onChanged: widget.onPasswordChanged,
        ),
        // Row(
        //   children: [
        // Checkbox(
        //   value: widget.rememberEmail,
        //   onChanged: (newValue) {
        //     if (newValue!) {
        //       widget.onRememberEmailChanged(true);
        //       _loadStoredEmail(); // Ensure you reload the email if checkbox is checked
        //     } else {
        //       widget.onRememberEmailChanged(false);
        //     }
        //   },
        // ),
        // const Text("Remember Email")
        //   ],
        // ),
        const SizedBox(height: 20.0),
        ElevatedButton(
          onPressed: () {
            if (widget.isLoginMode) {
              widget.onLoginPressed();
              if (widget.rememberEmail) {
                storeEmail(widget.userId, _currentEmail);
              }
            } else {
              widget.onSignupPressed();
              if (widget.rememberEmail) {
                storeEmail(widget.userId, _currentEmail);
              }
            }
          },
          child: Text(widget.isLoginMode ? 'Login' : 'Sign Up'),
        ),
        const SizedBox(height: 10.0),
        TextButton(
          onPressed: widget.toggleLoginMode,
          child: Text(
            widget.isLoginMode
                ? 'Don\'t have an account? Sign up'
                : 'Already have an account? Login',
          ),
        ),
      ],
    );
  }
}
