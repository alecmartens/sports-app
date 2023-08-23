import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../controller/auth_service.dart';
import 'login_form_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final AuthService _authService = AuthService();
  String _userId = '';
  StreamSubscription<User?>? _authStateSubscription;

  String _email = '';
  String _password = '';
  bool _isLoginMode = true;
  bool _isObscureText = true;
  bool _rememberEmail = false;

  @override
  void initState() {
    super.initState();
    _loadEmailFromPreferences();
    _authStateSubscription =
        _authService.auth.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in! UID: ${user.uid}');
        setState(() {
          _userId = user.uid;
        });
      }
    });
  }

  @override
  void dispose() {
    _authStateSubscription?.cancel();
    super.dispose();
  }

  void _loadEmailFromPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final savedEmail = prefs.getString('email');
    if (savedEmail != null) {
      setState(() {
        _email = savedEmail;
      });
    }
  }

  Future<void> _saveEmailToPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', _email);
  }

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
      if (_rememberEmail) {
        await _saveEmailToPreferences();
      }
      await _authService.login(_email, _password, context);
    }
  }

  Future<void> _handleSignup() async {
    if (_formKey.currentState!.validate()) {
      if (_rememberEmail) {
        await _saveEmailToPreferences();
      }
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
                  userId: _authService.auth.currentUser?.uid ?? '',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
