import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          return await Future.delayed(const Duration(seconds: 2));
        },
        child: ListView.builder(
          itemCount: 20,
          itemBuilder: (context, index) => const ListTile(
            title: Text('Title'),
            subtitle: Text('DEscription'),
          ),
        ),
      ),
    );
  }
}
