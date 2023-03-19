import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:test_app/Widgets/drawer_widget.dart';
import 'package:http/http.dart' as http;

import 'API Models/islamic_model.dart';

class APILastJSONScreen extends StatefulWidget {
  const APILastJSONScreen({super.key});

  @override
  State<APILastJSONScreen> createState() => _APILastJSONScreenState();
}

class _APILastJSONScreenState extends State<APILastJSONScreen> {
  Future<IslamicModel> getIslamicApi() async {
    final response = await http.get(
        Uri.parse('https://webhook.site/229e2289-675c-4b26-879d-c7b66b88741f'));

    // This is fake generated link for real link see the comment of part-11 Asif Taj

    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      return IslamicModel.fromJson(data);
    } else {
      return IslamicModel.fromJson(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('API Last JSON')),
      drawer: const CustomDrawer(index: 5),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<IslamicModel>(
              // The data will be stored in Islamic Model from API so we used <IslamicModel>

              future: getIslamicApi(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    // In the API we have a list named 'data'

                    itemCount: snapshot.data!.data!.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        // ignore: prefer_interpolation_to_compose_strings
                        title: Text('Asar Namaz: ' +
                            snapshot.data!.data![index].timings!.asr
                                .toString()),
                        subtitle: Text(snapshot
                            .data!.data![index].date!.gregorian!.date
                            .toString()),

                        // In Case of having a list[] in an object, watch Part-11 of Asif Taj API:
                      );
                    },
                  );
                } else {
                  return Text('Loading');
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
