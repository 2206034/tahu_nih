import 'package:flutter/material.dart';
import 'detail_screen.dart';
import '../widgets/category_item.dart';
import '../widgets/news_list_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const DetailScreen(title: 'Halaman Bookmark')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Dapatkan warna latar belakang scaffold dari tema
    final scaffoldBackgroundColor = Theme.of(context).scaffoldBackgroundColor;
    // Dapatkan tema AppBar dari tema utama
    final appBarTheme = Theme.of(context).appBarTheme;


    return Scaffold(
      // appBar: AppBar(...), // AppBar standar dihapus dari sini
      body: CustomScrollView(
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
            pinned: false,  // Membuat AppBar tidak menempel di atas
            floating: true, // Membuat AppBar muncul kembali saat scroll ke atas
            snap: true,     // Membuat AppBar "snap" ke tempatnya saat muncul/hilang
            backgroundColor: appBarTheme.backgroundColor ?? scaffoldBackgroundColor, // Samakan dengan warna AppBar atau Scaffold
            elevation: appBarTheme.elevation ?? 0, // Samakan dengan elevasi AppBar sebelumnya
          ),
          SliverToBoxAdapter( // Untuk membungkus konten non-sliver
            child: Padding(
              padding: const EdgeInsets.symmetric( vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Bagian Kategori
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    color: const Color.fromARGB(255, 27, 95, 177),
                    child: SizedBox(
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
                  ),
                  const SizedBox(height: 24),

                  // Bagian Hot News
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
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
                  ),
                  const SizedBox(height: 16),

                  // Daftar Berita
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: NewsListItem(
                      headline: 'Headline Berita Utama yang Menarik',
                      description: 'Deskripsi singkat mengenai isi berita utama ini akan muncul di sini...',
                      timeAgo: 'Today • 23 min',
                      onTap: () {
                         Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const DetailScreen(title: 'Headline Berita Utama yang Menarik')),
                        );
                      }
                    ),
                  ),
                  const Divider(height: 30),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: NewsListItem(
                      headline: 'Berita Kedua yang Tak Kalah Penting',
                      description: 'Ini adalah deskripsi untuk berita kedua yang juga relevan dan informatif.',
                      timeAgo: 'Today • 45 min',
                       onTap: () {
                         Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const DetailScreen(title: 'Berita Kedua yang Tak Kalah Penting')),
                        );
                      }
                    ),
                  ),
                  const Divider(height: 30),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: NewsListItem(
                      headline: 'Perkembangan Terbaru di Dunia Teknologi',
                      description: 'Simak perkembangan teknologi terkini yang bisa mengubah cara kita hidup.',
                      timeAgo: 'Yesterday • 10:00 AM',
                       onTap: () {
                         Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const DetailScreen(title: 'Perkembangan Terbaru di Dunia Teknologi')),
                        );
                      }
                    ),
                  ),
                   const Divider(height: 30),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: NewsListItem(
                      headline: 'Tips Produktif Selama di Rumah',
                      description: 'Beberapa tips yang bisa Anda coba untuk tetap produktif meski bekerja dari rumah.',
                      timeAgo: '2 days ago',
                       onTap: () {
                         Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const DetailScreen(title: 'Tips Produktif Selama di Rumah')),
                        );
                      }
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