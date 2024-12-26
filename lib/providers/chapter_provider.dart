import 'package:book/models/chapter.dart';
import 'package:book/services/book_service.dart';
import 'package:flutter/material.dart';

class ChapterProvider with ChangeNotifier {
  List<Chapter> _chapters = [];
  Chapter? _selectedChapter;
  bool isLoading = false;

  final _bookService = BookService();

  List<Chapter> get chapters => _chapters;
  Chapter? get selectedChapter => _selectedChapter;

  Future<void> fetchChapters(int bookId) async {
    isLoading = true;
    _chapters = await _bookService.fetchChapters(bookId);
    isLoading = false;
    notifyListeners();
  }

  void selectChapter(Chapter chapter) {
    _selectedChapter = chapter;
    notifyListeners();
  }
}
