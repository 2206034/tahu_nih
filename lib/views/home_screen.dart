import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tahu_nih/routes/route_names.dart';
import 'package:tahu_nih/views/news_detail_screen.dart';
import '../models/article.dart';
import 'detail_screen.dart';
import '../widgets/category_item.dart';
import '../widgets/news_list_item.dart';
import '../services/bookmark_service.dart';
import 'bookmark_screen.dart'; 

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0; 
  late final BookmarkService _bookmarkService; 

  @override
  void initState() {
    super.initState();
    _bookmarkService =
        BookmarkService();
    _bookmarkService.addListener(_onBookmarkChanged);
  }

  @override
  void dispose() {
    _bookmarkService.removeListener(_onBookmarkChanged);
    super.dispose();
  }

  void _onBookmarkChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  void _onItemTapped(int index) {
    if (index == 1) {
      context.goNamed(RouteNames.bookmarks, extra: BookmarkScreenArgs(bookmarkService: _bookmarkService));
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder:
      //         (context) => BookmarkScreen(
      //           bookmarkService: _bookmarkService,
      //         ),
      //   ),
      // );
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final scaffoldBackgroundColor = Theme.of(context).scaffoldBackgroundColor;
    final appBarTheme = Theme.of(context).appBarTheme;
    List<Article> articlesToDisplay = _bookmarkService.allArticles;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            leading: Icon(
              Icons.account_circle_outlined,
              size: 30,
              color: appBarTheme.iconTheme?.color ?? Colors.black,
            ),
            title: Text(
              'TahuNih!',
              style:
                  appBarTheme.titleTextStyle ??
                  const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(60.0),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Cari...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                    contentPadding: const EdgeInsets.symmetric(vertical: 0),
                  ),
                ),
              ),
            ),
            pinned: false,
            floating: true,
            snap: true,
            backgroundColor:
                appBarTheme.backgroundColor ?? scaffoldBackgroundColor,
            elevation: appBarTheme.elevation ?? 0,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric( vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: const Color.fromARGB(255, 27, 95, 177),
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: SizedBox(
                      height: 120,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: const [
                          CategoryItem(
                            iconData: Icons.movie_filter_outlined,
                            label: 'Entertainment',
                          ),
                          CategoryItem(
                            iconData: Icons.music_note_outlined,
                            label: 'Music',
                          ),
                          CategoryItem(
                            iconData: Icons.sports_esports_outlined,
                            label: 'Games',
                          ),
                          CategoryItem(
                            iconData: Icons.article_outlined,
                            label: 'News',
                          ),
                          CategoryItem(
                            iconData: Icons.lightbulb_outline,
                            label: 'Ideas',
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Hot News',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.arrow_forward),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => const DetailScreen(
                                      title: 'Semua Hot News',
                                    ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: articlesToDisplay.length,
                      itemBuilder: (context, index) {
                        final article = articlesToDisplay[index];
                        return NewsListItem(
                          article: article,
                          bookmarkService: _bookmarkService, // Teruskan service
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => NewsDetailScreen(
                                      article: article,
                                      bookmarkService: _bookmarkService,
                                    ),
                              ),
                            );
                          },
                        );
                      },
                      separatorBuilder:
                          (context, index) => const Divider(height: 30),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
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
    );
  }
}
