import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SearchPage(),
    );
  }
}

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  SearchPageState createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  List<String> _repositoryNames = [];

  Future<void> searchRepositories(String keyword) async {
    final url = Uri.parse('https://api.github.com/search/repositories?q=$keyword');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> items = data['items'];
      setState(() {
        _repositoryNames = items.map((item) => item['name'] as String).toList();
      });
    } else {
      throw Exception('Failed to load repository list');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GitHub Repository Search'),
      ),
      body: Column(
        children: [
          TextField(
            onSubmitted: (value) {
              searchRepositories(value);
            },
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _repositoryNames.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_repositoryNames[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
