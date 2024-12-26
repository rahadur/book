class AppInfo {
  final String id;
  final String title;
  final String description;
  final String status;
  final int book;
  final List<int> related_books;
  final List<int> books;
  final String playstore_url;
  final String playsotre_rating_url;
  final String appstore_url;

  AppInfo({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.book,
    required this.related_books,
    required this.books,
    required this.playstore_url,
    required this.playsotre_rating_url,
    required this.appstore_url,
  });

  factory AppInfo.fromJson(Map<String, dynamic> json) {
    var list = json['related_books'] as List;
    List<int> relatedBookList = list.map((c) => c['book'] as int).toList();
    list = json['books'] as List;
    List<int> moreBookList = list.map((c) => c['book'] as int).toList();

    return AppInfo(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      status: json['status'],
      book: json['book'],
      related_books: relatedBookList,
      books: moreBookList,
      playstore_url: json['playstore_url'],
      playsotre_rating_url: json['playsotre_rating_url'],
      appstore_url: json['appstore_url'] ?? '',
    );
  }
}
