class ChapterContent {
  final String title;
  final String content;

  ChapterContent({required this.title, required this.content});

  factory ChapterContent.fromJson(Map<String, dynamic> json) {
    return ChapterContent(
      title: json['title'],
      content: json['content'],
    );
  }
}
