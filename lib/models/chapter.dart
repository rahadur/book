import 'package:book/models/content.dart';

class Chapter {
  final int id;
  final String title;
  final String content;
  final bool sectionable;
  final List<ChapterContent> contents;

  Chapter({
    required this.id,
    required this.title,
    required this.content,
    required this.sectionable,
    required this.contents,
  });

  factory Chapter.fromJson(Map<String, dynamic> json) {
    var list = json['sections'] as List;
    List<ChapterContent> contentList =
        list.map((c) => ChapterContent.fromJson(c)).toList();

    return Chapter(
      id: json['id'],
      title: json['title'],
      content: json['content'] ?? '',
      sectionable: json['sectionable'],
      contents: contentList,
    );
  }
}
