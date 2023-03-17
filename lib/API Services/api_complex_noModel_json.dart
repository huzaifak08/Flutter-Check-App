import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:test_app/Widgets/drawer_widget.dart';
import 'package:http/http.dart' as http;

class APIComplexNoModelScreen extends StatefulWidget {
  const APIComplexNoModelScreen({super.key});

  @override
  State<APIComplexNoModelScreen> createState() =>
      _APIComplexNoModelScreenState();
}

class _APIComplexNoModelScreenState extends State<APIComplexNoModelScreen> {
  var data;
  Future<void> getUserApi() async {
    final response =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));

    if (response.statusCode == 200) {
      data = jsonDecode(response.body.toString());
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Custom Complex API')),
      drawer: const CustomDrawer(index: 4),
      body: Column(
        children: [
          Expanded(
              child: FutureBuilder(
            future: getUserApi(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text('Loading');
              } else {
                return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(data[index]['name'].toString()),
                      subtitle: Text(data[index]['address']['city'].toString()),
                    );
                  },
                );
              }
            },
          ))
        ],
      ),
    );
  }
}
