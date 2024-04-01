import 'package:flutter/material.dart';

extension SizeExtension on BuildContext {
  SizedBox height(double factor) {
    return SizedBox(height: MediaQuery.of(this).size.height * factor);
  }

  SizedBox width(double factor) {
    return SizedBox(height: MediaQuery.of(this).size.width * factor);
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 100,
            width: 100,
            color: Colors.red,
          ),
          context.height(0.2),
          Container(
            height: 100,
            width: 100,
            color: Colors.yellow,
          ),
        ],
      ),
    );
  }
}
