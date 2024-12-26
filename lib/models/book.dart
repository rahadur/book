import 'package:book/models/author.dart';

class Book {
  final int id;
  final String title;
  final String description;
  final String thumbnail;
  final String? publication;
  final String? published;
  final bool locked;
  final bool audible;
  final bool downloadable;
  final bool featured;
  final Author author;

  Book({
    required this.id,
    required this.title,
    required this.description,
    required this.thumbnail,
    this.publication,
    this.published,
    required this.locked,
    required this.audible,
    required this.downloadable,
    required this.featured,
    required this.author,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      thumbnail: json['thumbnail'],
      publication: json['publication'],
      published: json['published'],
      locked: json['locked'],
      audible: json['audible'],
      downloadable: json['downloadable'],
      featured: json['featured'],
      author: Author.fromJson(json['author']),
    );
  }
}
