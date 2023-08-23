import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../view/home_page.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> login(String email, String password, BuildContext context) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => const HomePage()));
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error.toString())),
      );
    }
  }

  Future<void> signup(String email, String password, BuildContext context) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Successfully signed up')),
      );
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => const HomePage()));
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
        const SnackBar(content: Text('An unknown error occurred')),
      );
    }
  }
}
