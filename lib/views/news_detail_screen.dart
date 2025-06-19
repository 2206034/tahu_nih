import 'package:flutter/material.dart';
import 'package:tahu_nih/models/news_article.dart';
import '../models/article.dart';
import '../services/bookmark_service.dart';

class NewsDetailScreen extends StatelessWidget {
  final NewsArticle article;

  const NewsDetailScreen({required this.article, Key? key}) : super(key: key);

  

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Berita'),
        actions: [
          // IconButton(
          //   icon: Icon(
          //     bookmarkService.isBookmarked ? Icons.bookmark : Icons.bookmark_outline,
          //     color: isBookmarked ? Theme.of(context).primaryColor : null,
          //   ),
          //   onPressed: () {
          //     bookmarkService.toggleBookmark(article.id);
          //   },
          // ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: const Icon(Icons.image_outlined, size: 100, color: Colors.grey),
            ),
            const SizedBox(height: 16.0),

            // Headline
            Text(
              article.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),

            // Supporting Text
            Text(
              article.summary!,
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
            const SizedBox(height: 16.0),

            // Published Date
            Text(
              'Author: ${article.author}',
              style: TextStyle(fontSize: 12, color: Colors.grey[600], fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 20.0),
            const Divider(),
            const SizedBox(height: 20.0),

            // Full Content
            Text(
              article.content,
              style: const TextStyle(fontSize: 16, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}