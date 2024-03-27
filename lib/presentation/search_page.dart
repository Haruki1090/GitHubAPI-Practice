import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:github_api_sample/main.dart';
import 'package:github_api_sample/models/repository_data.dart'; // Make sure this path is correct
import 'package:github_api_sample/presentation/repository_detail_page.dart'; // Make sure this path is correct
import 'package:http/http.dart' as http;

class SearchPageState extends State<SearchPage> {
  List<Repository> _repositories = [];

  Future<void> searchRepositories(String keyword) async {
    final url = Uri.parse('https://api.github.com/search/repositories?q=$keyword');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> items = data['items'];
      setState(() {
        _repositories = items.map((item) => Repository.fromJson(item)).toList();
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
              itemCount: _repositories.length,
              itemBuilder: (context, index) {
                final repository = _repositories[index];
                return ListTile(
                  title: Text(repository.name),
                  subtitle: Text('Stars: ${repository.stars}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RepositoryDetailPage(repository: repository),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
