import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ParallelApiCall extends StatefulWidget {
  const ParallelApiCall({super.key});

  @override
  State<ParallelApiCall> createState() => _ParallelApiCallState();
}

class _ParallelApiCallState extends State<ParallelApiCall> {
  List postList = [];
  Map postMap = {};

  @override
  void initState() {
    parallelApiCall();

    super.initState();
  }

  Future parallelApiCall() async {
    final response = await Future.wait([
      http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts")),
      http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts/1")),
    ]);

    if (response[0].statusCode == 200 && response[1].statusCode == 200) {
      postList = jsonDecode(response[0].body);
      postMap = jsonDecode(response[1].body);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Parallel API Call'),
      ),
      body: ListView.builder(
        itemCount: postList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(postList[index]['title']),
            subtitle: Text(postMap['title']),
          );
        },
      ),
    );
  }
}
