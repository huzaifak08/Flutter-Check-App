import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:test_app/API%20Services/user_model.dart';
import 'package:test_app/Widgets/drawer_widget.dart';
import 'package:http/http.dart' as http;

class APIComplexScreen extends StatefulWidget {
  const APIComplexScreen({super.key});

  @override
  State<APIComplexScreen> createState() => APIComplexScreenState();
}

class APIComplexScreenState extends State<APIComplexScreen> {
  List<UserModel> userList = [];

  Future<List<UserModel>> getUserApi() async {
    final response =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));

    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map<String, dynamic> i in data) {
        debugPrint(i['name']);
        userList.add(UserModel.fromJson(i));
      }
      return userList;
    } else {
      return userList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Complex API')),
      drawer: const CustomDrawer(index: 3),
      body: Column(children: [
        Expanded(
            child: FutureBuilder(
          future: getUserApi(),
          builder: (context, AsyncSnapshot<List<UserModel>> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: userList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(snapshot.data![index].name.toString()),
                    subtitle: Text(
                        snapshot.data![index].address!.geo!.lat.toString()),
                  );
                },
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ))
      ]),
    );
  }
}
