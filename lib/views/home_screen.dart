import 'package:flutter/material.dart';
import 'detail_screen.dart'; // Impor halaman detail yang baru dibuat

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
    // Contoh navigasi dari BottomNavigationBar jika diperlukan:
    // if (index == 1) { // Misal, tab Bookmarks
    //   Navigator.push(
    //     context,
    //     MaterialPageRoute(builder: (context) => const DetailScreen(title: 'Halaman Bookmark')),
    //   );
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.account_circle_outlined, size: 30),
        title: const Text('TahuNih!'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Aksi ketika ikon pencarian ditekan
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
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Bagian Kategori
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

              // Bagian Hot News
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

              // Daftar Berita
              NewsListItem(
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
              const Divider(height: 30),
              NewsListItem(
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
              const Divider(height: 30),
              NewsListItem(
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
               const Divider(height: 30),
              NewsListItem(
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
            ],
          ),
        ),
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

// Widget Kustom untuk Item Kategori
class CategoryItem extends StatelessWidget {
  final IconData iconData;
  final String label;

  const CategoryItem({
    super.key,
    required this.iconData,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell( // Menambahkan InkWell untuk efek sentuhan dan onTap
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailScreen(title: 'Kategori: $label')),
        );
      },
      borderRadius: BorderRadius.circular(15), // Agar efek ripple sesuai dengan bentuk
      child: Container(
        width: 100,
        margin: const EdgeInsets.only(right: 12.0),
        padding: const EdgeInsets.symmetric(vertical: 8.0), // Tambahkan padding agar area tap lebih baik
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Icon(iconData, size: 35, color: Theme.of(context).primaryColor),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

// Widget Kustom untuk Item Daftar Berita
class NewsListItem extends StatelessWidget {
  final String headline;
  final String description;
  final String timeAgo;
  final VoidCallback? onTap; // Tambahkan callback onTap

  const NewsListItem({
    super.key,
    required this.headline,
    required this.description,
    required this.timeAgo,
    this.onTap, // Jadikan onTap opsional
  });

  @override
  Widget build(BuildContext context) {
    return InkWell( // Menambahkan InkWell agar item berita bisa di-tap
      onTap: onTap,
      child: Padding( // Tambahkan padding agar konten tidak terlalu mepet ke tepi saat di-tap
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
                    headline,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    timeAgo,
                    style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}