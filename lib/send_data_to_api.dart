import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SendDataToAPI extends StatefulWidget {
  const SendDataToAPI({super.key});

  @override
  State<SendDataToAPI> createState() => _SendDataToAPIState();
}

class _SendDataToAPIState extends State<SendDataToAPI> {
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final genderController = TextEditingController();

  Future postSheets(String name, String age, String gender) async {
    try {
      final response = await http.post(
          Uri.parse(
              "https://script.google.com/macros/s/AKfycbzxVtOPhe39508TWkv763EVH-rCWwuOjYnytHSE8RbTV4_7OqUDljW7iupz_SQkPGne/exec"),
          body: jsonEncode({
            'Name': name,
            'Age': age,
            'Gender': gender,
          }));

      debugPrint(response.body);
      if (response.statusCode == 200) {
        debugPrint(jsonEncode(response.body));
      }
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Send Data')),
      body: Column(
        children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(hintText: 'Name'),
          ),
          TextField(
            controller: ageController,
            decoration: const InputDecoration(hintText: 'Age'),
          ),
          TextField(
            controller: genderController,
            decoration: const InputDecoration(hintText: 'Gender'),
          ),
          ElevatedButton(
            onPressed: () async {
              await postSheets(nameController.text, ageController.text,
                      genderController.text)
                  .then((value) {
                Navigator.pop(context);
              });
            },
            child: const Text('Send Data'),
          )
        ],
      ),
    );
  }
}
