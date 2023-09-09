import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../controller/auth_service.dart';
import 'login_form_field.dart';
import 'package:flutter/services.dart'; // to handle potential platform exceptions

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
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

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

  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );
        final UserCredential authResult =
            await _auth.signInWithCredential(credential);
        final User? user = authResult.user;
        return user;
      }
    } catch (error) {
      print(error);
      return null;
    }
  }

  Future<void> _signInWithGoogle() async {
    try {
      final user = await signInWithGoogle();
      if (user != null) {
        Navigator.of(context).pushReplacementNamed(
            '/home'); // Assuming '/home' is the route for your Home page
      } else {
        // Handle the sign-in failure accordingly
        print('Google sign-in failed');
      }
    } catch (error) {
      print(error);
      if (error is PlatformException) {
        // Show error to the user
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("damn")),
        );
      }
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
                'assets/images/logos/logo_trans_light_mode.png',
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
              const SizedBox(height: 20.0), // add some spacing

              Container(
                constraints: BoxConstraints(
                    maxWidth:
                        200.0), // Adjust the maximum width to your preference
                child: Center(
                  child: ElevatedButton(
                    onPressed: _signInWithGoogle,
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Color.fromARGB(255, 41, 68, 112)),
                      padding: MaterialStateProperty.all<EdgeInsets>(
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                      ),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      elevation: MaterialStateProperty.all<double>(5.0),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          'assets/images/logos/google_logo.png',
                          height: 18.0,
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          'Sign in with Google',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
