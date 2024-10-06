// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:test_app/app_data.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Singletons"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            AppData.instance;

            AppData appData = AppData.instance;
            print(appData.userId);
          },
          child: const Text("Call Class"),
        ),
      ),
    );
  }
}
