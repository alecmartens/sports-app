import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../controller/auth_service.dart';
import 'form_validation.dart';
import 'login_form_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final AuthService _authService = AuthService();

  String _email = '';
  String _password = '';
  bool _isLoginMode = true;
  bool _isObscureText = true;
  bool _rememberEmail = false;

  // // 1. Separate UI elements
  // Widget _buildEmailField() {
  //   return TextFormField(
  //     initialValue: _rememberEmail ? _email : '',
  //     decoration: const InputDecoration(
  //       labelText: 'Email',
  //       border: OutlineInputBorder(),
  //     ),
  //     validator: FormValidation.validateEmail,
  //     onChanged: (value) => _email = value,
  //   );
  // }

  // Widget _buildPasswordField() {
  //   return TextFormField(
  //     decoration: InputDecoration(
  //       labelText: 'Password',
  //       border: OutlineInputBorder(),
  //       suffixIcon: IconButton(
  //         icon: Icon(
  //           _isObscureText ? Icons.visibility_off : Icons.visibility,
  //         ),
  //         onPressed: _togglePasswordVisibility,
  //       ),
  //     ),
  //     obscureText: _isObscureText,
  //     validator: FormValidation.validatePassword,
  //     onChanged: (value) => _password = value,
  //   );
  // }

  // 2. Separate methods for event handlers
  void _toggleLoginMode() {
    setState(() => _isLoginMode = !_isLoginMode);
  }

  void _togglePasswordVisibility() {
    setState(() => _isObscureText = !_isObscureText);
  }

  void _updateRememberEmail(bool? newValue) {
    setState(() => _rememberEmail = newValue!);
  }

  Future<void> _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      await _authService.login(_email, _password, context);
    }
  }

  Future<void> _handleSignup() async {
    if (_formKey.currentState!.validate()) {
      await _authService.signup(_email, _password, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(
                'assets/images/logos/big_monke.png',
                height: 150.0,
              ),
              const SizedBox(height: 50.0),
              Form(
                key: _formKey,
                child: LoginFormField(
                  onEmailChanged: (value) => _email = value,
                  onPasswordChanged: (value) => _password = value,
                  onRememberEmailChanged: _updateRememberEmail,
                  onLoginPressed: _handleLogin,
                  onSignupPressed: _handleSignup,
                  isLoginMode: _isLoginMode,
                  isObscureText: _isObscureText,
                  rememberEmail: _rememberEmail,
                  initialEmail: _email,
                  toggleLoginMode: _toggleLoginMode,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
