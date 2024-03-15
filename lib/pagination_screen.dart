import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PaginationScreen extends StatefulWidget {
  const PaginationScreen({super.key});

  @override
  State<PaginationScreen> createState() => _PaginationScreenState();
}

class _PaginationScreenState extends State<PaginationScreen> {
  final scrollController = ScrollController();
  List postList = [];

  int page = 1;
  bool isLoadingMore = false;

  @override
  void initState() {
    fetchPost();
    scrollController.addListener(_scrollListener);
    super.initState();
  }

  Future<void> fetchPost() async {
    String url =
        "https://techcrunch.com/wp-json/wp/v2/posts?context=embed&per_page=10&page=$page";

    final response = await http.get(Uri.parse(url));

    debugPrint(url);

    final data = jsonDecode(response.body) as List;

    if (response.statusCode == 200) {
      setState(() {
        postList = postList + data;
      });

      // debugPrint(postList.toString());
    }
  }

  Future<void> _scrollListener() async {
    if (isLoadingMore) return;

    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      // Reached to end:
      debugPrint('Call');

      setState(() {
        isLoadingMore = true;
      });

      page++;
      await fetchPost();

      setState(() {
        isLoadingMore = false;
      });
    } else {
      // Not reached to end:
      debugPrint('Not Call');
    }

    // debugPrint('Scrolling');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pagination'),
      ),
      body: ListView.builder(
        controller: scrollController,
        itemCount: isLoadingMore ? postList.length + 1 : postList.length,
        itemBuilder: (context, index) {
          if (index < postList.length) {
            return ListTile(
              leading: CircleAvatar(
                child: Text(index.toString()),
              ),
              title: Text(postList[index]['title'].toString()),
              subtitle: Text(
                  postList[index]['yoast_head_json']['description'].toString()),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
