import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class SignUpAPI extends StatefulWidget {
  const SignUpAPI({super.key});

  @override
  State<SignUpAPI> createState() => _SignUpAPIState();
}

class _SignUpAPIState extends State<SignUpAPI> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // Register/Login using API (Post)
  void register(String email, String password) async {
    // https://reqres.in/api/login  For Login use this:

    try {
      Response response =
          await post(Uri.parse('https://reqres.in/api/register'), body: {
        'email': email,
        'password': password,
      });

      if (response.statusCode == 200) {
        // to print data:
        var data = jsonDecode(response.body.toString());
        debugPrint(data['token']);

        debugPrint('Account Created Successfully');
      } else {
        debugPrint('Failed to create account');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register Screen using API')),
      body: Column(
        children: [
          TextFormField(
            controller: emailController,
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: passwordController,
          ),
          const SizedBox(height: 40),
          SizedBox(
            width: 200,
            child: ElevatedButton(
              onPressed: () {
                register(emailController.text, passwordController.text);
              },
              child: const Text('Register'),
            ),
          )
        ],
      ),
    );
  }
}
