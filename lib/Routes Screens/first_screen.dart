import 'package:flutter/material.dart';
import 'package:test_app/Routes%20Services/route_name.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => FirstScreenState();
}

class FirstScreenState extends State<FirstScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('First Screen')),
      body: Center(
          child: ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, RouteName.secondScreen, arguments: {
            'name': 'huzaifa',
            'age': 23,
          });
        },
        child: Text('Screen Two'),
      )),
    );
  }
}
