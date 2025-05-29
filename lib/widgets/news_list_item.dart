import 'package:flutter/material.dart';
import '../models/article.dart';
import '../services/bookmark_service.dart';

class NewsListItem extends StatelessWidget {
  final Article article;
  final BookmarkService bookmarkService; 
  final VoidCallback? onTap;

  const NewsListItem({
    super.key,
    required this.article,
    required this.bookmarkService,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isCurrentlyBookmarked = bookmarkService.isBookmarked(article.id);

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.image_outlined, size: 40, color: Colors.grey),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.headline,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    article.description,
                    style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    article.timeAgo,
                    style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                  ),
                ],
              ),
            ),
            // Tombol Bookmark
            IconButton(
              icon: Icon(
                isCurrentlyBookmarked ? Icons.bookmark : Icons.bookmark_border,
                color: isCurrentlyBookmarked ? Theme.of(context).primaryColor : Colors.grey,
              ),
              onPressed: () {
                bookmarkService.toggleBookmark(article.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}