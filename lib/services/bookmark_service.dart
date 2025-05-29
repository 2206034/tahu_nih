import 'package:flutter/foundation.dart'; // Untuk ChangeNotifier
import '../models/article.dart';

class BookmarkService extends ChangeNotifier {
  // Daftar semua artikel (untuk demo)
  final List<Article> _allArticles = [
    Article(id: '1', headline: 'Headline Berita Utama yang Menarik', description: 'Deskripsi singkat mengenai isi berita utama ini akan muncul di sini...', timeAgo: 'Today • 23 min'),
    Article(id: '2', headline: 'Berita Kedua yang Tak Kalah Penting', description: 'Ini adalah deskripsi untuk berita kedua yang juga relevan dan informatif.', timeAgo: 'Today • 45 min'),
    Article(id: '3', headline: 'Perkembangan Terbaru di Dunia Teknologi', description: 'Simak perkembangan teknologi terkini yang bisa mengubah cara kita hidup.', timeAgo: 'Yesterday • 10:00 AM'),
    Article(id: '4', headline: 'Tips Produktif Selama di Rumah', description: 'Beberapa tips yang bisa Anda coba untuk tetap produktif meski bekerja dari rumah.', timeAgo: '2 days ago'),
    Article(id: '5', headline: 'Resep Masakan Mudah untuk Pemula', description: 'Coba resep masakan ini yang mudah dan cepat dibuat, cocok untuk pemula.', timeAgo: '3 days ago'),
  ];

  List<Article> get allArticles => _allArticles;

  // Set untuk menyimpan ID artikel yang di-bookmark agar efisien
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
    notifyListeners(); // Memberi tahu listener bahwa ada perubahan
  }
}