import 'package:flutter/material.dart';
import '../models/article.dart';
import '../services/bookmark_service.dart';

class NewsDetailScreen extends StatefulWidget {
  final Article article;
  final BookmarkService bookmarkService;

  const NewsDetailScreen({
    super.key,
    required this.article,
    required this.bookmarkService,
  });

  @override
  State<NewsDetailScreen> createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {
  @override
  void initState() {
    super.initState();
    widget.bookmarkService.addListener(_onBookmarkChanged);
  }

  @override
  void dispose() {
    widget.bookmarkService.removeListener(_onBookmarkChanged);
    super.dispose();
  }

  void _onBookmarkChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isBookmarked = widget.bookmarkService.isBookmarked(widget.article.id);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Berita'),
        actions: [
          IconButton(
            icon: Icon(
              isBookmarked ? Icons.bookmark : Icons.bookmark_outline,
              color: isBookmarked ? Theme.of(context).primaryColor : null,
            ),
            onPressed: () {
              widget.bookmarkService.toggleBookmark(widget.article.id);
            },
          ),
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
              widget.article.headline,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),

            // Supporting Text
            Text(
              widget.article.supportingText,
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
            const SizedBox(height: 16.0),

            // Published Date
            Text(
              'Published: ${widget.article.publishedDate}',
              style: TextStyle(fontSize: 12, color: Colors.grey[600], fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 20.0),
            const Divider(),
            const SizedBox(height: 20.0),


            // Full Content
            Text(
              widget.article.fullContent,
              style: const TextStyle(fontSize: 16, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}