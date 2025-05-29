// lib/models/article.dart

class Article {
  final String id;
  final String headline;
  final String description; // Deskripsi singkat untuk daftar
  final String timeAgo;     // Informasi waktu relatif untuk daftar
  final String supportingText; // Teks pendukung di bawah headline pada halaman detail
  final String publishedDate;  // Tanggal publikasi formal
  final String fullContent;    // Isi artikel lengkap

  Article({
    required this.id,
    required this.headline,
    required this.description,
    required this.timeAgo,
    required this.supportingText, // BARU
    required this.publishedDate,  // BARU
    required this.fullContent,    // BARU
  });
}