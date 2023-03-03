import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:test_app/Services/database_service.dart';
import 'package:test_app/home.dart';
import 'package:test_app/Auth%20Screens/signup_page.dart';
import 'package:test_app/widgets.dart';

import '../Services/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Column(
          children: [
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(hintText: 'Email'),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: passwordController,
              decoration: const InputDecoration(hintText: 'Password'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
                onPressed: () {
                  authService
                      .loginWithEmailAndPassword(
                          emailController.text, passwordController.text)
                      .then((value) {
                    if (value == true) {
                      DatabaseService(
                              uid: FirebaseAuth.instance.currentUser!.uid)
                          .gettingUserData(emailController.text);

                      toastMessage(
                          'Logged in as ${emailController.text.toString()}');
                      nextScreenReplacement(context, const HomePage());
                    } else {
                      toastMessage(value);
                    }
                  });
                },
                child: const Text('Login')),
            const SizedBox(height: 12),
            TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RegisterPage()));
                },
                child: const Text('Create new account'))
          ],
        ),
      ),
    );
  }
}
