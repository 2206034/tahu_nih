import 'package:flutter/material.dart';
import 'package:tahu_nih/views/home_screen.dart';
// pastikan path import model article sudah benar
import '../models/article.dart'; 
import '../services/bookmark_service.dart';
import '../widgets/news_list_item.dart';
import 'detail_screen.dart';

class BookmarkScreen extends StatefulWidget {
  final BookmarkService bookmarkService;

  const BookmarkScreen({super.key, required this.bookmarkService});

  @override
  State<BookmarkScreen> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  int _selectedIndex = 1; // State untuk BottomNavigationBar
  late final BookmarkService _bookmarkService; // Inisialisasi di initState


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
    if (index == 0) { // Indeks untuk Bookmarks
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(), // Teruskan instance service
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

  void _onBookmarkChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  

  @override
  Widget build(BuildContext context) {
    List<Article> bookmarkedArticles = widget.bookmarkService.bookmarkedArticles;

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Bookmarks'), // Tombol kembali akan otomatis ditambahkan oleh Navigator
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Fitur edit belum diimplementasikan')),
              );
            },
          ),
        ],
      ),
      body: bookmarkedArticles.isEmpty
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
                        builder: (context) => DetailScreen(title: article.headline),
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
        currentIndex: _selectedIndex, // Gunakan _selectedIndex lokal
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        onTap: _onItemTapped, // Panggil method _onItemTapped
      ),
      // Tidak ada BottomNavigationBar di sini
    );
  }
}