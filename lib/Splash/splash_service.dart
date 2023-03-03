import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_app/home.dart';
import 'package:test_app/Auth%20Screens/login_page.dart';
import 'package:test_app/widgets.dart';

class SplashServices {
  void isLogin(BuildContext context) {
    final auth = FirebaseAuth.instance;

    final user = auth.currentUser;

    if (user != null) {
      // If user is already login:

      Timer(const Duration(seconds: 3),
          () => nextScreenReplacement(context, const HomePage()));
    } else {
      // if user is not login:

      Timer(const Duration(seconds: 3),
          () => nextScreenReplacement(context, const LoginPage()));
    }
  }
}
