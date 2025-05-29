import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tahu_nih/routes/route_names.dart';
import 'package:tahu_nih/views/home_screen.dart';
import 'package:tahu_nih/views/news_detail_screen.dart';
import '../models/article.dart';
import '../services/bookmark_service.dart';
import '../widgets/news_list_item.dart';
import 'detail_screen.dart';

class BookmarkScreenArgs {
  final BookmarkService bookmarkService;

  BookmarkScreenArgs({required this.bookmarkService});
}

class BookmarkScreen extends StatefulWidget {
  final BookmarkService bookmarkService;

  const BookmarkScreen({super.key, required this.bookmarkService});

  @override
  State<BookmarkScreen> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  int _selectedIndex = 1;
  // late final BookmarkService _bookmarkService; 

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

  void _onItemTapped(int index) {
    if (index == 0) {
      // Navigator.pop(context); 
      context.goNamed(RouteNames.home);
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  void _onBookmarkChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Article> bookmarkedArticles =
        widget.bookmarkService.bookmarkedArticles;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Bookmarks',
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Fitur edit belum diimplementasikan'),
                ),
              );
            },
          ),
        ],
      ),
      body:
          bookmarkedArticles.isEmpty
              ? const Center(
                child: Text(
                  'No articles bookmarked yet.',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              )
              : ListView.separated(
                padding: const EdgeInsets.all(16.0),
                itemCount: bookmarkedArticles.length,
                itemBuilder: (context, index) {
                  final article = bookmarkedArticles[index];
                  return NewsListItem(
                    article: article,
                    bookmarkService: widget.bookmarkService,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => NewsDetailScreen(
                                article: article,
                                bookmarkService:
                                    widget
                                        .bookmarkService,
                              ),
                        ),
                      );
                    },
                  );
                },
                separatorBuilder: (context, index) => const Divider(),
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
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        onTap: _onItemTapped, 
      ),
      // Tidak ada BottomNavigationBar di sini
    );
  }
}
