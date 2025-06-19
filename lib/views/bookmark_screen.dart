import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tahu_nih/routes/route_names.dart';
import 'package:tahu_nih/services/favorite_service.dart';
import 'package:tahu_nih/services/news_service.dart';
import 'package:tahu_nih/views/home_screen.dart';
import 'package:tahu_nih/views/news_detail_screen.dart';
import '../models/article.dart';
import '../services/bookmark_service.dart';
import '../widgets/news_list_item.dart';

class BookmarkScreen extends StatelessWidget {
  const BookmarkScreen({Key? key}) : super(key: key);

  void _onItemTapped(BuildContext context, int index) {
    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // List<Article> bookmarkedArticles = bookmarkService.bookmarkedArticles;

    return Scaffold(
      appBar: AppBar(title: const Text('My Bookmarks')),
      body: Consumer<FavoriteService>(
        builder: (context, bookmarkService, child) {
          return Consumer<NewsService>(
            builder: (context, newsService, child) {
              final bookmarkedArticles =
                  newsService.allNews
                      .where(
                        (article) => bookmarkService.isBookmarked(article.id!),
                      )
                      .toList();
              return ListView.separated(
                padding: const EdgeInsets.all(16.0),
                itemCount: bookmarkedArticles.length,
                itemBuilder: (context, index) {
                  final article = bookmarkedArticles[index];
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder:
                              (context) => NewsDetailScreen(article: article),
                        ),
                      );
                    },
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
                            child: const Icon(
                              Icons.image_outlined,
                              size: 40,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  article.title,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  article.summary!,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[700],
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  article.author!,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[500],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Tombol Bookmark
                          Consumer<FavoriteService>(
                            builder:
                                (ctx, bookmarkService, child) => IconButton(
                                  icon: Icon(
                                    bookmarkService.isBookmarked(article.id!)
                                        ? Icons.bookmark
                                        : Icons.bookmark_border,
                                    color:
                                        bookmarkService.isBookmarked(
                                              article.id!,
                                            )
                                            ? Theme.of(context).primaryColor
                                            : Colors.grey,
                                  ),
                                  onPressed: () {
                                    bookmarkService.toggleBookmark(article.id!);
                                  },
                                ),
                          ),
                          // IconButton(
                          //   icon: Icon(
                          //     isCurrentlyBookmarked
                          //         ? Icons.bookmark
                          //         : Icons.bookmark_border,
                          //     color:
                          //         isCurrentlyBookmarked
                          //             ? Theme.of(
                          //               context,
                          //             ).primaryColor
                          //             : Colors.grey,
                          //   ),
                          //   onPressed: () {
                          //     bookmarkService.toggleBookmark(
                          //       article.id,
                          //     );
                          //   },
                          // ),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => const Divider(),
              );
            },
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Menu',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_border_outlined),
            activeIcon: Icon(Icons.bookmark),
            label: 'Bookmarks',
          ),
        ],
        currentIndex: 1,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        onTap: (index) => _onItemTapped(context, index),
      ),
    );
  }
}
