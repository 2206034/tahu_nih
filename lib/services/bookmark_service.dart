import 'package:flutter/foundation.dart';
import '../models/article.dart';

class BookmarkService extends ChangeNotifier {
  final List<Article> _allArticles = [
    Article(
      id: '1',
      headline: 'Headline Berita Utama yang Menarik',
      description: 'Deskripsi singkat mengenai isi berita utama ini akan muncul di sini...',
      timeAgo: 'Today • 23 min',
      supportingText: 'Ini adalah teks pendukung untuk berita utama.',
      publishedDate: 'May 30, 2025',
      fullContent: '''
Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.

Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
      '''
    ),
    Article(
      id: '2',
      headline: 'Berita Kedua yang Tak Kalah Penting',
      description: 'Ini adalah deskripsi untuk berita kedua yang juga relevan dan informatif.',
      timeAgo: 'Today • 45 min',
      supportingText: 'Teks pendukung untuk berita kedua yang penting.',
      publishedDate: 'May 30, 2025',
      fullContent: '''
Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.

Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt.
      '''
    ),
    Article(
      id: '3',
      headline: 'Perkembangan Terbaru di Dunia Teknologi',
      description: 'Simak perkembangan teknologi terkini yang bisa mengubah cara kita hidup.',
      timeAgo: 'Yesterday • 10:00 AM',
      supportingText: 'Teknologi terus berkembang pesat setiap harinya.',
      publishedDate: 'May 29, 2025',
      fullContent: 'Konten lengkap tentang perkembangan teknologi...'
    ),
    Article(
      id: '4',
      headline: 'Tips Produktif Selama di Rumah',
      description: 'Beberapa tips yang bisa Anda coba untuk tetap produktif meski bekerja dari rumah.',
      timeAgo: '2 days ago',
      supportingText: 'Produktivitas adalah kunci sukses bekerja dari rumah.',
      publishedDate: 'May 28, 2025',
      fullContent: 'Konten lengkap tentang tips produktif...'
    ),
    Article(
      id: '5',
      headline: 'Resep Masakan Mudah untuk Pemula',
      description: 'Coba resep masakan ini yang mudah dan cepat dibuat, cocok untuk pemula.',
      timeAgo: '3 days ago',
      supportingText: 'Memasak bisa jadi kegiatan yang menyenangkan.',
      publishedDate: 'May 27, 2025',
      fullContent: 'Konten lengkap resep masakan mudah...'
    ),
  ];

  List<Article> get allArticles => _allArticles;

  final Set<String> _bookmarkedArticleIds = {};

  List<Article> get bookmarkedArticles {
    return _allArticles.where((article) => _bookmarkedArticleIds.contains(article.id)).toList();
  }

  bool isBookmarked(String articleId) {
    return _bookmarkedArticleIds.contains(articleId);
  }

  void toggleBookmark(String articleId) {
    if (_bookmarkedArticleIds.contains(articleId)) {
      _bookmarkedArticleIds.remove(articleId);
    } else {
      _bookmarkedArticleIds.add(articleId);
    }
    notifyListeners();
  }
}