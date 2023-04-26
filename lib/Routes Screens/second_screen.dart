import 'package:flutter/material.dart';
import 'package:test_app/Routes%20Services/route_name.dart';

class SecondScreen extends StatefulWidget {
  dynamic data;
  SecondScreen({super.key, required this.data});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Second Screen')),
      body: Center(
          child: Column(
        children: [
          Text(widget.data['name']),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, RouteName.thirdScreen);
            },
            child: Text('Screen Three'),
          ),
        ],
      )),
    );
    ;
  }
}
