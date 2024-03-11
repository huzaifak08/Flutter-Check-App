import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:test_app/send_data_to_api.dart';

class GoogleSheetAPI extends StatefulWidget {
  const GoogleSheetAPI({super.key});

  @override
  State<GoogleSheetAPI> createState() => _GoogleSheetAPIState();
}

class _GoogleSheetAPIState extends State<GoogleSheetAPI> {
  List dataList = [];

  @override
  void initState() {
    fetchSheets();

    super.initState();
  }

  Future fetchSheets() async {
    try {
      final response = await http.get(Uri.parse(
          "https://script.google.com/macros/s/AKfycbzxVtOPhe39508TWkv763EVH-rCWwuOjYnytHSE8RbTV4_7OqUDljW7iupz_SQkPGne/exec"));

      if (response.statusCode == 200) {
        dataList = jsonDecode(response.body);
        debugPrint(dataList.toString());
        setState(() {});
      }
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Google Sheet Api')),
      body: ListView.builder(
        itemCount: dataList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(dataList[index]['Name']),
            subtitle: Text(dataList[index]['Gender']),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SendDataToAPI(),
            )),
      ),
    );
  }
}
