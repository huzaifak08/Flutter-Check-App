import 'package:flutter/material.dart';
import 'package:test_app/components/service_locator.dart';
import 'package:test_app/screens/switch_screen.dart';

void main() async {
  await setUpLocator();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SwitchScreen(),
    );
  }
}
