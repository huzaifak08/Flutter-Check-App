import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:test_app/home.dart';
import 'package:test_app/widgets.dart';
import 'package:http/http.dart' as http;

import 'api_custom_model.dart';
import 'models.dart';

class APIScreen extends StatefulWidget {
  const APIScreen({super.key});

  @override
  State<APIScreen> createState() => _APIScreenState();
}

class _APIScreenState extends State<APIScreen> {
  // If the JSON data is in List(Array) and don't have any name of List(Array) then use this method:

  List<PostModel> postList = [];

  Future<List<PostModel>> getPostApi() async {
    // Use this incase if you have json data in list:
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    var data = jsonDecode(response.body.toString());

    // 200 means that JSON data is OK and good to use:
    if (response.statusCode == 200) {
      postList.clear(); // Now the data will not start after last index:
      // For Each Loop:
      for (Map<String, dynamic> i in data) {
        postList.add(PostModel.fromJson(i));
      }
      return postList;
    } else {
      return postList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('API Page'),
      ),
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            children: [
              ListTile(
                title: const Text('Firebase Page'),
                leading: const Icon(Icons.home),
                onTap: () {
                  nextScreenReplacement(context, const HomePage());
                },
              ),
              const ListTile(
                title: Text('API Page'),
                leading: Icon(Icons.api),
              ),
              ListTile(
                title: const Text('API Custom Model'),
                leading: const Icon(Icons.api_outlined),
                onTap: () {
                  nextScreenReplacement(context, const APICustomModel());
                },
              ),
            ],
          ),
        ),
      ),
      body: FutureBuilder(
        future: getPostApi(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: postList.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('ID: ' + postList[index].id.toString()),
                      Text('Title: ' + postList[index].title.toString()),
                    ],
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}