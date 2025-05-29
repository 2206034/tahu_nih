import 'package:flutter/material.dart';
import '../models/article.dart';
import 'detail_screen.dart';
import '../widgets/category_item.dart';
import '../widgets/news_list_item.dart';
import '../services/bookmark_service.dart';
import 'bookmark_screen.dart'; // Impor BookmarkScreen

class HomeScreen extends StatefulWidget {
  // Tidak perlu lagi menerima bookmarkService dari luar jika diinisialisasi di sini
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0; // State untuk BottomNavigationBar
  late final BookmarkService _bookmarkService; // Inisialisasi di initState

  @override
  void initState() {
    super.initState();
    _bookmarkService = BookmarkService(); // Inisialisasi BookmarkService di sini
    _bookmarkService.addListener(_onBookmarkChanged);
  }

  @override
  void dispose() {
    _bookmarkService.removeListener(_onBookmarkChanged);
    // Jika BookmarkService dibuat di sini dan tidak akan digunakan lagi,
    // pertimbangkan untuk menambahkan metode dispose() di BookmarkService jika ada resource yang perlu dilepas.
    // Untuk ChangeNotifier, listener sudah cukup.
    super.dispose();
  }

  void _onBookmarkChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  void _onItemTapped(int index) {
    if (index == 1) { // Indeks untuk Bookmarks
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BookmarkScreen(bookmarkService: _bookmarkService), // Teruskan instance service
        ),
      );
      // Kita tidak mengubah _selectedIndex di sini karena kita navigasi ke halaman baru
      // Jika ingin tab tetap aktif setelah kembali, bisa disimpan _selectedIndex nya
      // Namun, karena ini navigasi push, saat kembali, _selectedIndex lama akan tetap.
    } else {
      // Untuk tab lain (misal "Menu"), kita hanya update index jika ada behavior berbeda
      // atau jika itu mengganti body dari HomeScreen sendiri (bukan navigasi push).
      // Untuk kasus ini, jika index 0 (Menu) adalah HomeScreen itu sendiri,
      // kita bisa pastikan _selectedIndex diatur.
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
        // ... (isi CustomScrollView tetap sama seperti sebelumnya) ...
        slivers: <Widget>[
          SliverAppBar(
            leading: Icon(Icons.account_circle_outlined, size: 30, color: appBarTheme.iconTheme?.color ?? Colors.black),
            title: Text('TahuNih!', style: appBarTheme.titleTextStyle ?? const TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold)),
            actions: [
              IconButton(
                icon: Icon(Icons.search, color: appBarTheme.iconTheme?.color ?? Colors.black),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Fitur pencarian belum diimplementasikan')),
                  );
                },
              ),
            ],
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(60.0),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
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
            backgroundColor: appBarTheme.backgroundColor ?? scaffoldBackgroundColor,
            elevation: appBarTheme.elevation ?? 0,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 120,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: const [
                        CategoryItem(iconData: Icons.movie_filter_outlined, label: 'Entertainment'),
                        CategoryItem(iconData: Icons.music_note_outlined, label: 'Music'),
                        CategoryItem(iconData: Icons.sports_esports_outlined, label: 'Games'),
                        CategoryItem(iconData: Icons.article_outlined, label: 'News'),
                        CategoryItem(iconData: Icons.lightbulb_outline, label: 'Ideas'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Hot News',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        icon: const Icon(Icons.arrow_forward),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const DetailScreen(title: 'Semua Hot News')),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ListView.separated(
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
                            MaterialPageRoute(builder: (context) => DetailScreen(title: article.headline)),
                          );
                        },
                      );
                    },
                    separatorBuilder: (context, index) => const Divider(height: 30),
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
        currentIndex: _selectedIndex, // Gunakan _selectedIndex lokal
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        onTap: _onItemTapped, // Panggil method _onItemTapped
      ),
    );
  }
}