import 'package:flutter/material.dart';
import 'package:github_api_sample/models/repository_data.dart'; // 独自モデルのインポートを確認

class RepositoryDetailPage extends StatelessWidget {
  final Repository repository;

  const RepositoryDetailPage({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(repository.name),
      ),
      body: SingleChildScrollView( // スクロール可能にする
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: ClipRRect( // アバターの角を丸くする
                  borderRadius: BorderRadius.circular(50.0), // 角の丸み
                  child: Image.network(
                    repository.ownerAvatarUrl,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 20), // スペーシング
              Text(
                'Repository Details',
                style: Theme.of(context).textTheme.titleLarge, // テーマに基づいたスタイル
              ),
              const Divider(), // 区切り線
              DetailItem(icon: Icons.code, text: 'Language: ${repository.language}'),
              DetailItem(icon: Icons.star_border, text: 'Stars: ${repository.stars}'),
              DetailItem(icon: Icons.visibility, text: 'Watchers: ${repository.watchers}'),
              DetailItem(icon: Icons.fork_right, text: 'Forks: ${repository.forks}'),
              DetailItem(icon: Icons.warning, text: 'Open Issues: ${repository.issues}'),
            ],
          ),
        ),
      ),
    );
  }
}

class DetailItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const DetailItem({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Theme.of(context).primaryColor),
          const SizedBox(width: 10), // アイコンとテキストの間隔
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}