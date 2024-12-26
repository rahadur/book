import 'dart:convert';
import 'package:book/config/environment.dart';
import 'package:book/models/book.dart';
import 'package:book/models/chapter.dart';
import 'package:http/http.dart' as http;

class BookService {
  Future<List<Book>> fetchBooks() async {
    final params = {
      'fields[]': ['*', 'author.id', 'author.name'],
    };

    final response = await http
        .get(Uri.https(Environment.apiBaseUrl, '/items/books', params));
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body)['data'] as List;
      return jsonData.map((json) => Book.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load books');
    }
  }

  Future<List<Book>> fetchBookByIds(List<int> ids) async {
    final params = {
      'fields[]': ['*', 'author.id', 'author.name', 'genre.id', 'genre.title'],
      'filter': '{ "id": { "_in": [${[...ids]}] }  }'
    };

    final response = await http
        .get(Uri.https(Environment.apiBaseUrl, '/items/books', params));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body)['data'] as List;
      return json.map((book) => Book.fromJson(book)).toList();
    } else {
      throw Exception('Failed to load books');
    }
  }

  Future<Book> fetchBook(int bookId) async {
    final params = {
      'fields[]': ['*', 'author.id', 'author.name', 'genre.title']
    };

    final response = await http
        .get(Uri.https(Environment.apiBaseUrl, '/items/books/$bookId', params));
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body)['data'];
      return Book.fromJson(jsonData);
    } else {
      throw Exception('Failed to load books');
    }
  }

  Future<List<Chapter>> fetchChapters(int bookId) async {
    final params = {
      'fields[]': ['*', 'sections.title', 'sections.content'],
      'filter[book][_eq]': '$bookId',
      'sort': 'date_created'
    };

    final response = await http
        .get(Uri.https(Environment.apiBaseUrl, '/items/chapters', params));
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body)['data'] as List;
      return jsonData.map((json) => Chapter.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load chapters');
    }
  }
}
