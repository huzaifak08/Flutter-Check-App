import 'package:flutter/material.dart';
import 'package:test_app/Services/auth_service.dart';
import 'package:test_app/home.dart';
import 'package:test_app/widgets.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Column(
          children: [
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(hintText: 'Full Name'),
            ),
            const SizedBox(height: 12),
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
                    .registerWithEmailAndPassword(nameController.text,
                        emailController.text, passwordController.text)
                    .then((value) {
                  toastMessage('Account Successfully Created');

                  nextScreenReplacement(context, const HomePage());
                }).onError((error, stackTrace) {
                  toastMessage(error.toString());
                });
              },
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
