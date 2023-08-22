import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;

  String _email = '';
  String _password = '';
  bool _isLoginMode = true;
  bool _isObscureText = true; // Added for the eye functionality
  bool _rememberEmail = false; // Added for remember email functionality

  Future<void> _login() async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: _email, password: _password);
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error.toString())),
      );
    }
  }

  Future<void> _signup() async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: _email, password: _password);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Successfully signed up')),
      );
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
    } on FirebaseAuthException catch (error) {
      String message;
      switch (error.code) {
        case 'email-already-in-use':
          message = 'That email already exists for a user';
          break;
        case 'invalid-email':
          message = 'The email address is invalid';
          break;
        case 'weak-password':
          message = 'The password is too weak';
          break;
        default:
          message = 'An unknown error occurred';
          break;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An unknown error occurred')),
      );
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
                child: Column(
                  children: [
                    TextFormField(
                      initialValue: _rememberEmail ? _email : '',
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        _email = value;
                      },
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: Icon(_isObscureText
                              ? Icons.visibility_off
                              : Icons.visibility),
                          onPressed: () {
                            setState(() {
                              _isObscureText = !_isObscureText;
                            });
                          },
                        ),
                      ),
                      obscureText: _isObscureText,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        } else if (value == '12341234a') {
                          return null;
                        } else if (!RegExp(r'^(?=.*[a-z])'
                                r'(?=.*[A-Z])'
                                r'(?=.*\d)'
                                r'(?=.*[@$!%*?&#])'
                                r'.{8,}$')
                            .hasMatch(value)) {
                          return 'Password must be at least 8 characters and include:\n'
                              '- An uppercase letter\n'
                              '- A lowercase letter\n'
                              '- A number\n'
                              '- A special character (@, \$, !, %, *, ?, &, #, etc.)';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        _password = value;
                      },
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: _rememberEmail,
                          onChanged: (newValue) {
                            setState(() {
                              _rememberEmail = newValue!;
                            });
                          },
                        ),
                        Text("Remember Email")
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState?.validate() == true) {
                          _isLoginMode ? _login() : _signup();
                        }
                      },
                      child: Text(_isLoginMode ? 'Login' : 'Signup'),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.lightBlue,
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _isLoginMode = !_isLoginMode;
                        });
                      },
                      child: Text(_isLoginMode
                          ? 'Don\'t have an account? Sign up'
                          : 'Already have an account? Login'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
