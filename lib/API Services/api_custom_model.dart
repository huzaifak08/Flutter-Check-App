import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:test_app/API%20Services/api_page.dart';
import 'package:http/http.dart' as http;

import '../home.dart';
import '../widgets.dart';

class APICustomModel extends StatefulWidget {
  const APICustomModel({super.key});

  @override
  State<APICustomModel> createState() => _APICustomModelState();
}

class _APICustomModelState extends State<APICustomModel> {
  List<PhotosModel> photosList = [];
  Future<List<PhotosModel>> getPhotos() async {
    final response = await http
        .get(Uri.parse("https://jsonplaceholder.typicode.com/photos"));
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      for (Map i in data) {
        PhotosModel photosModel =
            PhotosModel(title: i['title'], url: i['url'], id: i['id']);
        photosList.add(photosModel);
      }

      return photosList;
    } else {
      return photosList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('API Custom Photos Model Page'),
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
              ListTile(
                title: const Text('API Page'),
                leading: const Icon(Icons.api),
                onTap: () {
                  nextScreenReplacement(context, const APIScreen());
                },
              ),
              const ListTile(
                title: Text('API Custom Model'),
                leading: Icon(Icons.api_outlined),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getPhotos(),
              builder: (context, AsyncSnapshot<List<PhotosModel>> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: photosList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(snapshot.data![index].title.toString()),
                        subtitle: Text(snapshot.data![index].id.toString()),
                        leading: CircleAvatar(
                            backgroundImage:
                                NetworkImage(snapshot.data![index].url)),
                      );
                    },
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          )
        ],
      ),
    );
  }
}

class PhotosModel {
  int id;
  String title, url;
  PhotosModel({required this.title, required this.url, required this.id});
}
