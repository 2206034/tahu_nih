class Article {
  final String id;
  final String headline;
  final String description;
  final String timeAgo;
  // Anda bisa menambahkan field lain seperti imageUrl, content, dll.

  Article({
    required this.id,
    required this.headline,
    required this.description,
    required this.timeAgo,
  });
}